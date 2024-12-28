import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_common.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/day_status.dart';
import '../../../../core/enums/habit/goal_type.dart';
import '../../../../core/enums/habit/habit_frequency.dart';
import '../../../../core/enums/habit/habit_icon.dart';
import '../../../../core/enums/habit/habit_status.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/num_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/helpers/date_time_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/confirm_delete_dialog.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';
import '../../../shared/presentations/widgets/text_with_circle_border_container.dart';
import '../../domain/entities/habit_entity.dart';
import '../../domain/entities/habit_history.dart';
import '../blocs/crud/habit_crud_bloc.dart';
import '../widgets/crud_habit/edit_template_dialog.dart';
import '../widgets/generated_habit.dart';
import '../widgets/habit_section_container.dart';
import '../widgets/habit_streak_calendar.dart';
import '../widgets/reminder_section_item.dart';
import '../widgets/trackers/habit_tracker.dart';

class HabitDetailPage extends StatefulWidget {
  final HabitEntity habit;
  const HabitDetailPage({
    super.key,
    required this.habit,
  });

  @override
  State<HabitDetailPage> createState() => _HabitDetailPageState();
}

class _HabitDetailPageState extends State<HabitDetailPage> {
  late HabitEntity currentHabit;
  List<HabitHistory> histories = [];

  @override
  initState() {
    super.initState();
    currentHabit = widget.habit;
  }

  static const SizedBox _spacing = SizedBox(height: AppSpacing.marginM);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          BlocListener<HabitCrudBloc, HabitCrudState>(
            listener: (context, state) {
              if (state is HabitCrudSucceed) {
                if (state.action == HabitCrudAction.update) {
                  setState(() {
                    currentHabit = state.habits.first;
                  });
                }
              }
            },
          )
        ],
        child: Scaffold(
          backgroundColor: context.isDarkMode
              ? AppColors.primaryDark
              : AppColors.grayBackgroundColor,
          appBar: _buildAppBar(context),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // General
                _SectionContainer(
                  title: S.current.habit_detail,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? AppColors.primaryDark
                            : AppColors.primary,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusS),
                      ),
                      padding: const EdgeInsets.all(AppSpacing.paddingS),
                      margin: const EdgeInsets.symmetric(
                        vertical: AppSpacing.marginM,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: false,
                        animatedTexts: [
                          TypewriterAnimatedText(
                            currentHabit.habitDesc,
                            speed: const Duration(milliseconds: 200),
                            textStyle: const TextStyle(
                              color: AppColors.lightText,
                              fontSize: AppFontSize.h4,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      currentHabit.habitGoal.goalDesc,
                      style: const TextStyle(
                        fontSize: AppFontSize.h4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 5,
                    ),
                    _spacing,
                    _buildHabitIcons(),
                  ],
                ),

                // Progress
                _SectionContainer(
                  title: S.current.progress_section,
                  children: [
                    _buildStreak(),
                    _spacing,
                    _buildProgressingBar(context),
                    _spacing,
                    ..._buildDateTimeInfo(context),
                    _spacing,
                    HabitStreakCalendar(
                      disable: true,
                      completedDates: DateTimeHelper.getDatesByStatus(
                          histories, DayStatus.completed),
                      failedDates: DateTimeHelper.getDatesByStatus(
                          histories, DayStatus.failed),
                      skippedDates: DateTimeHelper.getDatesByStatus(
                          histories, DayStatus.skipped),
                      onDaySelected: (firstDate, secondDate) {},
                    ),
                  ],
                ),

                // Tracker
                if (currentHabit.habitGoal.goalType != GoalType.custom.name)
                  _SectionContainer(
                    width: MediaQuery.of(context).size.width,
                    title: S.current.tracker_section,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.marginM),
                        child: HabitTracker(
                          habitId: currentHabit.habitId,
                          habitGoal: currentHabit.habitGoal,
                        ),
                      ),
                    ],
                  ),

                // History
                _SectionContainer(
                  title: S.current.history_section,
                  children: [
                    if (histories.isEmpty)
                      Center(
                        child: Text(
                          S.current.history_empty,
                          style: const TextStyle(
                            color: AppColors.grayText,
                            fontSize: AppFontSize.h4,
                          ),
                        ),
                      )
                    else ...<Widget>[
                      ...histories.take(5).map(
                          (history) => _HistoryBriefITem(history: history)),
                      _spacing,
                      _buildAllDetailHistoryButton(context),
                    ],
                  ],
                ),

                // Reminder
                _SectionContainer(
                  title: S.current.reminder_section,
                  children: const [
                    _spacing,
                    ReminderSectionItem(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final iconData = HabitIcon.fromString(currentHabit.iconName).habitIcon;
    return AppBar(
      leadingWidth: 30,
      title: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Iconify(iconData.icon, color: AppColors.lightText, size: 25),
            const SizedBox(width: AppSpacing.marginS),
            Text(
              currentHabit.habitTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _onShowMenuBottomSheet(context),
          icon: const Icon(Icons.more_vert),
        ),
      ],
    );
  }

  // General Section
  Widget _buildHabitIcons() {
    return Wrap(
      runSpacing: 10,
      spacing: 10,
      children: [
        TextWithCircleBorderContainer(
            title: currentHabit.habitCategory.toUpperCaseFirstLetter),
        TextWithCircleBorderContainer(
            title: currentHabit.timeOfDay.toUpperCaseFirstLetter),
        TextWithCircleBorderContainer(
          title: HabitFrequency.fromNum(currentHabit.habitGoal.goalFrequency)
              .name
              .toUpperCaseFirstLetter,
        ),
      ],
    );
  }

  // Progress Section
  Widget _buildStreak() {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconWithText(
            icon: FontAwesomeIcons.calendarCheck,
            text: S.current.longest_streak,
            iconColor: AppColors.success,
            fontSize: AppFontSize.h4,
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius:
                  BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.cyan],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(AppSpacing.paddingS)
                .copyWith(right: AppSpacing.paddingM),
            child: IconWithText(
              icon: Icons.emoji_events,
              text: currentHabit.longestStreak.toString(),
              fontColor: AppColors.lightText,
              fontWeight: FontWeight.bold,
              iconColor: Colors.amber,
              iconSize: 30,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.marginM),
        child: IconWithText(
          icon: Icons.celebration,
          iconColor: Colors.red,
          text: currentHabit.getStreakMessage,
          fontSize: AppFontSize.bodyLarge,
        ),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  List<Widget> _buildDateTimeInfo(BuildContext context) {
    final String locale = context.locale.languageCode;

    return [
      _DateTimeSectionItem(
        title: S.current.start_date,
        subtitle: DateTimeHelper.formatFullDate(currentHabit.startDate,
            locale: locale),
        icon: FontAwesomeIcons.flagCheckered,
        backgroundColor: Colors.blue,
      ),
      _DateTimeSectionItem(
        title: S.current.end_date,
        subtitle:
            DateTimeHelper.formatFullDate(currentHabit.endDate, locale: locale),
        icon: FontAwesomeIcons.stopwatch,
        backgroundColor: Colors.green,
      ),
      _DateTimeSectionItem(
        title: S.current.target_title,
        subtitle: currentHabit.habitGoal.target,
        icon: FontAwesomeIcons.bullseye,
        backgroundColor: Colors.purple,
      ),
    ];
  }

  Widget _buildProgressingBar(BuildContext context) {
    final habitProgressPercent = currentHabit.habitProgress * 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedTextKit(
          isRepeatingAnimation: false,
          repeatForever: false,
          animatedTexts: [
            ColorizeAnimatedText(
              S.current.on_your_way(habitProgressPercent.toInt()),
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.bodyLarge,
              ),
              colors: const [
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
                Color(0xFF42A5F5),
              ],
            )
          ],
        ),
        const SizedBox(height: AppSpacing.marginS),
        LinearPercentIndicator(
          backgroundColor: AppColors.grayBackgroundColor,
          padding: EdgeInsets.zero,
          linearGradient: const LinearGradient(
            colors: [Color(0xFF81D4FA), Color(0xFF0288D1), Color(0xAB01579B)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barRadius: const Radius.circular(AppSpacing.circleRadius),
          lineHeight: 20,
          percent: currentHabit.habitProgress,
          center: Text(
            '${habitProgressPercent.toStringAsFixedWithoutZero()}%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: currentHabit.habitProgress < 0.5
                  ? Colors.black
                  : AppColors.lightText,
            ),
          ),
        ),
      ],
    );
  }

  // History Section
  Widget _buildAllDetailHistoryButton(BuildContext context) {
    return Bounce(
      duration: AppCommons.buttonBounceDuration,
      onPressed: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.primaryDark : AppColors.primary,
          borderRadius: BorderRadius.circular(AppSpacing.radiusS),
        ),
        padding: const EdgeInsets.all(AppSpacing.paddingM),
        child: Text(
          S.current.all_detail_history,
          style: const TextStyle(
            color: AppColors.lightText,
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.bodyLarge,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _onShowMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _HabitMenuActions(
        onEdit: _onEditHabit,
        onDelete: _onDeleteHabit,
      ),
    );
  }

  Future<void> _onDeleteHabit() async {
    final navigator = Navigator.of(context);
    final habitCrudBloc = context.read<HabitCrudBloc>();
    bool isAllowed = await SmartDialog.show<bool>(
            builder: (innerCtx) => ConfirmDeleteDialog(
                  onDelete: () => SmartDialog.dismiss(result: true),
                  onCancel: () => SmartDialog.dismiss(result: false),
                )) ??
        false;

    if (isAllowed) {
      habitCrudBloc.add(DeleteHabit(currentHabit.habitId));
      navigator.popUntil(ModalRoute.withName('/'));
    }
  }

  void _onEditHabit() {
    Navigator.pop(context);
    SmartDialog.show(
      builder: (ctx) => BlocProvider.value(
        value: context.read<HabitCrudBloc>(),
        child: BlocListener<HabitCrudBloc, HabitCrudState>(
          listener: (blocContext, state) async {
            if (state is HabitCrudSucceed) {
              final alertDialog = AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                title: S.current.success_title,
                desc: S.current.add_success,
              );

              await Future.delayed(const Duration(milliseconds: 500));
              SmartDialog.dismiss();
              await Future.delayed(const Duration(milliseconds: 200));
              alertDialog.show();
              await Future.delayed(const Duration(seconds: 5));
              alertDialog.dismiss();
            }
          },
          child: EditTemplateDialog(
            child: GeneratedHabit(
                habit: currentHabit,
                onEdit: (habit) {
                  context
                      .read<HabitCrudBloc>()
                      .add(EditHabit(id: habit.habitId, updatedHabit: habit));
                }),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: AppFontSize.h1,
      ),
    );
  }
}

class _DateTimeSectionItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String subtitle;
  final Color? backgroundColor;

  const _DateTimeSectionItem({
    required this.title,
    required this.icon,
    required this.subtitle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return HabitSectionContainer(
      width: MediaQuery.of(context).size.width,
      backgroundColor: backgroundColor?.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconWithText(
            icon: icon,
            text: title,
            iconColor: backgroundColor,
            fontColor: backgroundColor,
            fontSize: AppFontSize.labelLarge,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: AppSpacing.marginS),
          Text(
            subtitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.h4,
            ),
          )
        ],
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  final String title;
  final double? width;
  final List<Widget> children;

  const _SectionContainer({
    required this.title,
    required this.children,
    this.width,
  });

  static const _habitMargin = EdgeInsets.symmetric(
    horizontal: AppSpacing.marginM,
    vertical: AppSpacing.marginL,
  );
  @override
  Widget build(BuildContext context) {
    return HabitSectionContainer(
      width: width,
      margin: _habitMargin.copyWith(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(title: title),
          ...children,
        ],
      ),
    );
  }
}

class _HistoryBriefITem extends StatelessWidget {
  final HabitHistory history;
  const _HistoryBriefITem({required this.history});

  static const String _unAchievedTaskTime = '__:__';
  @override
  Widget build(BuildContext context) {
    final status = DayStatus.fromString(history.executionStatus);
    final iconData = status.statusIcon;
    final iconColor = status.statusColor;
    final String? completedTime =
        history.endTime?.toMoment().formatTimeWithSeconds();

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        iconData,
        color: iconColor,
      ),
      title: Text(
        DateTimeHelper.formatFullDate(
          history.date,
          locale: context.locale.languageCode,
        ),
      ),
      trailing: IconWithText(
        icon: FontAwesomeIcons.clockRotateLeft,
        text: completedTime ?? _unAchievedTaskTime,
        fontSize: AppFontSize.labelLarge,
        iconSize: 20,
      ),
    );
  }
}

class _HabitMenuActions extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const _HabitMenuActions({
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: onEdit,
          leading: const Icon(FontAwesomeIcons.penToSquare),
          title: Text(
            S.current.edit_button,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          onTap: onDelete,
          leading: const Icon(FontAwesomeIcons.trash, color: AppColors.error),
          title: Text(
            S.current.delete_button,
            style: const TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
