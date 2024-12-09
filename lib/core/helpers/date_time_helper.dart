import 'package:intl/intl.dart';

import '../../features/habit/domain/enitites/habit_history.dart';
import '../enums/day_status.dart';

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

  // Specific
  // History
  static List<DateTime> getDatesByStatus(
    List<HabitHistory> histories,
    DayStatus status,
  ) {
    return histories
        .where((e) => e.status == status.name)
        .map((e) => e.date)
        .toList();
  }
}
