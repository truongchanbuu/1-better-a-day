import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/domain/entities/tab_bar_item.dart';
import '../../../shared/presentations/widgets/search_bar.dart';
import '../widgets/achieved_goal_item.dart';
import 'collection_tab.dart';

enum RewardTabs {
  all,
  collections,
}

class RewardTab extends StatefulWidget {
  final RewardTabs tab;
  const RewardTab({super.key, this.tab = RewardTabs.all});

  @override
  State<RewardTab> createState() => _RewardTabState();
}

class _RewardTabState extends State<RewardTab> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this);
  }

  final List<Widget> items = [
    const _AllAchievementTab(),
    const CollectionTab(),
  ];

  List<TabBarItem> tabs = [
    TabBarItem(
        title: S.current.all_achievements_tab, icon: FontAwesomeIcons.medal),
    TabBarItem(title: S.current.collection_tab, icon: FontAwesomeIcons.book),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ButtonsTabBar(
          controller: _tabController,
          backgroundColor: AppColors.primary,
          onTap: (index) => setState(() => _tabController.index = index),
          tabs: tabs
              .map((tab) => Tab(
                    key: ValueKey(tab.title),
                    text: tab.title,
                    icon: Icon(tab.icon),
                  ))
              .toList(),
        ),
        AnimatedSwitcherPlus.flipY(
          duration: const Duration(milliseconds: 500),
          child: items[_tabController.index],
        )
      ],
    );
  }
}

class _AllAchievementTab extends StatelessWidget {
  const _AllAchievementTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.paddingS),
      child: Column(
        children: [
          AppSearchBar(hintText: S.current.search_achievement),
          ...List.generate(10, (index) => const AchievedGoalItem()),
        ],
      ),
    );
  }
}
