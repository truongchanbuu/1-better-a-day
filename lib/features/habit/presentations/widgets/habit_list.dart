import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/habit_entity.dart';
import '../blocs/crud/habit_crud_bloc.dart';
import '../blocs/habit_history_crud/habit_history_crud_bloc.dart';
import 'habit_item.dart';

class HabitList extends StatefulWidget {
  final bool isListView;
  final String category;
  final String status;
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

class _HabitListState extends State<HabitList> {
  List<HabitEntity> habits = [];

  @override
  void initState() {
    super.initState();
    context.read<HabitCrudBloc>().add(GetAllHabits());
  }

  @override
  void didUpdateWidget(covariant HabitList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.category.isNotEmpty ||
        widget.status.isNotEmpty ||
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
          child: state is! HabitCrudSucceed
              ? const LoadingIndicator(indicatorType: Indicator.pacman)
              : _buildHabitView(),
        );
      },
      buildWhen: (previous, current) =>
          current is HabitCrudSucceed ||
          current is Executing ||
          current is CrudInitial,
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
            ? _buildNoDataView()
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

  Widget _buildNoDataView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.current.no_habit_found,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.grayText,
            fontSize: AppFontSize.h3,
          ),
        ),
        const SizedBox(height: AppSpacing.marginXS),
        IconButton(
            onPressed: _onRefresh,
            icon: const Icon(
              Icons.refresh,
              color: AppColors.grayText,
            )),
      ],
    );
  }

  Future<void> _onRefresh() async =>
      context.read<HabitCrudBloc>().add(GetAllHabits());
}
