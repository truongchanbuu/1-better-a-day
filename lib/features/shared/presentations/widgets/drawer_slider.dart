import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/tab_type.dart';
import 'drawer_item.dart';

class DrawerSlider extends StatelessWidget {
  final TabType currentTab;
  final ValueChanged<TabType> onChanged;

  const DrawerSlider({
    super.key,
    required this.currentTab,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.marginXS),
      child: ListView(
        children: TabType.values
            .map((tab) => DrawerItem(
                  onTap: currentTab != tab ? () => onChanged(tab) : null,
                  iconData: tab.icon,
                  title: tab.title,
                  isSelected: currentTab == tab,
                ))
            .toList(),
      ),
    );
  }
}
