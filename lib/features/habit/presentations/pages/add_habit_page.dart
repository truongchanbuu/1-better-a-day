import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/goal_type.dart';
import '../../../../core/enums/habit/goal_unit.dart';
import '../../../../core/enums/habit/habit_category.dart';
import '../../../../core/enums/habit/habit_time_of_day.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/extensions/time_of_day_extension.dart';
import '../../../../core/helpers/alert_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../notification/presentations/blocs/reminder/reminder_bloc.dart';
import '../../../shared/presentations/blocs/internet/internet_bloc.dart';
import '../../domain/entities/habit_frequency.dart';
import '../../domain/entities/habit_icon.dart';
import '../blocs/crud/habit_crud_bloc.dart';
import '../blocs/validate_habit/validate_habit_bloc.dart';
import '../helpers/shared_habit_action.dart';
import '../widgets/crud_habit/add_habit_field.dart';
import '../widgets/crud_habit/add_habit_drop_down_field.dart';
import '../widgets/crud_habit/date_field.dart';
import '../widgets/crud_habit/habit_frequency_field.dart';
import '../widgets/crud_habit/pick_icon_field.dart';
import '../widgets/crud_habit/reminder_times_list.dart';
import '../widgets/smart_tooltip.dart';

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({super.key});

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _habitTitleController;
  late final TextEditingController _goalDescController;
  late final TextEditingController _habitDescController;
  late final TextEditingController _customUnitController;
  late final TextEditingController _freqController;

  List<String> units = GoalUnit.values
      .where((e) => e != GoalUnit.custom)
      .map((unit) => unit.unitName)
      .toList();

  TimeOfDay? _selectedTime;
  HabitIcon? _habitIcon;
  late Set<String> _reminderTimes;

  HabitFrequency _habitFrequency = HabitFrequency.daily;

  @override
  void initState() {
    super.initState();
    _reminderTimes = {};
    _formKey = GlobalKey();
    _habitTitleController = TextEditingController();
    _habitDescController = TextEditingController();
    _goalDescController = TextEditingController();
    _customUnitController = TextEditingController();
    _freqController =
        TextEditingController(text: _habitFrequency.getDisplayText());
  }

  @override
  void dispose() {
    _habitTitleController.dispose();
    _goalDescController.dispose();
    _habitDescController.dispose();
    _customUnitController.dispose();
    _freqController.dispose();
    super.dispose();
  }

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 21));

  String? get currentTimeOfDay =>
      HabitTimeOfDay.getPartOfDay(_selectedTime)?.name.toUpperCaseFirstLetter;

  static const _spacing = SizedBox(height: AppSpacing.marginM);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: MultiBlocListener(
            listeners: [
              BlocListener<InternetBloc, InternetState>(
                listener: (context, internetState) {
                  if (internetState is InternetDisconnected) {
                    AlertHelper.showAwesomeSnackBar(
                      context,
                      S.current.internet_failure_title,
                      S.current.goal_recommend_with_no_internet_alert,
                      ContentType.failure,
                    );
                  }
                },
              ),
              BlocListener<ValidateHabitBloc, ValidateHabitState>(
                listener: (context, validateState) {
                  if (validateState is ValidateFailed) {
                    AlertHelper.showAwesomeSnackBar(
                      context,
                      S.current.failure_title,
                      '${S.current.invalid_form}: ${validateState.errorMessage}',
                      ContentType.failure,
                    );
                  } else if (validateState is ValidateSucceed) {
                    context
                        .read<HabitCrudBloc>()
                        .add(AddHabit(validateState.habit));
                  }
                },
              ),
              BlocListener<HabitCrudBloc, HabitCrudState>(
                listener: (context, habitCrudState) {
                  if (habitCrudState is HabitCrudSucceed &&
                      habitCrudState.action == HabitCrudAction.add) {
                    context.read<ReminderBloc>().add(
                        ScheduleReminder(habit: habitCrudState.habits.first));
                    // AwesomeDialog(
                    //   context: context,
                    //   dialogType: DialogType.success,
                    //   title: S.current.success_title,
                    //   desc: S.current.add_success,
                    //   btnOkOnPress: () =>
                    //       Navigator.popUntil(context, ModalRoute.withName('/')),
                    // ).show();
                  }
                },
              ),
              SharedHabitAction.reminderPermissionListener(_onPickReminder),
            ],
            child: BlocBuilder<HabitCrudBloc, HabitCrudState>(
              builder: (context, state) {
                if (state is Executing) {
                  return const LoadingIndicator(
                      indicatorType: Indicator.pacman);
                }

                return BlocBuilder<ValidateHabitBloc, ValidateHabitState>(
                  builder: (context, validateState) {
                    if (validateState is Validating) {
                      return const LoadingIndicator(
                          indicatorType: Indicator.pacman);
                    }

                    _habitTitleController.text = validateState.habitName;
                    _goalDescController.text = validateState.habitGoal.goalDesc;
                    _habitDescController.text = validateState.habitDesc;

                    return SingleChildScrollView(
                      child: _buildFields(validateState),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor:
          context.isDarkMode ? AppColors.darkText : AppColors.lightText,
      surfaceTintColor:
          context.isDarkMode ? AppColors.darkText : AppColors.lightText,
      iconTheme: IconThemeData(
        color: context.isDarkMode ? AppColors.lightText : AppColors.darkText,
      ),
      actions: [
        SuperTooltip(
          showBarrier: true,
          showDropBoxFilter: true,
          sigmaX: 10,
          sigmaY: 10,
          content: const SmartTooltip(),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.paddingM),
            child: Icon(Icons.info_outline_rounded, color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildFields(ValidateHabitState state) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.marginM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAddHabitField(
              controller: _habitTitleController,
              validator: _generalValidator,
              eventGenerator: (value) => ChangeHabitName(value),
              label: S.current.habit_name,
              hintText: S.current.habit_name,
            ),
            _spacing,
            _buildAddHabitField(
              controller: _habitDescController,
              validator: _generalValidator,
              eventGenerator: (value) => ChangeHabitDesc(value),
              label: S.current.habit_desc,
              hintText: S.current.add_habit_desc,
            ),
            _spacing,
            AddHabitField(
              controller: _goalDescController,
              validator: _generalValidator,
              label: S.current.goal_desc,
              hintText: S.current.add_goal_desc,
              maxLines: 5,
              onChanged: (value) =>
                  context.read<ValidateHabitBloc>().add(ChangeHabitGoal(value)),
            ),
            _spacing,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: AddHabitDropdownField(
                    validator: _generalValidator,
                    title: S.current.goal_type,
                    items: GoalType.values
                        .takeWhile((value) => value != GoalType.custom)
                        .map((type) => type.typeName.toUpperCaseFirstLetter)
                        .toList(),
                    onSelected: (value) {
                      if (value?.isNotEmpty ?? false) {
                        context.read<ValidateHabitBloc>().add(ChangeGoalType(
                            GoalType.fromMultiLangString(value!)));
                      }
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.marginS),
                Expanded(
                  child: AddHabitField(
                    validator: _generalValidator,
                    label: S.current.goal_unit_value,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3)
                    ],
                    onChanged: (value) {
                      double numValue = double.tryParse(value) ?? 0;
                      if (numValue > 0) {
                        context
                            .read<ValidateHabitBloc>()
                            .add(ChangeGoalTargetValue(numValue));
                      }
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.marginS),
                Expanded(
                  flex: 2,
                  child: AddHabitDropdownField(
                    validator: _generalValidator,
                    title: S.current.goal_unit,
                    items: units,
                    onSelected: (value) async {
                      final validateBloc = context.read<ValidateHabitBloc>();
                      if (value?.isNotEmpty ?? false) {
                        final goalUnit =
                            GoalUnit.fromMultiLanguageString(value);

                        if (value == GoalUnit.custom.name) {
                          final customUnit = await _showCustomUnitDialog();
                          if (customUnit is String) {
                            setState(() {
                              units.add(customUnit);
                            });
                          }
                        }

                        validateBloc.add(ChangeGoalTargetUnit(goalUnit));
                      }
                    },
                  ),
                ),
              ],
            ),
            _spacing,
            AddHabitDropdownField(
              validator: _generalValidator,
              items: HabitCategory.values
                  .takeWhile((value) => value != HabitCategory.custom)
                  .map((category) => category.categoryName)
                  .toList(),
              title: S.current.habit_category_field_hint,
              onSelected: (value) {
                final category = HabitCategory.fromMultiLangString(value);
                if (category != null) {
                  context
                      .read<ValidateHabitBloc>()
                      .add(ChangeHabitCategory(category));
                }
              },
            ),
            _spacing,
            PickIconField(
              onPickIcon: _onPickIcon,
              habitIcon: _habitIcon,
            ),
            _spacing,
            AddHabitField(
              controller: _freqController,
              onTap: _onHabitFrequency,
              label: S.current.habit_frequency,
              readOnly: true,
            ),
            _spacing,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: DateField(
                    validator: (value) {
                      final message = _generalValidator(value);

                      if (startDate.isAfter(endDate)) {
                        return S.current.invalid_start_date;
                      }

                      return message;
                    },
                    labelText: S.current.start_date,
                    selectedDate: startDate,
                    onSelected: (selected) {
                      startDate = selected;
                      context
                          .read<ValidateHabitBloc>()
                          .add(ChangeStartDate(selected));
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.marginS),
                Expanded(
                  child: DateField(
                    validator: (value) {
                      final message = _generalValidator(value);

                      if (endDate.isBefore(endDate)) {
                        return S.current.invalid_end_date;
                      }

                      return message;
                    },
                    labelText: S.current.end_date,
                    selectedDate: DateTime.now().add(const Duration(days: 21)),
                    onSelected: (selected) {
                      endDate = selected;
                      context
                          .read<ValidateHabitBloc>()
                          .add(ChangeEndDate(selected));
                    },
                  ),
                ),
              ],
            ),
            if (_habitFrequency.type != FrequencyType.interval) ...[
              _spacing,
              BlocBuilder<ReminderBloc, ReminderState>(
                builder: (context, state) => ReminderTimesListSection(
                  reminderTimes: _reminderTimes,
                  onPickReminder: () async =>
                      await SharedHabitAction.onGrantPermissionAndPickReminder(
                          context, state, _onPickReminder),
                  onDeleteItem: (item) =>
                      setState(() => _reminderTimes.remove(item)),
                ),
              ),
            ],
            _spacing,
            ElevatedButton(
              onPressed: _onHabitCreate,
              child: Text(
                S.current.generate_habit_button,
                style: const TextStyle(
                  color: AppColors.lightText,
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _generalValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return S.current.empty_field;
    }

    num? valueNum = num.tryParse(value!);
    if (valueNum != null) {
      if (valueNum <= 0) {
        return S.current.invalid_num;
      }
    }

    return null;
  }

  void _onHabitCreate() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ValidateHabitBloc>().add(ValidateHabit());
    }
  }

  Widget _buildAddHabitField({
    required String label,
    required ValidateHabitEvent Function(String) eventGenerator,
    String? Function(String? value)? validator,
    int? maxLines,
    String? hintText,
    TextEditingController? controller,
  }) {
    return AddHabitField(
      label: label,
      hintText: hintText,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      onChanged: (value) {
        if (value.length > 2) {
          context.read<ValidateHabitBloc>().add(eventGenerator(value));
        }
      },
    );
  }

  Future<String?> _showCustomUnitDialog() async {
    String? errorMessage;
    return await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setInnerState) => SimpleDialog(
          title: Text(
            S.current.custom_unit.toUpperCaseFirstLetter,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding: const EdgeInsets.all(AppSpacing.paddingM),
          children: [
            TextField(
              focusNode: FocusNode()..requestFocus(),
              controller: _customUnitController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                errorText: errorMessage,
              ),
            ),
            TextButton(
              onPressed: () {
                if (_customUnitController.text.isEmpty) {
                  setInnerState(() => errorMessage = S.current.empty_field);
                } else {
                  errorMessage = null;
                  Navigator.of(context).pop(_customUnitController.text);
                }
              },
              child: Text(
                S.current.accept_button,
                style: const TextStyle(color: AppColors.primary),
              ),
            ),
            TextButton(
              onPressed: () {
                errorMessage = null;
                Navigator.pop(context);
              },
              child: Text(
                S.current.cancel_button,
                style: const TextStyle(color: AppColors.error),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onHabitFrequency() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => HabitFrequencyField(
        initialValue: _habitFrequency,
        onSave: (habitFrequency) {
          setState(() {
            _habitFrequency = habitFrequency;
            _freqController.text = _habitFrequency.getDisplayText();
          });

          context
              .read<ValidateHabitBloc>()
              .add(ChangeFrequency(_habitFrequency));

          if (_habitFrequency.type == FrequencyType.interval) {
            context.read<ValidateHabitBloc>().add(ChangeRemindTime({}));
          }

          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _onPickReminder() async {
    final validateBloc = context.read<ValidateHabitBloc>();
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        _reminderTimes = _reminderTimes
          ..add(selectedTime.toShortString)
          ..toList().sort()
          ..toSet();
      });

      validateBloc.add(ChangeRemindTime(_reminderTimes));
    }
  }

  void _onPickIcon() {
    SharedHabitAction.onPickIcon(
      onSelect: (habitIcon) {
        setState(() {
          _habitIcon = habitIcon;
        });

        if (_habitIcon != null) {
          context.read<ValidateHabitBloc>().add(ChangeHabitIcon(_habitIcon!));
        }
      },
    );
  }
}
