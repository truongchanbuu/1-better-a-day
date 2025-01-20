import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../shared/domain/entities/tab_bar_item.dart';
import '../../domain/entities/achievements/achievement_entity.dart';
import '../blocs/collection_crud/collection_crud_bloc.dart';
import 'all_achievement_tab.dart';
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

  List<AchievementEntity> achievements = [];

  @override
  void initState() {
    super.initState();
    items = [
      const AllAchievementTab(),
      BlocProvider(
        create: (_) =>
            getIt.get<CollectionCrudBloc>()..add(LoadCollectionData()),
        child: const CollectionTab(),
      ),
    ];
    _tabController = TabController(length: items.length, vsync: this);
  }

  List<Widget> items = [];

  List<TabBarItem> tabs = [
    TabBarItem(
      title: S.current.all_achievements_tab,
      icon: FontAwesomeIcons.medal,
    ),
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
          unselectedBackgroundColor: context.isDarkMode
              ? AppColors.darkText
              : AppColors.grayBackgroundColor,
          unselectedLabelStyle: TextStyle(
            color:
                context.isDarkMode ? AppColors.lightText : AppColors.darkText,
          ),
          onTap: (index) => setState(() => _tabController.index = index),
          tabs: tabs
              .map((tab) => Tab(
                    key: ValueKey(tab.title),
                    text: tab.title,
                    icon: Icon(
                      tab.icon,
                      color: context.isDarkMode
                          ? AppColors.lightText
                          : AppColors.darkText,
                    ),
                  ))
              .toList(),
        ),
        AnimatedSwitcherPlus.flipY(
          duration: const Duration(milliseconds: 200),
          child: items[_tabController.index],
        )
      ],
    );
  }
}
