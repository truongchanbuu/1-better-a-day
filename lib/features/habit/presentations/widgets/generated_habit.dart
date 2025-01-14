import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/habit_category.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/helpers/date_time_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';
import '../../domain/entities/habit_entity.dart';
import '../../domain/entities/habit_icon.dart';
import '../helper/shared_habit_action.dart';
import 'crud_habit/add_habit_drop_down_field.dart';
import 'crud_habit/date_field.dart';
import 'crud_habit/pick_icon_field.dart';
import 'crud_habit/reminder_times_list.dart';

class GeneratedHabit extends StatefulWidget {
  final HabitEntity habit;
  final void Function(HabitEntity habit) onEdit;

  const GeneratedHabit({super.key, required this.habit, required this.onEdit});

  @override
  State<GeneratedHabit> createState() => GeneratedHabitState();
}

class GeneratedHabitState extends State<GeneratedHabit> {
  bool _isEditMode = false;
  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late final TextEditingController _goalController;
  late HabitEntity _editedHabit;

  Set<String> _reminderTimes = {};
  late HabitCategory habitCategory;
  late HabitIcon habitIcon;
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    _editedHabit = widget.habit;
    _initControllers();
    _reminderTimes = _editedHabit.reminderTimes;
    startDate = _editedHabit.startDate;
    endDate = _editedHabit.endDate;
    habitCategory = _editedHabit.habitCategory;
    habitIcon = _editedHabit.habitIcon;
  }

  void _initControllers() {
    _titleController = TextEditingController(text: _editedHabit.habitTitle);
    _descController = TextEditingController(text: _editedHabit.habitDesc);
    _goalController =
        TextEditingController(text: _editedHabit.habitGoal.goalDesc);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
      if (!_isEditMode) {
        _titleController.text = _titleController.text.isNotEmpty
            ? _titleController.text
            : _editedHabit.habitTitle;
        _descController.text = _descController.text.isNotEmpty
            ? _descController.text
            : _editedHabit.habitDesc;
        _goalController.text = _goalController.text.isNotEmpty
            ? _goalController.text
            : _editedHabit.habitGoal.goalDesc;

        _editedHabit = _editedHabit.copyWith(
          habitTitle: _titleController.text,
          habitDesc: _descController.text,
          habitGoal:
              widget.habit.habitGoal.copyWith(goalDesc: _goalController.text),
          startDate: startDate,
          endDate: endDate,
          reminderTimes: _reminderTimes,
          habitCategory: habitCategory,
          habitIcon: habitIcon,
        );
      }
    });
  }

  Widget _buildEditableField(String title, TextEditingController controller,
      {int? maxLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: context.isDarkMode ? AppColors.lightText : AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.marginXS),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color:
                context.isDarkMode ? AppColors.darkText : AppColors.lightText,
            borderRadius:
                const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                spreadRadius: 2,
              )
            ],
          ),
          padding: const EdgeInsets.all(AppSpacing.paddingM),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.current.habit_generated_title,
                style: TextStyle(
                  color: context.isDarkMode
                      ? AppColors.lightText
                      : AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.h3,
                ),
              ),
              const SizedBox(height: AppSpacing.marginM),
              if (_isEditMode) ...[
                _buildEditableField(S.current.habit_name, _titleController),
                const SizedBox(height: AppSpacing.marginM),
                _buildEditableField(S.current.habit_desc, _descController),
                const SizedBox(height: AppSpacing.marginM),
                _buildEditableField(S.current.habit_goal, _goalController),
              ] else ...[
                _GeneratedHabitDataRow(
                  title: S.current.habit_name,
                  info: _editedHabit.habitTitle,
                ),
                const SizedBox(height: AppSpacing.marginM),
                _GeneratedHabitDataRow(
                  title: S.current.habit_desc,
                  info: _editedHabit.habitDesc,
                ),
                const SizedBox(height: AppSpacing.marginM),
                _GeneratedHabitDataRow(
                  title: S.current.habit_goal,
                  info: _editedHabit.habitGoal.goalDesc,
                ),
              ],
              const SizedBox(height: AppSpacing.marginM),
              (_isEditMode)
                  ? AddHabitDropdownField(
                      title: S.current.habit_category,
                      onSelected: (value) {
                        final category =
                            HabitCategory.fromMultiLangString(value);
                        if (category != null) {
                          habitCategory = category;
                        }
                      },
                      items: HabitCategory.values
                          .takeWhile((value) => value != HabitCategory.custom)
                          .map((e) => e.categoryName)
                          .toList(),
                      selected: habitCategory.categoryName,
                    )
                  : _GeneratedHabitDataRow(
                      title: S.current.habit_category,
                      info: habitCategory.categoryName,
                    ),
              const SizedBox(height: AppSpacing.marginM),
              PickIconField(
                habitIcon: habitIcon,
                onPickIcon: _isEditMode
                    ? () => SharedHabitAction.onPickIcon(
                          selected: habitIcon,
                          onSelect: _onSelect,
                        )
                    : null,
              ),
              const SizedBox(height: AppSpacing.marginM),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _isEditMode
                        ? DateField(
                            selectedDate: _editedHabit.startDate,
                            onSelected: (selected) {
                              if (selected.isAfter(endDate) &&
                                  selected.isBefore(DateTime.now())) {
                                _showAlert(S.current.invalid_start_date);
                              } else {
                                startDate = selected;
                              }
                            },
                          )
                        : _GeneratedDateRow(
                            title: S.current.start_date,
                            date: _editedHabit.startDate,
                          ),
                  ),
                  const SizedBox(width: AppSpacing.marginS),
                  Expanded(
                    child: _isEditMode
                        ? DateField(
                            selectedDate: _editedHabit.endDate,
                            onSelected: (selected) {
                              if (selected.isBefore(startDate)) {
                                _showAlert(S.current.invalid_end_date);
                              } else {
                                endDate = selected;
                              }
                            },
                          )
                        : _GeneratedDateRow(
                            title: S.current.end_date,
                            date: _editedHabit.endDate,
                          ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.marginM),
              if (!_isEditMode)
                ReminderTimesListSection(reminderTimes: _reminderTimes)
              else
                ReminderTimesListSection(
                  reminderTimes: _reminderTimes,
                  onDeleteItem: (time) =>
                      setState(() => _reminderTimes.remove(time)),
                  onPickReminder: () {},
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.marginS),
        ElevatedButton(
          onPressed: _toggleEditMode,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                context.isDarkMode ? AppColors.primaryDark : AppColors.success,
          ),
          child: IconWithText(
            icon: _isEditMode ? Icons.save : Icons.edit,
            text: _isEditMode ? S.current.save_button : S.current.edit_button,
            iconColor: AppColors.lightText,
            fontColor: AppColors.lightText,
            fontSize: AppFontSize.h3,
          ),
        ),
        const SizedBox(height: AppSpacing.marginM),
        if (!_isEditMode)
          ElevatedButton(
            onPressed: () {
              widget.onEdit(_editedHabit);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.isDarkMode
                  ? AppColors.primaryDark
                  : AppColors.primary,
            ),
            child: IconWithText(
              icon: Icons.check_circle,
              text: S.current.accept_button,
              iconColor: AppColors.lightText,
              fontColor: AppColors.lightText,
              fontSize: AppFontSize.h3,
            ),
          ),
      ],
    );
  }

  void _showAlert(String desc) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: S.current.warning_title,
      desc: desc,
      btnOkText: 'OK',
      btnOkOnPress: () {},
      btnOkColor: AppColors.warning,
    ).show();
  }

  void _onSelect(HabitIcon habitIcon) {
    setState(() {
      this.habitIcon = habitIcon;
    });
  }
}

class _GeneratedDateRow extends StatelessWidget {
  final String title;
  final DateTime date;
  const _GeneratedDateRow({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.h4,
          ),
        ),
        const SizedBox(height: AppSpacing.marginS),
        Text(
          DateTimeHelper.formatFullDate(date,
              locale: context.locale.languageCode),
          style: const TextStyle(fontSize: AppFontSize.bodyLarge),
        )
      ],
    );
  }
}

class _GeneratedHabitDataRow extends StatelessWidget {
  final String title;
  final String info;
  const _GeneratedHabitDataRow({
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.h4,
            ),
            maxLines: 10,
          ),
        ),
        Expanded(
          child: Text(
            info,
            style: const TextStyle(
              fontSize: AppFontSize.bodyLarge,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.right,
            maxLines: 10,
          ),
        ),
      ],
    );
  }
}
