import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

import '../../../../../../core/constants/app_color.dart';
import '../../../../../../core/constants/app_spacing.dart';
import '../../../../../../core/extensions/context_extension.dart';
import '../../../../../shared/domain/entities/tab_bar_item.dart';

class ChartTabBar extends StatefulWidget {
  final List<TabBarItem> tabData;
  final List<Widget> contentWidgets;
  final Map<int, double> heightRatios;
  final Color selectedBackgroundColor;
  final Color? unselectedBackgroundColor;
  final EdgeInsets contentPadding;
  final double labelSpacing;
  final bool contentCenter;
  final double defaultHeightRatio;
  final void Function(int)? onTabChanged;

  const ChartTabBar({
    super.key,
    required this.tabData,
    required this.contentWidgets,
    this.heightRatios = const {},
    this.selectedBackgroundColor = AppColors.primary,
    this.unselectedBackgroundColor,
    this.contentPadding = const EdgeInsets.all(AppSpacing.paddingS),
    this.labelSpacing = AppSpacing.marginS,
    this.contentCenter = true,
    this.defaultHeightRatio = 0.45,
    this.onTabChanged,
  }) : assert(
          tabData.length == contentWidgets.length,
          'Number of tabs must match number of content widgets',
        );

  @override
  State<ChartTabBar> createState() => _ChartTabBarState();
}

class _ChartTabBarState extends State<ChartTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabData.length,
      vsync: this,
    );

    _tabController.addListener(() {
      widget.onTabChanged?.call(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double _getSuitableHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return (widget.heightRatios[_tabController.index] ??
            widget.defaultHeightRatio) *
        height;
  }

  Widget _buildTabWidget(TabBarItem data) {
    return Tab(
      key: ValueKey(data.title),
      text: data.title,
      icon: Icon(data.icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unselectedBackgroundColor = widget.unselectedBackgroundColor ??
        (context.isDarkMode
            ? AppColors.primaryDark
            : AppColors.grayBackgroundColor);

    return Column(
      children: [
        ButtonsTabBar(
          controller: _tabController,
          tabs: widget.tabData.map(_buildTabWidget).toList(),
          labelSpacing: widget.labelSpacing,
          contentCenter: widget.contentCenter,
          contentPadding: widget.contentPadding,
          backgroundColor: widget.selectedBackgroundColor,
          unselectedBackgroundColor: unselectedBackgroundColor,
          unselectedLabelStyle: TextStyle(
            color:
                context.isDarkMode ? AppColors.lightText : AppColors.darkText,
          ),
          onTap: (index) => setState(() {
            _tabController.index = index;
          }),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: _getSuitableHeight(context),
          child: widget.contentWidgets[_tabController.index],
        ),
      ],
    );
  }
}
