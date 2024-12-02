import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_common.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';

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
        if (_isFilterSectionShowed)
          const Padding(
            padding: EdgeInsets.only(top: AppSpacing.marginS),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterItem<String>(
                    title: 'Title',
                    items: ['A', 'B', 'C', 'D'],
                  ),
                  _FilterItem<String>(
                    title: 'Status',
                    items: ['A', 'B', 'C'],
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _FilterItem<T> extends StatefulWidget {
  final T? selected;
  final List<T> items;
  final String title;
  const _FilterItem({
    required this.title,
    required this.items,
    this.selected,
  });

  @override
  State<_FilterItem<T>> createState() => _FilterItemState<T>();
}

class _FilterItemState<T> extends State<_FilterItem<T>> {
  T? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  static const _textStyle = TextStyle(
    fontSize: AppFontSize.bodyLarge,
  );
  static const double _containerWidth = 120;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _containerWidth,
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.circleRadius)),
        color: context.isDarkMode
            ? AppColors.primaryDark
            : AppColors.grayBackgroundColor,
      ),
      margin: const EdgeInsets.only(right: AppSpacing.marginS),
      child: DropdownButtonFormField2<T>(
        hint: Text(
          widget.title,
          style: _textStyle,
        ),
        value: selected,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppSpacing.circleRadius)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppSpacing.circleRadius)),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.paddingS),
        ),
        isExpanded: true,
        onChanged: (value) {
          setState(() {
            selected = value;
          });
        },
        selectedItemBuilder: (context) =>
            widget.items.map((item) => Text(item.toString())).toList(),
        items: widget.items
            .map((item) => DropdownMenuItem(
                  value: item,
                  enabled: selected != item,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.toString()),
                      if (selected == item)
                        const Icon(
                          FontAwesomeIcons.check,
                          color: AppColors.success,
                        ),
                    ],
                  ),
                ))
            .toList(),
      ),
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
        padding: const EdgeInsets.all(20),
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
