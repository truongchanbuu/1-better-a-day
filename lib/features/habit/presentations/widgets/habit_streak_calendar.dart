import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_spacing.dart';

class HabitStreakCalendar extends StatefulWidget {
  final bool disable;
  final List<DateTime> completedDates;
  final List<DateTime> failedDates;
  final List<DateTime> skippedDates;
  final Function(DateTime firstDate, DateTime? secondDate) onDaySelected;

  const HabitStreakCalendar({
    super.key,
    required this.completedDates,
    required this.failedDates,
    required this.skippedDates,
    required this.onDaySelected,
    this.disable = false,
  });

  @override
  State<HabitStreakCalendar> createState() => _HabitStreakCalendarState();
}

class _HabitStreakCalendarState extends State<HabitStreakCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(AppSpacing.marginS),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        headerStyle: HeaderStyle(
          formatButtonDecoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(AppSpacing.radiusL),
          ),
          formatButtonTextStyle: const TextStyle(color: Colors.white),
          titleCentered: true,
          formatButtonVisible: false,
        ),
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
          CalendarFormat.week: 'Week',
        },
        selectedDayPredicate:
            !widget.disable ? (day) => isSameDay(_selectedDay, day) : null,
        onDaySelected: !widget.disable
            ? (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                widget.onDaySelected(selectedDay, _selectedDay);
              }
            : null,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        calendarStyle: const CalendarStyle(
          outsideDaysVisible: false,
          weekendTextStyle: TextStyle(color: Colors.red),
        ),
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, date, _) {
            return _buildCalendarDay(date);
          },
          selectedBuilder: (context, date, _) {
            return _buildCalendarDay(date, isSelected: true);
          },
          todayBuilder: (context, date, _) {
            return _buildCalendarDay(date, isToday: true);
          },
        ),
      ),
    );
  }

  Widget _buildCalendarDay(
    DateTime date, {
    bool isSelected = false,
    bool isToday = false,
  }) {
    Color backgroundColor;
    Color textColor = Colors.black;
    Border? border;
    IconData? icon;

    if (widget.completedDates.any((d) => isSameDay(d, date))) {
      backgroundColor = AppColors.success;
      textColor = AppColors.lightText;
      icon = FontAwesomeIcons.circleCheck;
    } else if (widget.failedDates.any((d) => isSameDay(d, date))) {
      backgroundColor = AppColors.error;
      textColor = AppColors.lightText;
      icon = FontAwesomeIcons.circleXmark;
    } else if (widget.skippedDates.any((d) => isSameDay(d, date))) {
      backgroundColor = AppColors.warning;
      textColor = AppColors.lightText;
      icon = FontAwesomeIcons.circlePause;
    } else {
      backgroundColor = Colors.transparent;
    }

    if (isToday) {
      border = Border.all(color: AppColors.primary, width: 2);
      backgroundColor = AppColors.primary;
      textColor = AppColors.lightText;
    }

    if (isSelected) {
      border = Border.all(color: Theme.of(context).primaryColor, width: 2);
    }

    return Container(
      margin: const EdgeInsets.all(AppSpacing.marginXS),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusS),
        border: border,
      ),
      child: Center(
        child: icon != null
            ? Icon(
                icon,
                color: textColor,
                size: 20,
              )
            : Text(
                '${date.day}',
                style: TextStyle(
                  color: textColor,
                  fontWeight: isSelected || isToday
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
      ),
    );
  }
}
