import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_common.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit/habit_category.dart';
import '../../../../../core/enums/habit/habit_status.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../generated/l10n.dart';
import '../../blocs/crud/habit_crud_bloc.dart';
import 'filter_item.dart';

class HabitSearchFilterBar extends StatefulWidget {
  final void Function(String category, String status, String progress)
      onFilterChanged;

  const HabitSearchFilterBar({super.key, required this.onFilterChanged});

  @override
  State<HabitSearchFilterBar> createState() => _HabitSearchFilterBarState();
}

class _HabitSearchFilterBarState extends State<HabitSearchFilterBar> {
  late final TextEditingController _searchController;

  List<String> rangeValues = [''];
  String _selectedCategory = '';
  String _selectedStatus = '';
  String _selectedProgress = '';

  bool _isFilterSectionShown = false;

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

  String allSelection = S.current.all_selection;
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
                    borderSide: BorderSide(color: AppColors.grayText),
                  ),
                ),
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  if (value.isEmpty) {
                    context.read<HabitCrudBloc>().add(GetAllHabits());
                  }
                },
              ),
            ),
            const SizedBox(width: AppSpacing.marginS),
            _SearchFilterActionButton(
              onPressed: _onSearch,
              icon: FontAwesomeIcons.magnifyingGlass,
            ),
            const SizedBox(width: AppSpacing.marginXS),
            _SearchFilterActionButton(
              onPressed: () => setState(() {
                _isFilterSectionShown = !_isFilterSectionShown;
                if (!_isFilterSectionShown) {
                  _selectedCategory = '';
                  _selectedStatus = '';
                  _selectedProgress = '';

                  widget.onFilterChanged(
                    _selectedCategory,
                    _selectedStatus,
                    _selectedProgress,
                  );
                }
              }),
              icon: Icons.sort,
            ),
          ],
        ),
        AnimatedSwitcherPlus.translationLeft(
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeIn,
          duration: const Duration(milliseconds: 250),
          child: _isFilterSectionShown
              ? Padding(
                  key: const ValueKey('filter_section'),
                  padding: const EdgeInsets.only(top: AppSpacing.marginS),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterItem(
                          width: 200,
                          selected: allSelection,
                          title: S.current.habit_category,
                          items: HabitCategory.values
                              .takeWhile(
                                  (value) => value != HabitCategory.custom)
                              .map((e) => e.categoryName)
                              .toList()
                            ..insert(0, allSelection),
                          onChanged: (value) {
                            if (value != null) {
                              if (value == allSelection) {
                                _selectedCategory = '';
                              } else {
                                final selectedCategory =
                                    HabitCategory.fromMultiLangString(value);
                                _selectedCategory =
                                    selectedCategory?.name ?? '';
                              }
                              widget.onFilterChanged(_selectedCategory,
                                  _selectedStatus, _selectedProgress);
                            }
                          },
                        ),
                        FilterItem(
                          width: 200,
                          selected: allSelection,
                          title: S.current.status_title,
                          items: HabitStatus.values
                              .map((e) => e.statusName)
                              .toList()
                            ..insert(0, allSelection),
                          onChanged: (value) {
                            if (value != null) {
                              if (value == allSelection) {
                                _selectedStatus = '';
                              } else {
                                final selected =
                                    HabitStatus.fromMultiLangString(value);
                                _selectedStatus = selected.name;
                              }

                              widget.onFilterChanged(_selectedCategory,
                                  _selectedStatus, _selectedProgress);
                            }
                          },
                        ),
                        FilterItem(
                          width: 165,
                          title: S.current.progress_section,
                          items: rangeValues,
                          selected: rangeValues.first,
                          type: FilterType.range,
                          onChanged: (value) {
                            if (value?.isNotEmpty ?? false) {
                              final selectedProgress = value!.split('%').first;
                              _selectedProgress = selectedProgress;

                              widget.onFilterChanged(
                                _selectedCategory,
                                _selectedStatus,
                                _selectedProgress,
                              );

                              setState(() {
                                rangeValues = [value];
                              });
                            }
                          },
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

  void _onSearch() {
    final searchValue = _searchController.text;
    if (searchValue.isNotEmpty) {
      context.read<HabitCrudBloc>().add(SearchByKeyword(searchValue));
    }
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
