import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:moment_dart/moment_dart.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_common.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/habit_entity.dart';
import '../blocs/share_habit/share_habit_bloc.dart';

// TODO: ADD TEXT AND REQUEST STORE PERMISSION
class SocialShareHabitTemplate extends StatelessWidget {
  final HabitEntity habit;
  final GlobalKey screenshotKey;

  const SocialShareHabitTemplate({
    required this.habit,
    required this.screenshotKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<ShareHabitBloc, ShareHabitState>(
        listener: (ctx, state) async {
          if (state is ShareHabitLoading) {
            SmartDialog.showLoading(
              clickMaskDismiss: false,
              builder: (_) => SizedBox(
                height: 200,
                width: 200,
                child: LoadingIndicator(indicatorType: Indicator.pacman),
              ),
            );
          } else {
            SmartDialog.dismiss();
          }

          if (state is ShareHabitFailure) {
            final alertDialog = AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              headerAnimationLoop: false,
              title: S.current.failure_title,
              desc: state.error,
            )..show();

            await Future.delayed(AppCommons.alertShowDuration);
            alertDialog.dismiss();
          } else if (state is SaveSuccess) {
            final alertDialog = AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              headerAnimationLoop: false,
              title: S.current.success_title,
            )..show();

            await Future.delayed(const Duration(seconds: 3));
            alertDialog.dismiss();
          }
        },
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                RepaintBoundary(
                  key: screenshotKey,
                  child: Container(
                    width: 960,
                    height: 960,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.indigo.shade50,
                          Colors.purple.shade50,
                          Colors.pink.shade50,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.marginXL),
                      child: Column(
                        children: [
                          // Header with App Branding
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.indigo[600],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.marginS),
                                  const Text(
                                    AppCommons.appName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '@${AppCommons.shortAppName}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Main Card
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: .8),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: .1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Category Badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: habit.habitCategory.color
                                          .withValues(alpha: .2),
                                      borderRadius: BorderRadius.circular(
                                          AppSpacing.radiusL),
                                    ),
                                    child: Text(
                                      habit.habitCategory.name
                                          .toUpperCaseFirstLetter,
                                      style: TextStyle(
                                        color: habit.habitCategory.color,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.marginL),

                                  // Habit Title
                                  Text(
                                    habit.habitTitle,
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 5,
                                  ),
                                  const SizedBox(height: AppSpacing.marginL),

                                  // Streak Cards
                                  Column(
                                    children: [
                                      _buildStreakCard(
                                        S.current.current_streak,
                                        habit.currentStreak.toString(),
                                        [
                                          Colors.purple[500]!,
                                          Colors.purple[500]!
                                        ],
                                        Icons.local_fire_department,
                                      ),
                                      const SizedBox(
                                          height: AppSpacing.marginS),
                                      _buildStreakCard(
                                        S.current.longest_streak,
                                        '${habit.longestStreak}',
                                        [Colors.blue[500]!, Colors.cyan[500]!],
                                        Icons.emoji_events,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppSpacing.marginL),

                                  // Progress Bar
                                  _buildProgressBar(habit.habitProgress),
                                  const SizedBox(height: AppSpacing.marginL),

                                  // Stats Grid
                                  Column(
                                    children: [
                                      _buildStatCard(
                                        S.current.start_date,
                                        habit.startDate.toMoment().formatDate(),
                                        Icons.calendar_today,
                                      ),
                                      const SizedBox(
                                          height: AppSpacing.marginL),
                                      _buildStatCard(
                                        S.current.end_date,
                                        habit.endDate.toMoment().formatDate(),
                                        Icons.calendar_today,
                                      ),
                                      const SizedBox(
                                          height: AppSpacing.marginL),
                                      _buildStatCard(
                                        S.current.habit_goal,
                                        habit.habitGoal.target,
                                        Icons.track_changes,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),

                          // Footer
                          Column(
                            children: [
                              Text(
                                S.current.try_app_desc(AppCommons.appName),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.current.try_app_now,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.marginS),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[500],
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.marginS),
                                  Text(
                                    '${AppCommons.shortAppName}.app',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStreakCard(
    String title,
    String value,
    List<Color> gradientColors,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.paddingM),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: AppSpacing.marginS),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: AppFontSize.h3,
                ),
                overflow: TextOverflow.visible,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.marginS),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.marginS),
        Container(
          height: 12,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(6),
          ),
          child: FractionallySizedBox(
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green[400]!,
                    Colors.lightGreen[500]!,
                  ],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.paddingS),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: AppSpacing.marginS),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor:
          context.isDarkMode ? AppColors.darkText : Colors.transparent,
      iconTheme: IconThemeData(
        color: context.isDarkMode ? AppColors.lightText : AppColors.darkText,
      ),
      actions: [
        IconButton(onPressed: () => _onShare(context), icon: Icon(Icons.share)),
      ],
    );
  }

  void _onShare(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<ShareHabitBloc>(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () => _onShared(context),
                leading: Icon(FontAwesomeIcons.shareNodes, color: Colors.black),
                title: Text(
                  S.current.share_button,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () => _onSaveImage(context),
                leading: Icon(FontAwesomeIcons.floppyDisk, color: Colors.black),
                title: Text(
                  S.current.store_image_to_device_button,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onShared(BuildContext context) {
    Navigator.pop(context);
    context.read<ShareHabitBloc>().add(
        ShareHabitToSocial(screenshotKey: screenshotKey, context: context));
  }

  void _onSaveImage(BuildContext context) {
    Navigator.pop(context);
    context
        .read<ShareHabitBloc>()
        .add(SaveImage(screenshotKey: screenshotKey, context: context));
  }
}
