import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../generated/l10n.dart';

class HabitDatePicker extends StatefulWidget {
  final void Function(String selected) onSelected;
  const HabitDatePicker({super.key, required this.onSelected});

  @override
  State<HabitDatePicker> createState() => HabitDatePickerState();
}

class HabitDatePickerState extends State<HabitDatePicker> {
  bool isRangePicker = false;
  DateTime? selectedDate;
  DateTime? startDate;
  DateTime? endDate;

  static const _pickerStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: AppFontSize.h4,
  );
  static const _titlePadding = EdgeInsets.only(top: AppSpacing.paddingM);
  void _showDatePicker() {
    if (!isRangePicker) {
      BottomPicker.date(
        dismissable: true,
        initialDateTime: selectedDate ?? DateTime.now(),
        maxDateTime: DateTime.now(),
        buttonContent: _buildButtonContent(),
        buttonSingleColor: AppColors.primary,
        pickerTitle: Text(S.current.select_date_title),
        pickerTextStyle: _pickerStyle,
        titlePadding: _titlePadding,
        onSubmit: (date) {
          setState(() {
            selectedDate = date;
          });
        },
      ).show(context);
    } else {
      BottomPicker.range(
        dismissable: true,
        initialFirstDate: startDate ?? DateTime.now(),
        initialSecondDate: endDate ?? DateTime.now(),
        maxFirstDate: DateTime.now(),
        maxSecondDate: DateTime.now(),
        buttonContent: _buildButtonContent(),
        buttonSingleColor: AppColors.primary,
        pickerTitle: Text(S.current.select_range_date_title),
        pickerTextStyle: _pickerStyle,
        titlePadding: _titlePadding,
        onRangeDateSubmitPressed: (startDate, endDate) {
          setState(() {
            this.startDate = startDate;
            this.endDate = endDate;
          });
        },
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.paddingM),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        borderRadius: BorderRadius.circular(AppSpacing.radiusM),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isRangePicker ? 'Date Range Picker' : 'Date Picker',
                style: const TextStyle(
                  fontSize: AppFontSize.h3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  isRangePicker ? Icons.calendar_today : Icons.date_range,
                  color: Colors.blue,
                ),
                onPressed: () {
                  setState(() {
                    isRangePicker = !isRangePicker;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.marginM),
          GestureDetector(
            onTap: _showDatePicker,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.paddingMS,
                horizontal: AppSpacing.paddingM,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month, color: Colors.blue),
                  const SizedBox(width: AppSpacing.marginM),
                  Expanded(
                    child: Text(
                      isRangePicker
                          ? startDate != null && endDate != null
                              ? '${formatDate(startDate!)} - ${formatDate(endDate!)}'
                              : S.current.select_range_date_title
                          : selectedDate != null
                              ? formatDate(selectedDate!)
                              : S.current.select_date_title,
                      style: const TextStyle(
                        fontSize: AppFontSize.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.marginM),
          ElevatedButton(
            onPressed: () {
              if (!isRangePicker) {
                widget.onSelected(selectedDate?.toIso8601String() ?? '');
              } else {
                widget.onSelected(
                    '${startDate?.toIso8601String()} - ${endDate?.toIso8601String()}');
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.search, color: AppColors.lightText),
                const SizedBox(width: AppSpacing.marginS),
                Text(
                  S.current.find_button,
                  style: const TextStyle(color: AppColors.lightText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonContent() {
    return Center(
      child: Text(
        S.current.select_button,
        style: const TextStyle(
            color: AppColors.lightText, fontWeight: FontWeight.bold),
      ),
    );
  }

  String formatDate(DateTime? date) => date?.toMoment().formatDateShort() ?? '';
}
