import 'package:intl/intl.dart';
import 'package:moment_dart/moment_dart.dart';

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

  static bool isToday(DateTime? date) {
    if (date == null) return false;
    return DateTime.now().toMoment().isAtSameDayAs(date);
  }

  static Map<int, String> get getWeekDays {
    var formatter = DateFormat.EEEE();
    var now = DateTime.now();
    var days = <int, String>{};

    for (int i = 1; i <= 7; i++) {
      final weekdayDate = now.add(Duration(days: i - now.weekday));
      days[i] = formatter.format(weekdayDate);
    }

    return days;
  }

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

  static String getTimeTrackerFromSecond(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
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

  static String formatDuration(Duration duration) {
    final years = duration.inDays ~/ 365;
    final months = (duration.inDays % 365) ~/ 30;
    final days = (duration.inDays % 365) % 30;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    final parts = <String>[];
    if (years > 0) parts.add('$years year${years > 1 ? 's' : ''}');
    if (months > 0) parts.add('$months month${months > 1 ? 's' : ''}');
    if (days > 0) parts.add('$days day${days > 1 ? 's' : ''}');
    if (hours > 0) parts.add('$hours hour${hours > 1 ? 's' : ''}');
    if (minutes > 0) parts.add('$minutes minute${minutes > 1 ? 's' : ''}');
    if (seconds > 0 || parts.isEmpty) {
      parts.add('$seconds second${seconds > 1 ? 's' : ''}');
    }

    return parts
        .join(', ')
        .replaceAllMapped(RegExp(r', (?!.*, )'), (match) => ' and ');
  }

  // Specific
  // History
  static List<DateTime> getDatesByStatus(
    List<HabitHistory> histories,
    DayStatus status,
  ) {
    return histories
        .where((e) => e.executionStatus == status)
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
