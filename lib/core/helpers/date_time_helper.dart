import 'package:intl/intl.dart';

import '../../features/habit/domain/entities/habit_history.dart';
import '../enums/day_status.dart';
import 'setting_helper.dart';
import 'setting_helper.dart';

class DateTimeHelper {
  // General
  static const String dawnTimeString = '6:00';
  static const String afternoonTimeString = '12:00';
  static const String duskTimeString = '18:00';

  static String formatFullDate(DateTime date, {String locale = 'en'}) =>
      DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY, locale).format(date);

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
