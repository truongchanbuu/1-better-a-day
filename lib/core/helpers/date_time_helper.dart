import 'package:intl/intl.dart';

import '../../features/habit/domain/entities/habit_history.dart';
import '../enums/habit/day_status.dart';
import '../enums/habit/habit_time_of_day.dart';

class DateTimeHelper {
  // General
  static const vietnameseDateFormat = 'dd/MM/yyyy';
  static const englishDateFormat = 'yyyy/MM/dd';
  static const String dawnTimeString = '6:00';
  static const String afternoonTimeString = '12:00';
  static const String duskTimeString = '18:00';
  static const String nightTimeString = '21:00';

  static String formatFullDate(DateTime date,
          {String locale = 'en', String? pattern}) =>
      DateFormat((pattern ?? DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY), locale)
          .format(date);
  static DateTime? getTimeFromString(String? time) {
    final formatted = DateFormat.jm().tryParse(time ?? '');

    DateTime now = DateTime.now();
    return formatted != null
        ? DateTime(
            now.year, now.month, now.day, formatted.hour, formatted.minute)
        : null;
  }

  static String? formatTime(DateTime? date) {
    return date != null
        ? DateFormat(DateFormat.HOUR_MINUTE).format(date)
        : null;
  }

  static DateTime? parseDateString(String dateStr) {
    final format = RegExp(r"(\d{2})/(\d{2})/(\d{4})");
    final match = format.firstMatch(dateStr);

    if (match != null) {
      final day = int.parse(match.group(1)!);
      final month = int.parse(match.group(2)!);
      final year = int.parse(match.group(3)!);

      return DateTime(year, month, day);
    } else {
      return null;
    }
  }

  static DateTime? timeFromHabitTimeOfDay(HabitTimeOfDay? timeOfDay) =>
      switch (timeOfDay) {
        HabitTimeOfDay.morning =>
          DateTimeHelper.getTimeFromString(DateTimeHelper.dawnTimeString),
        HabitTimeOfDay.afternoon =>
          DateTimeHelper.getTimeFromString(DateTimeHelper.afternoonTimeString),
        HabitTimeOfDay.evening =>
          DateTimeHelper.getTimeFromString(DateTimeHelper.duskTimeString),
        HabitTimeOfDay.night =>
          DateTimeHelper.getTimeFromString(DateTimeHelper.nightTimeString),
        _ => null,
      };

  static int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  static List<String> getLocalizedDayNames(
      {String locale = 'en', DateTime? date}) {
    final DateFormat formatter = DateFormat.E(locale);
    final List<String> dayNames = [];
    final DateTime dateTime = date ?? DateTime.now();
    for (int i = 0; i < 7; i++) {
      dayNames.add(formatter.format(dateTime.add(Duration(days: i))));
    }
    return dayNames;
  }

  static String getDayName(DateTime date, {String locale = 'en'}) {
    return DateFormat.E(locale).format(date);
  }

  // Specific
  // History
  static List<DateTime> getDatesByStatus(
    List<HabitHistory> histories,
    DayStatus status,
  ) {
    return histories
        .where((e) => e.executionStatus == status.name)
        .map((e) => e.date)
        .toList();
  }

  // Statistic
  static const List<String> timeSlots = [
    '4:00 - 8:00',
    '8:00 - 11:00',
    '11:00 - 14:00',
    '14:00 - 17:00',
    '17:00 - 20:00',
    '20:00 - 23:00',
  ];
}
