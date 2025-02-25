import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/habit_status.dart';
import '../../../../core/enums/habit/habit_time_of_day.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';
import '../../../auth/presentations/bloc/auth_bloc/auth_bloc.dart';
import '../../../shared/presentations/widgets/not_found_and_refresh.dart';
import '../blocs/crud/habit_crud_bloc.dart';
import '../helpers/habit_streak_observer.dart';
import '../helpers/shared_habit_action.dart';
import '../widgets/today_habit_item.dart';
import '../widgets/today_quote.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> with RouteAware {
  StreamSubscription? _streakSubscription;

  @override
  void initState() {
    super.initState();
    _subscribeToStreakUpdates();
    _loadAllHabits();
  }

  void _subscribeToStreakUpdates() {
    final streakObserver = getIt.get<HabitStreakObserver>();
    _streakSubscription = streakObserver.addListener(() {
      _loadAllHabits();
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _loadAllHabits();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _streakSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        context.select((AuthBloc authBloc) => authBloc.state.user);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => SharedHabitAction.showAddHabitOptions(context),
        shape: const CircleBorder(),
        tooltip: S.current.add_habit,
        child: const Icon(FontAwesomeIcons.plus, color: Colors.white),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => _loadAllHabits(),
          child: CustomScrollView(
            slivers: [
              // Header section with greeting
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.marginM),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    key: ValueKey('today_page_greeting_${context.locale}'),
                    '${HabitTimeOfDay.periodOfTheDay.greeting}, ${currentUser.username?.isEmpty ?? true ? S.current.friend_title : currentUser.username}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSize.h2,
                    ),
                  ),
                ),
              ),

              // Quote section
              const SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.marginM),
                sliver: SliverToBoxAdapter(
                  child: TodayQuote(),
                ),
              ),

              // Calendar section
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.marginM),
                sliver: SliverToBoxAdapter(
                  child: _buildCalendarSection(context.locale),
                ),
              ),

              // Today Tasks Header
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.marginM,
                  vertical: AppSpacing.marginS,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    key: ValueKey('today_page_tasks_${context.locale}'),
                    S.current.today_tasks,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSize.h2,
                    ),
                  ),
                ),
              ),

              // Tasks List
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.marginM),
                sliver: _buildTasksList(context.locale),
              ),

              // Bottom padding
              const SliverPadding(
                padding: EdgeInsets.only(bottom: AppSpacing.marginXL),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarSection(Locale locale) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.3),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSpacing.radiusS),
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingS),
      child: _TodayCalendar(currentDate: DateTime.now()),
    );
  }

  Widget _buildTasksList(Locale locale) {
    return BlocBuilder<HabitCrudBloc, HabitCrudState>(
      builder: (context, habitState) {
        if (habitState is Executing) {
          return SliverToBoxAdapter(
            child: Center(
              child: LoadingIndicator(indicatorType: Indicator.pacman),
            ),
          );
        }

        if (habitState is HabitCrudSucceed) {
          final habits = habitState.habits;
          if (habits.isEmpty) {
            return SliverToBoxAdapter(child: _buildEmptyTodayTask(locale));
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final habit = habits[index];
                return TodayHabitItem(habit: habit);
              },
              childCount: habits.length,
            ),
          );
        }

        return SliverToBoxAdapter(child: _buildEmptyTodayTask(context.locale));
      },
    );
  }

  Widget _buildEmptyTodayTask(Locale locale) {
    return Center(
      key: ValueKey('today_page_empty_$locale'),
      child: NotFoundAndRefresh(
        title: S.current.no_task_today,
        onRefresh: _loadAllHabits,
      ),
    );
  }

  void _loadAllHabits() {
    context
        .read<HabitCrudBloc>()
        .add(GetListOfHabitsByStatus(HabitStatus.inProgress.name));
  }
}

class _TodayCalendar extends StatelessWidget {
  final DateTime currentDate;
  const _TodayCalendar({required this.currentDate});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: context.locale.languageCode,
      calendarFormat: CalendarFormat.week,
      focusedDay: currentDate,
      firstDay: currentDate.subtract(const Duration(days: 30)),
      lastDay: currentDate,
      headerVisible: false,
      currentDay: currentDate,
      calendarStyle: const CalendarStyle(
        todayDecoration:
            BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
      ),
    );
  }
}
