import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_common.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../generated/l10n.dart';
import 'filter_item.dart';

class HabitSearchFilterBar extends StatefulWidget {
  const HabitSearchFilterBar({super.key});

  @override
  State<HabitSearchFilterBar> createState() => _HabitSearchFilterBarState();
}

class _HabitSearchFilterBarState extends State<HabitSearchFilterBar> {
  late final TextEditingController _searchController;

  bool _isFilterSectionShowed = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: S.current.searching_title,
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.grayText)),
                ),
                textInputAction: TextInputAction.search,
              ),
            ),
            const SizedBox(width: AppSpacing.marginS),
            _SearchFilterActionButton(
              onPressed: () {},
              icon: FontAwesomeIcons.magnifyingGlass,
            ),
            const SizedBox(width: AppSpacing.marginXS),
            _SearchFilterActionButton(
              onPressed: () => setState(
                  () => _isFilterSectionShowed = !_isFilterSectionShowed),
              icon: Icons.sort,
            ),
          ],
        ),
        AnimatedSwitcherPlus.translationLeft(
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeIn,
          duration: const Duration(milliseconds: 250),
          child: _isFilterSectionShowed
              ? const Padding(
                  key: ValueKey('filter_section'),
                  padding: EdgeInsets.only(top: AppSpacing.marginS),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterItem(
                          width: 120,
                          title: 'Title',
                          items: ['A', 'B', 'C', 'D'],
                        ),
                        FilterItem(
                          width: 120,
                          title: 'Status',
                          items: ['A', 'B', 'C'],
                        ),
                        FilterItem(
                          width: 165,
                          title: 'Progressing',
                          items: [],
                          type: FilterType.range,
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(key: ValueKey('empty')),
        )
      ],
    );
  }
}

class _SearchFilterActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const _SearchFilterActionButton({
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: onPressed,
      duration: AppCommons.buttonBounceDuration,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.paddingM),
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.primaryDark : AppColors.primary,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,
              color: context.isDarkMode
                  ? AppColors.primaryDark
                  : AppColors.grayBackgroundColor,
            )
          ],
          borderRadius:
              const BorderRadius.all(Radius.circular(AppSpacing.radiusM)),
        ),
        child: Icon(
          icon,
          size: 16,
          color: AppColors.lightText,
        ),
      ),
    );
  }
}
