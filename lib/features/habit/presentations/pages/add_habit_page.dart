import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/goal_type.dart';
import '../../../../core/enums/habit/goal_unit.dart';
import '../../../../core/enums/habit/habit_category.dart';
import '../../../../core/enums/habit/habit_frequency.dart';
import '../../../../core/enums/habit/habit_time_of_day.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/helpers/alert_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/blocs/internet/internet_bloc.dart';
import '../blocs/validate_habit/validate_habit_bloc.dart';
import '../widgets/crud_habit/add_habit_field.dart';
import '../widgets/crud_habit/add_habit_drop_down_field.dart';
import '../widgets/crud_habit/date_field.dart';
import '../widgets/crud_habit/time_field.dart';
import '../widgets/smart_tooltip.dart';

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({super.key});

  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController freqController;
  late final TextEditingController _customUnitController;

  List<String> units = GoalUnit.values.map((unit) => unit.name).toList();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    freqController = TextEditingController(text: freqNum.toString());
    _customUnitController = TextEditingController();
  }

  @override
  void dispose() {
    freqController.dispose();
    _customUnitController.dispose();
    super.dispose();
  }

  TimeOfDay? _selectedTime;

  HabitFrequency _habitFreq = HabitFrequency.daily;
  int freqNum = HabitFrequency.daily.inNum!;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 21));

  String? get currentTimeOfDay =>
      HabitTimeOfDay.getPartOfDay(_selectedTime)?.toUpperCaseFirstLetter;

  String get currentFrequency => _habitFreq.name.toUpperCaseFirstLetter;

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
                listener: (context, state) {
                  if (state is ValidateFailed) {
                    AlertHelper.showAwesomeSnackBar(
                      context,
                      S.current.failure_title,
                      S.current.invalid_form,
                      ContentType.failure,
                    );
                  }
                },
              ),
            ],
            child: BlocBuilder<ValidateHabitBloc, ValidateHabitState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: _buildFields(state),
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
              validator: _generalValidator,
              eventGenerator: (value) => ChangeHabitName(value),
              label: S.current.habit_name,
            ),
            _spacing,
            _buildAddHabitField(
              validator: _generalValidator,
              eventGenerator: (value) => ChangeHabitDesc(value),
              label: S.current.add_habit_desc,
            ),
            _spacing,
            AddHabitField(
              validator: _generalValidator,
              label: S.current.add_goal_desc,
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
                        .map((type) => type.typeName.toUpperCaseFirstLetter)
                        .toList(),
                    onSelected: (value) {
                      if (value?.isNotEmpty ?? false) {
                        context.read<ValidateHabitBloc>().add(ChangeGoalType(
                            GoalType.fromMultiLangString(value!).name));
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
                  child: AddHabitDropdownField(
                    validator: _generalValidator,
                    title: S.current.goal_unit,
                    items: units,
                    onSelected: (value) async {
                      final validateBloc = context.read<ValidateHabitBloc>();
                      if (value?.isNotEmpty ?? false) {
                        if (value == GoalUnit.custom.name) {
                          final customUnit = await _showCustomUnitDialog();
                          if (customUnit is String) {
                            setState(() {
                              units.add(customUnit);
                            });
                          }
                        }

                        validateBloc
                            .add(ChangeGoalTargetUnit(value!.toCamelCase));
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
                  .map((category) => category.categoryName)
                  .toList(),
              title: S.current.habit_category_field_hint,
              onSelected: (value) {
                final category = HabitCategory.fromMultiLangString(value)?.name;
                if (category != null) {
                  context
                      .read<ValidateHabitBloc>()
                      .add(ChangeHabitCategory(category));
                }
              },
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
                      context
                          .read<ValidateHabitBloc>()
                          .add(ChangeEndDate(selected));
                    },
                  ),
                ),
              ],
            ),
            _spacing,
            TimeField(
              labelText: S.current.reminder_section,
              onSelected: (time) {
                setState(() => _selectedTime = time);
                context
                    .read<ValidateHabitBloc>()
                    .add(ChangeRemindTime('${time.hour}:${time.minute}'));
              },
            ),
            _spacing,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: AddHabitDropdownField(
                    validator: _generalValidator,
                    key: ValueKey('frequency_$currentFrequency'),
                    items: HabitFrequency.values
                        .map((time) => time.name.toUpperCaseFirstLetter)
                        .toList(),
                    onSelected: (value) => setState(() {
                      final freqData =
                          HabitFrequency.fromString(value?.toLowerCase());
                      _habitFreq = freqData;
                      freqController.text = freqData == HabitFrequency.custom
                          ? ''
                          : freqData.inNum.toString();
                    }),
                    selected: currentFrequency,
                  ),
                ),
                const SizedBox(width: AppSpacing.marginS),
                Expanded(
                  child: AddHabitField(
                    validator: _generalValidator,
                    controller: freqController,
                    label: S.current.habit_frequency,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.paddingS,
                      vertical: AppSpacing.paddingM,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          freqNum = int.parse(value);
                          freqController.text = value;
                          _habitFreq = HabitFrequency.fromNum(freqNum);
                        });

                        context
                            .read<ValidateHabitBloc>()
                            .add(ChangeFrequency(freqNum));
                      }
                    },
                  ),
                ),
              ],
            ),
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
    TextEditingController? controller,
  }) {
    return AddHabitField(
      controller: controller,
      validator: validator,
      label: label,
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
}
