import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../generated/l10n.dart';

part 'habit_frequency.g.dart';

@JsonSerializable(explicitToJson: true)
class HabitFrequency extends Equatable {
  final FrequencyType type;
  @JsonKey(fromJson: timeIntervalFromJson)
  final TimeInterval? interval;
  // 1-31
  final Set<int>? monthlyDates;
  // T2-CN => 1-7
  final Set<int>? weekDays;
  final DateTime? lastCompletionTime;

  HabitFrequency({
    required this.type,
    this.interval,
    this.monthlyDates,
    this.weekDays,
    this.lastCompletionTime,
  })  : assert(
          interval == null || (interval.value > 0),
          'Interval value must be greater than 0',
        ),
        assert(
          monthlyDates == null ||
              (monthlyDates.isNotEmpty &&
                  monthlyDates.every((date) => date >= 1 && date <= 31)),
          'Monthly dates must be between 1 and 31',
        ),
        assert(
          weekDays == null ||
              (weekDays.isNotEmpty &&
                  weekDays.every((day) => day >= 1 && day <= 7)),
          'Week days must be between 1 and 7',
        );

  // Predefined frequencies
  static var daily = HabitFrequency(type: FrequencyType.daily);
  static var weekly =
      HabitFrequency(type: FrequencyType.weekdays, weekDays: {2});

  // Factory methods
  static HabitFrequency everyNMinutes(int n) {
    assert(n > 0, 'Minutes must be greater than 0');
    return HabitFrequency(
      type: FrequencyType.interval,
      interval: TimeInterval(value: n, type: IntervalType.minutes),
    );
  }

  static HabitFrequency everyNHours(int n) {
    assert(n > 0, 'Hours must be greater than 0');
    return HabitFrequency(
      type: FrequencyType.interval,
      interval: TimeInterval(value: n, type: IntervalType.hours),
    );
  }

  static HabitFrequency onWeekDays(Set<int> days) {
    assert(
      days.every((day) => day >= 1 && day <= 7),
      'Week days must be between 1 and 7',
    );
    return HabitFrequency(type: FrequencyType.weekdays, weekDays: days);
  }

  static HabitFrequency monthlyOnDate(Set<int> date) {
    assert(
      (date.isNotEmpty && date.every((date) => date >= 1 && date <= 31)),
      'Monthly dates must be between 1 and 31',
    );
    return HabitFrequency(
      type: FrequencyType.monthly,
      monthlyDates: date,
    );
  }

  static HabitFrequency everyNMonths(int n) {
    assert(n > 0, 'Months must be greater than 0');
    return HabitFrequency(
        type: FrequencyType.interval,
        interval: TimeInterval(value: n, type: IntervalType.months));
  }

  // Display text
  String getDisplayText() {
    return switch (type) {
      FrequencyType.daily => S.current.freq_daily,
      FrequencyType.interval => _formatInterval,
      FrequencyType.weekdays => _formatWeekDays,
      FrequencyType.monthly => _formatMonthly,
    };
  }

  String get _formatMonthly {
    if (monthlyDates?.isEmpty ?? true) return '';

    String getOrdinalSuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    List<String> formattedDays = monthlyDates!
        .sorted((a, b) => a - b)
        .map((day) => '$day${getOrdinalSuffix(day)}')
        .toList();

    String daysString = formattedDays.length > 1
        ? '${formattedDays.sublist(0, formattedDays.length - 1).join(", ")} and ${formattedDays.last}'
        : formattedDays.first;

    return '$daysString every month';
  }

  String get _formatWeekDays {
    if (weekDays == null || weekDays!.isEmpty) return '';

    final days = weekDays!
        .map((day) => switch (day) {
              1 => 'Monday',
              2 => 'Tuesday',
              3 => 'Wednesday',
              4 => 'Thursday',
              5 => 'Friday',
              6 => 'Saturday',
              7 => 'Sunday',
              _ => ''
            })
        .where((d) => d.isNotEmpty)
        .toList()
      ..sort();

    return 'Every ${days.join(", ")}';
  }

  String get _formatInterval {
    if (interval == null) return '';
    final value = interval!.value;
    return switch (interval!.type) {
      IntervalType.minutes => S.current.every_n_minute(value),
      IntervalType.hours => S.current.every_n_hour(value),
      IntervalType.days => S.current.every_n_day(value),
      IntervalType.months => S.current.every_n_month(value),
    };
  }

  int get frequencyInNum => switch (type) {
        FrequencyType.interval => interval?.value ?? 0,
        FrequencyType.daily => 1,
        FrequencyType.weekdays => weekDays?.length ?? 0,
        FrequencyType.monthly => 1,
      };

  // Helper methods
  bool shouldComplete(DateTime date) {
    return switch (type) {
      FrequencyType.interval => _checkInterval(),
      FrequencyType.daily => true,
      FrequencyType.weekdays => weekDays?.contains(date.weekday) ?? false,
      FrequencyType.monthly => _checkMonthlyDate(date),
    };
  }

  bool _checkMonthlyDate(DateTime date) {
    if (monthlyDates == null || monthlyDates!.isEmpty) {
      return date.day == 1;
    }

    return monthlyDates!.contains(date.day);
  }

  bool _checkInterval() {
    final currentTime = DateTime.now();
    if (interval == null || lastCompletionTime == null) return false;
    final nextDueTime = getNextDueTime();
    return currentTime.isAfter(nextDueTime);
  }

  DateTime getNextDueTime() {
    final now = DateTime.now();
    if (lastCompletionTime == null) return now;

    return switch (type) {
      FrequencyType.daily =>
        DateTime(now.year, now.month, now.day).add(const Duration(days: 1)),
      FrequencyType.interval => _getNextIntervalTime(),
      FrequencyType.weekdays => _calculateNextWeekDay(weekDays?.first ?? 1),
      FrequencyType.monthly => _calculateNextMonthlyDate(),
    };
  }

  DateTime _calculateNextMonthlyDate() {
    final now = DateTime.now();

    final dates = monthlyDates ?? {1};

    final sortedDates = dates.toList()..sort();

    for (final date in sortedDates) {
      if (now.day < date) {
        return DateTime(now.year, now.month, date);
      }
    }

    final nextDate = sortedDates.first;
    return DateTime(now.year, now.month + 1, nextDate);
  }

  DateTime _calculateNextWeekDay(int targetDay) {
    final now = DateTime.now();
    final daysUntilTarget = targetDay - now.weekday;
    return now.add(Duration(
      days: daysUntilTarget <= 0 ? 7 + daysUntilTarget : daysUntilTarget,
    ));
  }

  DateTime _getNextIntervalTime() {
    if (interval == null || lastCompletionTime == null) {
      return DateTime.now();
    }

    return switch (interval!.type) {
      IntervalType.minutes =>
        lastCompletionTime!.add(Duration(minutes: interval!.value)),
      IntervalType.hours =>
        lastCompletionTime!.add(Duration(hours: interval!.value)),
      IntervalType.days =>
        lastCompletionTime!.add(Duration(days: interval!.value)),
      IntervalType.months =>
        lastCompletionTime!.add(Duration(days: (interval!.value * 30))),
    };
  }

  bool isOverdue() {
    return DateTime.now().isAfter(getNextDueTime());
  }

  bool get isValid {
    // Helper function to validate monthly dates
    bool isValidMonthlyDate(int date) {
      return date >= 1 && date <= 31;
    }

    // Helper function to validate week days (1-7 represents Monday-Sunday)
    bool isValidWeekDay(int day) {
      return day >= 1 && day <= 7;
    }

    try {
      switch (type) {
        case FrequencyType.interval:
          // For interval type, interval must be provided
          if (interval == null) {
            return false;
          }
          // Weekdays and monthlyDates should be null for interval type
          if (weekDays != null || monthlyDates != null) {
            return false;
          }
          // Validate interval values are positive
          if ((interval?.value ?? -1) <= 0) {
            return false;
          }
          return true;

        case FrequencyType.daily:
          // For daily type, interval, weekDays, and monthlyDates should be null
          return interval == null && weekDays == null && monthlyDates == null;

        case FrequencyType.weekdays:
          // For weekDays type, weekDays must be provided and valid
          if (weekDays?.isEmpty ?? true) {
            return false;
          }
          // Interval and monthlyDates should be null for weekDays type
          if (interval != null || monthlyDates != null) {
            return false;
          }
          // All week days should be valid (1-7)
          return weekDays?.every(isValidWeekDay) ?? false;

        case FrequencyType.monthly:
          // For monthly type, monthlyDates must be provided and valid
          if (monthlyDates?.isEmpty ?? true) {
            return false;
          }
          // Interval and weekDays should be null for monthly type
          if (interval != null || weekDays != null) {
            return false;
          }
          // All monthly dates should be valid (1-31)
          return monthlyDates?.every(isValidMonthlyDate) ?? false;
      }
    } catch (e) {
      return false;
    }
  }

  // Copy with
  HabitFrequency copyWith({
    FrequencyType? type,
    TimeInterval? interval,
    Set<int>? monthlyDates,
    Set<int>? weekDays,
    DateTime? lastCompletionTime,
  }) {
    return HabitFrequency(
      type: type ?? this.type,
      interval: interval ?? this.interval,
      monthlyDates: monthlyDates ?? this.monthlyDates,
      weekDays: weekDays ?? this.weekDays,
      lastCompletionTime: lastCompletionTime ?? this.lastCompletionTime,
    );
  }

  // JSON serialization
  Map<String, dynamic> toJson() => _$HabitFrequencyToJson(this);

  factory HabitFrequency.fromJson(Map<String, dynamic> json) =>
      _$HabitFrequencyFromJson(json);

  static TimeInterval? timeIntervalFromJson(dynamic json) {
    if (json == null) return null;

    if (json is Map<String, dynamic>) {
      return TimeInterval.fromJson(json);
    } else if (json is Map<dynamic, dynamic>) {
      return TimeInterval.fromJson(Map<String, dynamic>.from(json));
    } else {
      throw const FormatException('Invalid format for time interval');
    }
  }

  @override
  List<Object?> get props => [
        type,
        interval,
        weekDays,
        monthlyDates,
        lastCompletionTime,
      ];
}

enum FrequencyType {
  @JsonValue('interval')
  interval, // Covers minutes, hours, days with TimeInterval
  @JsonValue('daily')
  daily, // Special case for everyday
  @JsonValue('weekdays')
  weekdays, // Covers both weekly and specific week days
  @JsonValue('monthly')
  monthly, // Covers first day, last day, specific date with monthlyDates
}

enum IntervalType {
  months,
  days,
  hours,
  minutes;

  static const _$IntervalTypeEnumMap = {
    months: 'months',
    days: 'days',
    hours: 'hours',
    minutes: 'minutes',
  };
}

class TimeInterval extends Equatable {
  final int value;
  final IntervalType type;

  const TimeInterval({required this.value, required this.type});

  factory TimeInterval.fromJson(Map<String, dynamic> json) {
    return TimeInterval(
      value: json['value'] ?? 0,
      type: $enumDecode(IntervalType._$IntervalTypeEnumMap, json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'value': value,
    };
  }

  @override
  List<Object?> get props => [
        type,
        value,
      ];
}
