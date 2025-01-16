import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/habit_category.dart';
import '../../../../core/enums/habit/habit_status.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';
import '../../../shared/presentations/widgets/not_found_and_refresh.dart';
import '../../domain/entities/habit_entity.dart';
import '../blocs/crud/habit_crud_bloc.dart';
import '../blocs/habit_history_crud/habit_history_crud_bloc.dart';
import 'habit_item.dart';

class HabitList extends StatefulWidget {
  final bool isListView;
  final HabitCategory? category;
  final HabitStatus? status;
  final String progress;

  const HabitList({
    super.key,
    this.isListView = true,
    required this.category,
    required this.status,
    required this.progress,
  });

  @override
  State<HabitList> createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> with RouteAware {
  List<HabitEntity> habits = [];

  @override
  void initState() {
    super.initState();
    context.read<HabitCrudBloc>().add(GetAllHabits());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    context.read<HabitCrudBloc>().add(GetAllHabits());
  }

  @override
  void didUpdateWidget(covariant HabitList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.category != null && widget.category != oldWidget.category) ||
        (widget.status != null && widget.status != oldWidget.status) ||
        widget.progress.isNotEmpty) {
      context.read<HabitCrudBloc>().add(
            SearchHabits(
              category: widget.category,
              status: widget.status,
              progress: widget.progress,
            ),
          );
    } else {
      context.read<HabitCrudBloc>().add(GetAllHabits());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitCrudBloc, HabitCrudState>(
      builder: (context, state) {
        if (state is HabitCrudSucceed) {
          if (state.action == HabitCrudAction.getAll ||
              state.action == HabitCrudAction.getBySearchValues ||
              state.action == HabitCrudAction.getByKeyword) {
            habits = state.habits;
          } else if (state.action == HabitCrudAction.delete) {
            habits.removeWhere(
                (habit) => state.habits.first.habitId == habit.habitId);
          } else if (state.action == HabitCrudAction.add) {
            habits.insert(0, state.habits.first);
          }
        }

        return AnimatedSwitcherPlus.translationBottom(
          duration: const Duration(milliseconds: 500),
          child: state is Executing
              ? const LoadingIndicator(indicatorType: Indicator.pacman)
              : _buildHabitView(),
        );
      },
      // buildWhen: (previous, current) =>
      //     current is HabitCrudSucceed ||
      //     current is Executing ||
      //     current is CrudInitial ||
      //     current is HabitCrudFailed,
    );
  }

  Widget _buildHabitView() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: AnimatedSwitcherPlus.zoomOut(
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease,
        duration: const Duration(milliseconds: 300),
        child: habits.isEmpty
            ? NotFoundAndRefresh(
                title: S.current.no_habit_found,
                onRefresh: _onRefresh,
              )
            : widget.isListView
                ? _buildListView()
                : _buildGridView(),
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: _buildItem,
      itemCount: habits.length,
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      itemBuilder: _buildItem,
      itemCount: habits.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.marginS),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return BlocProvider(
      create: (context) => getIt.get<HabitHistoryCrudBloc>(),
      child: HabitItem(
        habit: habits[index],
        isListView: widget.isListView,
      ),
    );
  }

  Future<void> _onRefresh() async =>
      context.read<HabitCrudBloc>().add(GetAllHabits());
}
