import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../config/route/app_route.dart';
import '../features/habit/domain/repositories/habit_repository.dart';
import '../features/habit/presentations/blocs/crud/habit_crud_bloc.dart';
import '../features/habit/presentations/blocs/habit_history_crud/habit_history_crud_bloc.dart';
import '../features/habit/presentations/pages/habit_detail_page.dart';
import '../features/notification/presentations/blocs/reminder/reminder_bloc.dart';
import '../injection_container.dart';

class NavigationService {
  static final NavigationService instance = NavigationService._();
  NavigationService._();

  Future<void> navigateToHabitDetail(String habitId) async {
    // Wait for app to be ready
    final context = AppRoute.navigatorKey.currentContext;
    if (context == null) return;

    final habitRepository = getIt.get<HabitRepository>();
    final habit = await habitRepository.getHabitById(habitId);
    if (habit == null) return;

    // Navigate when context is ready
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        PageTransition(
          type: PageTransitionType.leftToRight,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt.get<HabitCrudBloc>()),
              BlocProvider(create: (_) => getIt.get<HabitHistoryCrudBloc>()),
              BlocProvider(create: (_) => getIt.get<ReminderBloc>()),
            ],
            child: HabitDetailPage(habit: habit.toEntity()),
          ),
        ),
        ModalRoute.withName('/'),
      );
    }
  }
}
