import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_common.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/habit_category.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/helpers/date_time_helper.dart';
import '../../../../core/helpers/setting_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';
import '../../../shared/presentations/widgets/search_bar.dart';
import '../../data/models/preset_habit.dart';
import '../../domain/entities/habit_entity.dart';
import '../blocs/ai_habit_generate/ai_habit_generate_bloc.dart';
import '../blocs/crud/habit_crud_bloc.dart';
import '../widgets/crud_habit/edit_template_dialog.dart';
import '../widgets/generated_habit.dart';

class PresetHabitPage extends StatefulWidget {
  const PresetHabitPage({super.key});

  @override
  State<PresetHabitPage> createState() => _PresetHabitPageState();
}

class _PresetHabitPageState extends State<PresetHabitPage> {
  Timer? _debounce;
  late final TextEditingController _searchController;

  List<HabitEntity> presetHabits = [];
  List<HabitEntity> allAvailableHabits = [];
  HabitCategory? selected;

  bool _isAllSelected = false;

  List<String> selectedHabitIds = [];

  @override
  void initState() {
    super.initState();
    allAvailableHabits = PresetHabits.defaultHabits;
    context.read<HabitCrudBloc>().add(GetListOfHabitsByIds(
        allAvailableHabits.map((e) => e.habitId).toList()));
    _searchController = TextEditingController();
    presetHabits = allAvailableHabits;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _updateHabits(List<HabitEntity> habits) {
    setState(() {
      final storedHabits = habits.map((e) => e.habitId).toList();
      allAvailableHabits = allAvailableHabits
          .where((e) => !storedHabits.contains(e.habitId))
          .toList();
      presetHabits = allAvailableHabits;
    });
  }

  static const _spacing = SizedBox(height: AppSpacing.marginS);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        bottomNavigationBar: _buildAddButton(),
        body: MultiBlocListener(
          listeners: [
            BlocListener<HabitCrudBloc, HabitCrudState>(
              listener: (context, state) async {
                if (state is HabitCrudSucceed &&
                    (state.action == HabitCrudAction.add ||
                        state.action == HabitCrudAction.addList)) {
                  final alertDialog = AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    title: S.current.success_title,
                    desc: S.current.add_success,
                    barrierColor: Colors.transparent.withOpacity(0.2),
                    onDismissCallback: (type) {
                      _updateHabits(state.habits);
                    },
                  );

                  alertDialog.show();
                  await Future.delayed(AppCommons.alertShowDuration);
                  alertDialog.dismiss();
                } else if (state is HabitCrudSucceed &&
                    state.action == HabitCrudAction.getAll) {
                  _updateHabits(state.habits);
                } else if (state is HabitCrudFailed) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    title: S.current.failure_title,
                    desc: state.errorMessage,
                  ).show();
                }
              },
            ),
            BlocListener<AIHabitGenerateBloc, AIHabitGenerateState>(
              listener: (context, state) {
                if (state is AddHabitSucceed) {
                  _updateHabits([state.habit]);
                }
              },
            )
          ],
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.marginS),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSearchBar(
                    searchController: _searchController,
                    hintText: S.current.searching_title,
                    onChanged: _onSearch,
                  ),
                  _spacing,
                  _CategoryFilter(
                    selected: selected,
                    onSelected: (picked) {
                      setState(() {
                        selected = picked;

                        if (selected != null) {
                          presetHabits = allAvailableHabits
                              .where((habit) => habit.habitCategory == selected)
                              .toList();
                        }
                      });
                    },
                  ),
                  _spacing,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: presetHabits
                        .map((habit) => _HabitItem(
                              habit: habit,
                              onLongPressed: (habitId) => setState(() {
                                if (!selectedHabitIds.contains(habitId)) {
                                  selectedHabitIds.add(habitId);
                                } else {
                                  selectedHabitIds.remove(habitId);
                                }
                              }),
                              onPressed: (habitId) {
                                if (selectedHabitIds.contains(habitId)) {
                                  setState(
                                      () => selectedHabitIds.remove(habitId));
                                }
                              },
                              onDoubleTap: () => _onHabitDetailDisplay(habit),
                              isSelected:
                                  selectedHabitIds.contains(habit.habitId),
                            )
                                .animate()
                                .fadeIn(
                                    delay: 100.ms * presetHabits.indexOf(habit))
                                .scale(begin: const Offset(0, 0)))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(actions: [
      if (selectedHabitIds.isNotEmpty)
        Checkbox(
          side: const BorderSide(color: Colors.white, width: 2),
          checkColor: _isAllSelected ? AppColors.primary : Colors.white,
          activeColor: Colors.white,
          value: _isAllSelected,
          onChanged: (value) {
            setState(() {
              _isAllSelected = value ?? false;

              if (_isAllSelected) {
                selectedHabitIds =
                    allAvailableHabits.map((e) => e.habitId).toList();
              } else {
                selectedHabitIds.clear();
              }
            });
          },
        ),
    ]);
  }

  void _onSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 200),
      () {
        final searchText = value.toLowerCase();

        setState(() {
          presetHabits = allAvailableHabits.where(
            (habit) {
              final matchesSearch = habit.habitTitle
                      .toLowerCase()
                      .contains(searchText) ||
                  habit.habitDesc.toLowerCase().contains(searchText) ||
                  habit.habitGoal.goalDesc.toLowerCase().contains(searchText);

              return matchesSearch;
            },
          ).toList();
        });
      },
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.paddingS),
      child: ElevatedButton(
        onPressed: _onAdd,
        child: IconWithText(
          icon: Icons.add,
          text: S.current.add_habit,
          iconColor: AppColors.lightText,
          fontColor: AppColors.lightText,
        ),
      ),
    );
  }

  void _onAdd() {
    if (selectedHabitIds.isEmpty) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        title: S.current.warning_title,
        desc: S.current.no_habit_item_selected,
        btnOkText: 'OK',
        btnOkOnPress: () {},
        btnOkColor: AppColors.warning,
      ).show();

      return;
    }

    final List<HabitEntity> selectedHabits = presetHabits
        .where((habit) => selectedHabitIds.contains(habit.habitId))
        .toList();

    context.read<HabitCrudBloc>().add(AddListOfHabits(selectedHabits));
  }

  void _onHabitDetailDisplay(HabitEntity habit) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<AIHabitGenerateBloc>(),
        child: EditTemplateDialog(
          child: BlocListener<AIHabitGenerateBloc, AIHabitGenerateState>(
            listener: (innerCtx, state) async {
              if (state is AddHabitSucceed) {
                final alertDialog = AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  title: S.current.success_title,
                  desc: S.current.add_success,
                );

                Navigator.pop(context);

                await Future.delayed(const Duration(milliseconds: 200));
                alertDialog.show();
                await Future.delayed(const Duration(seconds: 5));
                alertDialog.dismiss();
              }
            },
            child: GeneratedHabit(
              habit: habit,
              onEdit: (habit) =>
                  context.read<AIHabitGenerateBloc>().add(AddHabitEvent(habit)),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryFilter extends StatefulWidget {
  final void Function(HabitCategory? selected)? onSelected;
  final HabitCategory? selected;
  const _CategoryFilter({this.selected, this.onSelected});

  @override
  State<_CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<_CategoryFilter> {
  HabitCategory? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.paddingXS),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<HabitCategory>(
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
              color:
                  context.isDarkMode ? AppColors.darkText : AppColors.lightText,
              borderRadius: const BorderRadius.all(
                Radius.circular(AppSpacing.circleRadius),
              ),
            ),
          ),
          hint: Text(
              selected != null ? selected!.categoryName : S.current.all_habits),
          items: HabitCategory.values
              .take(HabitCategory.values.length - 1)
              .map((e) => DropdownMenuItem<HabitCategory>(
                    value: e,
                    child: Text(e.categoryName),
                  ))
              .toList(),
          menuItemStyleData: MenuItemStyleData(
            selectedMenuItemBuilder: (context, child) => Container(
              color: AppColors.primary.withOpacity(0.2),
              child: child,
            ),
          ),
          onChanged: (value) {
            if (value != null) {
              setState(() => selected = value);
              widget.onSelected?.call(selected);
            }
          },
        ),
      ),
    );
  }
}

class _HabitItem extends StatefulWidget {
  final bool isSelected;
  final HabitEntity habit;
  final void Function(String habitId)? onLongPressed;
  final void Function(String habitId)? onPressed;
  final VoidCallback? onDoubleTap;

  const _HabitItem({
    required this.habit,
    this.onLongPressed,
    this.isSelected = false,
    this.onPressed,
    this.onDoubleTap,
  });

  static const _spacing = SizedBox(height: AppSpacing.marginS);

  @override
  State<_HabitItem> createState() => _HabitItemState();
}

class _HabitItemState extends State<_HabitItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.locale.languageCode;
    final habitIcon = widget.habit.habitIcon;

    return GestureDetector(
      onDoubleTap: widget.onDoubleTap,
      onLongPress: () => widget.onLongPressed?.call(widget.habit.habitId),
      onTap: () => widget.onPressed?.call(widget.habit.habitId),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.isDarkMode
                  ? AppColors.darkText
                  : habitIcon.color.withOpacity(0.2),
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
            ),
            margin: const EdgeInsets.symmetric(
                horizontal: AppSpacing.marginM, vertical: AppSpacing.marginS),
            padding: const EdgeInsets.all(AppSpacing.paddingM),
            child: Row(
              children: [
                Iconify(
                  habitIcon.icon,
                  size: 30,
                  color: habitIcon.color,
                ),
                const SizedBox(width: AppSpacing.marginM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.habit.habitTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppFontSize.h3,
                        ),
                        maxLines: 10,
                      ),
                      _HabitItem._spacing,
                      Text(
                        widget.habit.habitGoal.goalDesc,
                        style: const TextStyle(fontSize: AppFontSize.bodyLarge),
                        maxLines: 10,
                      ),
                      _HabitItem._spacing,
                      IconWithText(
                        icon: Icons.calendar_month,
                        iconSize: 20,
                        text:
                            '${_formatDate(widget.habit.startDate, langCode)} - ${_formatDate(widget.habit.endDate, langCode)}',
                        fontSize: AppFontSize.labelLarge,
                      ),
                      _HabitItem._spacing,
                      // IconWithText(
                      //   icon: Icons.access_time,
                      //   text: widget.habit.reminderTime ?? '__ : __',
                      //   iconSize: 20,
                      //   fontSize: AppFontSize.labelLarge,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.isSelected) ...[
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.marginM,
                    vertical: AppSpacing.marginS),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSpacing.radiusS),
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 50,
              ),
            )
          ]
        ],
      ),
    );
  }

  String _formatDate(DateTime date, [String langCode = 'en']) {
    return DateTimeHelper.formatFullDate(
      date,
      pattern: langCode == LanguageCode.vi.name
          ? DateTimeHelper.vietnameseDateFormat
          : DateTimeHelper.englishDateFormat,
    );
  }
}
