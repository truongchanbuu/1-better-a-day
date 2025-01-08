import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit/habit_time_of_day.dart';
import '../../../../../core/extensions/time_of_day_extension.dart';
import '../../../../../core/helpers/date_time_helper.dart';

class TimeField extends StatefulWidget {
  final String? labelText;
  final HabitTimeOfDay? timeOfDay;
  final Function(TimeOfDay time)? onSelected;
  final bool isAlwaysFloating;
  final FormFieldValidator<String>? validator;
  final String? initialValue;

  const TimeField({
    super.key,
    this.labelText,
    this.timeOfDay,
    this.onSelected,
    this.isAlwaysFloating = true,
    this.validator,
    this.initialValue,
  });

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  late final TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(
        text: widget.timeOfDay != null
            ? DateTimeHelper.formatTime(
                DateTimeHelper.timeFromHabitTimeOfDay(widget.timeOfDay))
            : widget.initialValue);
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => widget.validator?.call(
        _editingController.text.isEmpty
            ? DateTimeHelper.formatTime(
                DateTimeHelper.timeFromHabitTimeOfDay(widget.timeOfDay))
            : _editingController.text,
      ),
      controller: _editingController,
      onTap: _openTimePicker,
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        floatingLabelBehavior:
            widget.isAlwaysFloating ? FloatingLabelBehavior.always : null,
        hintText: DateTimeHelper.formatTime(
                DateTimeHelper.timeFromHabitTimeOfDay(widget.timeOfDay)) ??
            ' __ : __ ',
        suffixIcon: _editingController.text.isNotEmpty
            ? const Icon(
                FontAwesomeIcons.clock,
                color: AppColors.grayText,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingM,
          vertical: AppSpacing.paddingM,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Future<void> _openTimePicker() async {
    final now = DateTime.now();
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: DateTimeHelper.timeFromHabitTimeOfDay(widget.timeOfDay)?.hour ??
            now.hour,
        minute:
            DateTimeHelper.timeFromHabitTimeOfDay(widget.timeOfDay)?.minute ??
                now.minute,
      ),
    );

    if (selectedTime != null) {
      setState(() {
        _editingController.text = selectedTime.toShortString;
      });

      widget.onSelected?.call(selectedTime);
    }
  }
}
