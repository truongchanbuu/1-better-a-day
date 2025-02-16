import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/enums/habit/day_status.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';
import '../../../notification/presentations/blocs/reminder/reminder_bloc.dart';
import '../../../rewards/presentations/blocs/challenge_crud/challenge_crud_bloc.dart';
import '../../domain/entities/habit_entity.dart';
import '../../domain/entities/habit_history.dart';
import '../blocs/crud/habit_crud_bloc.dart';
import '../blocs/habit_history_crud/habit_history_crud_bloc.dart';
import '../pages/habit_detail_page.dart';

class TodayHabitItem extends StatefulWidget {
  final HabitEntity habit;
  const TodayHabitItem({super.key, required this.habit});

  @override
  State<TodayHabitItem> createState() => _TodayHabitItemState();
}

class _TodayHabitItemState extends State<TodayHabitItem> with RouteAware {
  @override
  void initState() {
    super.initState();
    _loadTodayHistory();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _loadTodayHistory();
  }

  void _loadTodayHistory() {
    context.read<HabitHistoryCrudBloc>().add(GetTodayHabitHistory(
          habitId: widget.habit.habitId,
          unit: widget.habit.habitGoal.goalUnit,
          targetValue: widget.habit.habitGoal.targetValue,
        ));
  }

  bool _isCompleted(HabitHistory history) {
    return history.executionStatus == DayStatus.completed;
  }

  bool _isPaused(HabitHistory history) {
    return history.executionStatus == DayStatus.skipped;
  }

  static const _itemBorderRadius =
      BorderRadius.all(Radius.circular(AppSpacing.radiusS));
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitHistoryCrudBloc, HabitHistoryCrudState>(
      buildWhen: (previous, current) =>
          current is HabitHistoryCrudSuccess &&
          current.type == HabitHistoryCrudEventType.read &&
          current.histories.isNotEmpty &&
          current.histories.first.habitId == widget.habit.habitId,
      builder: (context, state) {
        final history = state is HabitHistoryCrudSuccess &&
                state.type == HabitHistoryCrudEventType.read &&
                (state.histories.isNotEmpty &&
                    state.histories.first.habitId == widget.habit.habitId)
            ? state.histories.first
            : HabitHistory.init().copyWith(habitId: widget.habit.habitId);
        print('state: $state - ${widget.habit.habitId}');

        final isCompleted = _isCompleted(history);
        final isPaused = _isPaused(history);
        final progress = widget.habit.habitProgress;

        return Container(
          decoration: BoxDecoration(
            color:
                context.isDarkMode ? AppColors.darkText : AppColors.lightText,
            borderRadius: _itemBorderRadius,
          ),
          margin: const EdgeInsets.symmetric(vertical: AppSpacing.marginS),
          child: ListTile(
            shape: BeveledRectangleBorder(borderRadius: _itemBorderRadius),
            onTap: () => _onTileTap(context, history),
            leading: Icon(
              isCompleted
                  ? Icons.check_circle
                  : isPaused
                      ? Icons.pause_circle
                      : Icons.circle_outlined,
              color: isCompleted
                  ? AppColors.success
                  : isPaused
                      ? AppColors.warning
                      : null,
            ),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.habit.habitTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.h4,
                  ),
                  maxLines: 5,
                  overflow: TextOverflow.visible,
                ),
                const SizedBox(height: AppSpacing.marginXS),
                Text(
                  S.current.total_streak(widget.habit.currentStreak),
                  style: const TextStyle(
                    fontSize: AppFontSize.labelLarge,
                    color: AppColors.grayText,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
            trailing: SizedBox(
              width: 130,
              child: LinearPercentIndicator(
                progressColor: AppColors.primary,
                backgroundColor: AppColors.grayBackgroundColor,
                percent: progress,
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTileTap(BuildContext context, HabitHistory history) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => getIt.get<HabitHistoryCrudBloc>()),
            BlocProvider.value(value: context.read<HabitCrudBloc>()),
            BlocProvider(create: (context) => getIt.get<ReminderBloc>()),
            BlocProvider.value(value: context.read<ChallengeCrudBloc>()),
          ],
          child: HabitDetailPage(habit: widget.habit),
        ),
      ),
    );
  }
}
