import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class SocialShareHabitTemplate extends StatefulWidget {
  final HabitEntity habit;
  final GlobalKey screenshotKey;

  const SocialShareHabitTemplate({
    required this.habit,
    required this.screenshotKey,
    super.key,
  });

  @override
  State<SocialShareHabitTemplate> createState() =>
      _SocialShareHabitTemplateState();
}

class _SocialShareHabitTemplateState extends State<SocialShareHabitTemplate> {
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<ShareHabitBloc, ShareHabitState>(
        listener: (ctx, state) async {
          if (state is ShareHabitFailure) {
            final alertDialog = AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              headerAnimationLoop: false,
              title: S.current.failure_title,
              desc: state.error,
              descTextStyle: TextStyle(overflow: TextOverflow.visible),
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
            child: RepaintBoundary(
              key: widget.screenshotKey,
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
                                  color: Colors.black,
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
                                  color: widget.habit.habitCategory.color
                                      .withValues(alpha: .2),
                                  borderRadius:
                                      BorderRadius.circular(AppSpacing.radiusL),
                                ),
                                child: Text(
                                  widget.habit.habitCategory.name
                                      .toUpperCaseFirstLetter,
                                  style: TextStyle(
                                    color: widget.habit.habitCategory.color,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppSpacing.marginL),

                              // Habit Title
                              Text(
                                widget.habit.habitTitle,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                maxLines: 5,
                              ),
                              const SizedBox(height: AppSpacing.marginL),

                              // Streak Cards
                              Column(
                                children: [
                                  _buildStreakCard(
                                    S.current.current_streak,
                                    widget.habit.currentStreak.toString(),
                                    [Colors.purple[500]!, Colors.purple[500]!],
                                    Icons.local_fire_department,
                                  ),
                                  const SizedBox(height: AppSpacing.marginS),
                                  _buildStreakCard(
                                    S.current.longest_streak,
                                    '${widget.habit.longestStreak}',
                                    [Colors.blue[500]!, Colors.cyan[500]!],
                                    Icons.emoji_events,
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.marginL),

                              // Progress Bar
                              _buildProgressBar(widget.habit.habitProgress),
                              const SizedBox(height: AppSpacing.marginL),

                              // Stats Grid
                              Column(
                                children: [
                                  _buildStatCard(
                                    S.current.start_date,
                                    widget.habit.startDate
                                        .toMoment()
                                        .formatDate(),
                                    Icons.calendar_today,
                                  ),
                                  const SizedBox(height: AppSpacing.marginL),
                                  _buildStatCard(
                                    S.current.end_date,
                                    widget.habit.endDate
                                        .toMoment()
                                        .formatDate(),
                                    Icons.calendar_today,
                                  ),
                                  const SizedBox(height: AppSpacing.marginL),
                                  _buildStatCard(
                                    S.current.habit_goal,
                                    widget.habit.habitGoal.target,
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
              S.current.progress_section,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
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
                  color: Colors.black,
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
        IconButton(
            onPressed: () => _onPickMethod(context), icon: Icon(Icons.share)),
      ],
    );
  }

  void _onPickMethod(BuildContext context) {
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
                leading: Icon(FontAwesomeIcons.shareNodes),
                title: Text(
                  S.current.share_button,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                onTap: () => _onSaveImage(context),
                leading: Icon(FontAwesomeIcons.floppyDisk),
                title: Text(
                  S.current.store_image_to_device_button,
                  style: TextStyle(
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

    showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.paddingS),
          child: Column(
            children: [
              TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: S.current.write_your_message,
                ),
              ),
              const SizedBox(height: AppSpacing.marginS),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<ShareHabitBloc>().add(ShareHabitToSocial(
                      screenshotKey: widget.screenshotKey,
                      context: context,
                      content: _contentController.text));
                },
                child: Text(
                  S.current.share_button,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // context.read<ShareHabitBloc>().add(
    //     ShareHabitToSocial(screenshotKey: screenshotKey, context: context));
  }

  void _onSaveImage(BuildContext context) {
    Navigator.pop(context);
    context
        .read<ShareHabitBloc>()
        .add(SaveImage(screenshotKey: widget.screenshotKey, context: context));
  }
}
