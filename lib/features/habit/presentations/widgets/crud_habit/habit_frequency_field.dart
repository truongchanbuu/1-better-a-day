import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_tag_editor/tag_editor.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/helpers/date_time_helper.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entities/habit_frequency.dart';

class HabitFrequencyField extends StatefulWidget {
  final HabitFrequency? initialValue;
  final Function(HabitFrequency habitFrequency) onSave;

  const HabitFrequencyField({
    super.key,
    this.initialValue,
    required this.onSave,
  });

  @override
  State<HabitFrequencyField> createState() => _HabitFrequencyFieldState();
}

class _HabitFrequencyFieldState extends State<HabitFrequencyField> {
  late FrequencyType _selectedType;
  TimeInterval? _interval;
  late Set<int> _monthlyDates;
  Set<int>? _weekDays;

  late final GlobalKey<FormState> _formKey;
  late final FocusNode _intervalFocus;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _intervalFocus = FocusNode()..requestFocus();

    _selectedType = widget.initialValue?.type ?? FrequencyType.daily;
    _interval = widget.initialValue?.interval;
    _monthlyDates = widget.initialValue?.monthlyDates ?? {1};
    _weekDays = widget.initialValue?.weekDays ?? {};
  }

  @override
  void dispose() {
    _intervalFocus.dispose();
    super.dispose();
  }

  Widget _buildFrequencyTypeSelector() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.habit_frequency,
          style: const TextStyle(
              fontSize: AppFontSize.bodyLarge, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSpacing.marginS),
        DropdownButtonFormField<FrequencyType>(
          value: _selectedType,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: [
            DropdownMenuItem(
              value: FrequencyType.interval,
              child: Text(S.current.time_interval),
            ),
            DropdownMenuItem(
              value: FrequencyType.daily,
              child: Text(S.current.freq_daily),
            ),
            DropdownMenuItem(
              value: FrequencyType.monthly,
              child: Text(S.current.freq_monthly),
            ),
            DropdownMenuItem(
              value: FrequencyType.weekdays,
              child: Text(S.current.weekday_title),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedType = value;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildIntervalInput() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: _intervalFocus,
                initialValue: _interval?.value.toString() ?? '',
                decoration: InputDecoration(
                  labelText: S.current.freq_value,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2)
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.empty_field;
                  }
                  if (int.parse(value) <= 0) return S.current.invalid_num;
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    _interval = TimeInterval(
                      value: int.parse(value),
                      type: _interval?.type ?? IntervalType.minutes,
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: AppSpacing.marginM),
            Expanded(
              child: DropdownButtonFormField<IntervalType>(
                value: _interval?.type ?? IntervalType.minutes,
                decoration: InputDecoration(
                  labelText: S.current.goal_unit,
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(
                    value: IntervalType.minutes,
                    child: Text(S.current.minute_unit),
                  ),
                  DropdownMenuItem(
                    value: IntervalType.hours,
                    child: Text(S.current.hour_unit),
                  ),
                  DropdownMenuItem(
                    value: IntervalType.days,
                    child: Text(S.current.day_unit),
                  ),
                  DropdownMenuItem(
                    value: IntervalType.months,
                    child: Text(S.current.month_title.toLowerCase()),
                  ),
                ],
                onChanged: (value) {
                  if (value != null && _interval != null) {
                    setState(() {
                      _interval =
                          TimeInterval(value: _interval!.value, type: value);
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeekDaySelector() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.current.weekday_title),
        const SizedBox(height: AppSpacing.marginS),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: DateTimeHelper.getWeekDays.entries.map((entry) {
            int key = entry.key;
            return FilterChip(
              selectedColor: AppColors.primary,
              checkmarkColor: Colors.white,
              label: Text(
                entry.value,
                style: TextStyle(
                  color: (_weekDays?.contains(key) ?? false)
                      ? AppColors.lightText
                      : null,
                ),
              ),
              selected: _weekDays?.contains(key) ?? false,
              onSelected: (bool selected) {
                setState(() {
                  _weekDays ??= {};
                  if (selected) {
                    _weekDays!.add(key);
                  } else {
                    _weekDays!.remove(key);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  String? errorMessage;
  Widget _buildMonthlyDateInput() {
    return TagEditor(
      length: _monthlyDates.length,
      delimiters: const [' '],
      tagBuilder: (BuildContext context, int index) {
        return Chip(
          label: Text(
            _monthlyDates.elementAt(index).toString(),
          ),
          deleteIconColor: Colors.grey,
          onDeleted: () {
            setState(() {
              _monthlyDates.remove(_monthlyDates.elementAt(index));
            });
          },
        );
      },
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9 ]*$'))
      ],
      inputDecoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(AppSpacing.paddingS),
        errorText: errorMessage,
      ),
      onTagChanged: (String value) {
        int? intValue = int.tryParse(value);
        if (intValue != null && intValue > 0 && intValue < 32) {
          setState(() {
            errorMessage = null;
            _monthlyDates.add(intValue);
          });
        } else {
          setState(() {
            errorMessage = 'Date must be between 1 - 31';
          });
        }
      },
    );
  }

  Widget _buildFrequencyConfigSection() {
    return switch (_selectedType) {
      FrequencyType.interval => _buildIntervalInput(),
      FrequencyType.weekdays => _buildWeekDaySelector(),
      FrequencyType.monthly => _buildMonthlyDateInput(),
      _ => const SizedBox.shrink(),
    };
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      HabitFrequency frequency = switch (_selectedType) {
        FrequencyType.interval => HabitFrequency(
            type: _selectedType,
            interval:
                TimeInterval(value: _interval!.value, type: _interval!.type),
          ),
        FrequencyType.daily => HabitFrequency(
            type: _selectedType,
            interval: const TimeInterval(value: 1, type: IntervalType.days),
          ),
        FrequencyType.weekdays => HabitFrequency(
            type: _selectedType,
            weekDays: _weekDays?.isNotEmpty ?? false ? _weekDays : {1},
          ),
        FrequencyType.monthly => HabitFrequency(
            type: _selectedType,
            monthlyDates: _monthlyDates.isNotEmpty ? _monthlyDates : {1},
          ),
      };

      widget.onSave(frequency);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.paddingM),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFrequencyTypeSelector(),
                const SizedBox(height: AppSpacing.marginM),
                _buildFrequencyConfigSection(),
                const SizedBox(height: AppSpacing.marginS),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  child: Text(
                    S.current.accept_button,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSize.h4,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.marginS),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
