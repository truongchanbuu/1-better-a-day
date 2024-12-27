import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/habit_status.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/habit_entity.dart';
import '../blocs/crud/habit_crud_bloc.dart';
import 'habit_item.dart';

class HabitList extends StatefulWidget {
  final bool isListView;
  const HabitList({super.key, this.isListView = true});

  @override
  State<HabitList> createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  List<HabitEntity> habits = [];

  @override
  void initState() {
    super.initState();
    context
        .read<HabitCrudBloc>()
        .add(GetListOfHabitsByStatus(HabitStatus.inProgress.name));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitCrudBloc, HabitCrudState>(
      builder: (context, state) {
        if (state is HabitCrudSucceed) {
          if (state.action == HabitCrudAction.getByStatus) {
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
    return HabitItem(
      habit: habits[index],
      isListView: widget.isListView,
    );
  }

  Widget _buildNoDataView() {
    return Column(
      children: [
        Text(
          S.current.no_habit_found,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.grayText,
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

  Future<void> _onRefresh() async => context
      .read<HabitCrudBloc>()
      .add(GetListOfHabitsByStatus(HabitStatus.inProgress.name));
}
