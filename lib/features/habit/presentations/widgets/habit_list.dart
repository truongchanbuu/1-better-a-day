import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import 'habit_item.dart';

class HabitList extends StatefulWidget {
  final bool isListView;
  const HabitList({super.key, this.isListView = true});

  @override
  State<HabitList> createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  @override
  Widget build(BuildContext context) {
    return _buildHabitView();
  }

  Widget _buildHabitView() {
    return AnimatedSwitcherPlus.zoomOut(
      switchInCurve: Curves.ease,
      switchOutCurve: Curves.ease,
      duration: const Duration(milliseconds: 300),
      child: widget.isListView ? _buildListView() : _buildGridView(),
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
      itemCount: 10,
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      itemBuilder: _buildItem,
      itemCount: 10,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSpacing.marginS),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return HabitItem(isListView: widget.isListView);
  }
}
