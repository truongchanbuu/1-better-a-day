import 'dart:convert';

import '../../../../config/log/app_logger.dart';
import '../../../../core/enums/habit/goal_type.dart';
import '../../../../core/enums/habit/goal_unit.dart';
import '../../../../core/enums/habit/habit_category.dart';
import '../../../../core/enums/habit/habit_time_of_day.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/habit_frequency.dart';

/// Custom exception for validation errors
class HabitValidationException implements Exception {
  final String field;
  final String message;

  const HabitValidationException(this.field, this.message);

  @override
  String toString() => 'ValidationError: $field - $message';
}

/// Result class for validation operations
class ValidationResult<T> {
  final T? data;
  final List<String> errors;

  bool get isValid => errors.isEmpty;

  const ValidationResult({
    this.data,
    this.errors = const [],
  });

  factory ValidationResult.success(T data) => ValidationResult(data: data);

  factory ValidationResult.failure(List<String> errors) =>
      ValidationResult(errors: errors);
}

/// Configuration class for validation rules and defaults
class HabitValidationConfig {
  static var defaultValues = HabitDefaults();
  static var validationPatterns = ValidationPatterns();

  // Validation rules
  static const requiredFields = {
    'habitTitle': String,
    'habitDesc': String,
    'habitGoal': Map<String, dynamic>,
    'habitCategory': String,
    'timeOfDay': String,
    'reminderTimes': List<String>,
    'habitIcon': Map<String, dynamic>,
  };
}

/// Default values for habit-related fields
class HabitDefaults {
  // Basic habit defaults
  static const Map<String, dynamic> habitDefaults = {
    'habitTitle': 'Untitled Habit',
    'habitDesc': 'No description provided',
    'habitCategory': 'lifestyle',
    'timeOfDay': 'morning',
    'reminderTimes': ['07:00'],
  };

  // Goal-related defaults
  static const Map<String, dynamic> goalDefaults = {
    'goalDesc': 'No goal description provided',
    'goalType': 'completion',
    'targetValue': 1.0,
    'goalUnit': 'times',
    'goalFrequency': frequencyDefaults,
  };

  // Frequency-related defaults
  static const frequencyDefaults = {
    'type': 'daily',
    'interval': intervalDefaults,
  };

  // Interval defaults
  static const intervalDefaults = {
    'type': 'days',
    'value': 1,
  };

  // Icon defaults
  static const Map<String, dynamic> iconDefaults = {
    'key': 'default_icon',
    'icon': '<svg>...</svg>', // Your default SVG
    'color': '#0xFF000000',
  };
}

/// Validation patterns
class ValidationPatterns {
  static final timeFormat = RegExp(r'^\d{2}:\d{2}$');
  static final jsonCodeBlock = RegExp(r'```(?:\w+)?\n([\s\S]*?)\n```');
}

/// Base validator interface
abstract class Validator<T> {
  ValidationResult<Map<String, dynamic>> validate(T data);
}

/// Validator for habit icons
class IconValidator implements Validator<Map<String, dynamic>> {
  @override
  ValidationResult<Map<String, dynamic>> validate(
      Map<String, dynamic> iconData) {
    try {
      final sanitized = {
        'key': _safeString(iconData['key'], HabitDefaults.iconDefaults['key']),
        'icon':
            _safeString(iconData['icon'], HabitDefaults.iconDefaults['icon']),
        'color':
            _safeString(iconData['color'], HabitDefaults.iconDefaults['color']),
      };
      return ValidationResult.success(sanitized);
    } catch (e) {
      return ValidationResult.failure(['Invalid icon data: ${e.toString()}']);
    }
  }

  String _safeString(dynamic value, String defaultValue) {
    return (value?.toString().trim() ?? defaultValue);
  }
}

/// Validator for frequency data
class FrequencyValidator implements Validator<Map<String, dynamic>> {
  @override
  ValidationResult<Map<String, dynamic>> validate(
      Map<String, dynamic> freqData) {
    try {
      final sanitized = {
        'type': _validateFrequencyType(freqData['type']),
        ...(_validateFrequencyDetails(freqData)),
      };
      return ValidationResult.success(sanitized);
    } catch (e) {
      return ValidationResult.failure(
          ['Invalid frequency data: ${e.toString()}']);
    }
  }

  String _validateFrequencyType(dynamic type) {
    final validTypes = FrequencyType.values.map((e) => e.name).toList();
    final safeType = (type?.toString().toLowerCase() ?? 'daily');
    return validTypes.contains(safeType) ? safeType : 'daily';
  }

  Map<String, dynamic> _validateFrequencyDetails(Map<String, dynamic> data) {
    final type = _validateFrequencyType(data['type']);

    switch (type) {
      case 'interval':
      case 'daily':
        return {'interval': _validateInterval(data['interval'])};
      case 'monthly':
        return {'monthlyDates': _validateDates(data['monthlyDates'])};
      case 'weekdays':
        return {'weekDays': _validateDates(data['weekDays'])};
      default:
        return {'interval': HabitDefaults.intervalDefaults};
    }
  }

  Map<String, dynamic> _validateInterval(dynamic intervalData) {
    if (intervalData is! Map<String, dynamic>) {
      return Map<String, dynamic>.from(HabitDefaults.intervalDefaults);
    }

    return {
      'type': _validateIntervalType(intervalData['type']),
      'value': _safeInteger(intervalData['value'],
          HabitDefaults.intervalDefaults['value'] as int),
    };
  }

  String _validateIntervalType(dynamic type) {
    final validTypes = IntervalType.values.map((e) => e.name).toList();
    final safeType = (type?.toString().toLowerCase() ?? 'days');
    return validTypes.contains(safeType) ? safeType : 'days';
  }

  List<int> _validateDates(dynamic dates) {
    if (dates is! List) return [1];
    return dates.map((e) => _safeInteger(e, 1)).toList();
  }

  int _safeInteger(dynamic value, int defaultValue) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is double) return value.round();
    try {
      return int.parse(value.toString());
    } catch (_) {
      return defaultValue;
    }
  }
}

/// Validator for goal data
class GoalValidator implements Validator<Map<String, dynamic>> {
  final FrequencyValidator _frequencyValidator;

  GoalValidator(this._frequencyValidator);

  @override
  ValidationResult<Map<String, dynamic>> validate(
      Map<String, dynamic> goalData) {
    try {
      final frequencyResult =
          _frequencyValidator.validate(goalData['goalFrequency'] ?? {});

      if (!frequencyResult.isValid) {
        return ValidationResult.failure(frequencyResult.errors);
      }

      final sanitized = {
        'goalDesc': _safeString(
            goalData['goalDesc'], HabitDefaults.goalDefaults['goalDesc']),
        'goalType': _validateGoalType(goalData['goalType']),
        'targetValue': _safeNumber(
            goalData['targetValue'], HabitDefaults.goalDefaults['targetValue']),
        'goalUnit': _validateGoalUnit(goalData['goalUnit']),
        'goalFrequency': frequencyResult.data,
      };

      return ValidationResult.success(sanitized);
    } catch (e) {
      return ValidationResult.failure(['Invalid goal data: ${e.toString()}']);
    }
  }

  String _validateGoalType(dynamic type) {
    final validTypes = GoalType.values.map((e) => e.name).toList();
    final safeType = (type?.toString().toLowerCase() ??
        HabitDefaults.goalDefaults['goalType']);
    return validTypes.contains(safeType)
        ? safeType
        : HabitDefaults.goalDefaults['goalType'];
  }

  String _validateGoalUnit(dynamic unit) {
    final validUnits = GoalUnit.values.map((e) => e.name).toList();
    final safeUnit = (unit?.toString().toLowerCase() ??
        HabitDefaults.goalDefaults['goalUnit']);
    return validUnits.contains(safeUnit)
        ? safeUnit
        : HabitDefaults.goalDefaults['goalUnit'];
  }

  String _safeString(dynamic value, String defaultValue) {
    return (value?.toString().trim() ?? defaultValue);
  }

  double _safeNumber(dynamic value, double defaultValue) {
    if (value == null) return defaultValue;
    if (value is num) return value.toDouble();
    try {
      return double.parse(value.toString());
    } catch (_) {
      return defaultValue;
    }
  }
}

/// Main habit validator class
class HabitResponseValidator {
  final GoalValidator _goalValidator;
  final IconValidator _iconValidator;
  final AppLogger _logger;

  HabitResponseValidator({
    GoalValidator? goalValidator,
    IconValidator? iconValidator,
    AppLogger? logger,
  })  : _goalValidator = goalValidator ?? GoalValidator(FrequencyValidator()),
        _iconValidator = iconValidator ?? IconValidator(),
        _logger = logger ?? getIt.get<AppLogger>();

  /// Validates and formats the response
  ValidationResult<Map<String, dynamic>> validateAndFormat(
      String responseText) {
    try {
      final jsonString = _extractJsonFromResponse(responseText.trim());
      final decoded = jsonDecode(jsonString);

      if (decoded is! Map<String, dynamic>) {
        return ValidationResult.failure(
            ['Response is not a valid JSON object']);
      }

      // Validate required fields
      final missingFields = _validateRequiredFields(decoded);
      if (missingFields.isNotEmpty) {
        return ValidationResult.failure(
            missingFields.map((f) => 'Missing required field: $f').toList());
      }

      // Validate nested objects
      final goalResult = _goalValidator.validate(decoded['habitGoal'] ?? {});
      if (!goalResult.isValid) return goalResult;

      final iconResult = _iconValidator.validate(decoded['habitIcon'] ?? {});
      if (!iconResult.isValid) return iconResult;

      // Create sanitized result
      final result = {
        'habitTitle': _safeString(
            decoded['habitTitle'], HabitDefaults.habitDefaults['habitTitle']),
        'habitDesc': _safeString(
            decoded['habitDesc'], HabitDefaults.habitDefaults['habitDesc']),
        'habitCategory': _validateCategory(decoded['habitCategory']),
        'timeOfDay': _validateTimeOfDay(decoded['timeOfDay']),
        'reminderTimes': _validateReminderTimes(decoded['reminderTimes']),
        'habitGoal': goalResult.data,
        'habitIcon': iconResult.data,
      };

      return ValidationResult.success(result);
    } catch (e) {
      _logger.e('Validation error: $e');
      return ValidationResult.failure(['Validation error: ${e.toString()}']);
    }
  }

  /// Creates a default habit
  Map<String, dynamic> createDefaultHabit() {
    return {
      ...HabitDefaults.habitDefaults,
      'habitGoal': HabitDefaults.goalDefaults,
      'habitIcon': HabitDefaults.iconDefaults,
    };
  }

  /// Private helper methods
  String _extractJsonFromResponse(String markdown) {
    final match = ValidationPatterns.jsonCodeBlock.firstMatch(markdown);
    return match?.group(1) ?? markdown;
  }

  List<String> _validateRequiredFields(Map<String, dynamic> data) {
    return HabitValidationConfig.requiredFields.keys
        .where((field) => !data.containsKey(field))
        .toList();
  }

  String _safeString(dynamic value, String defaultValue) {
    return (value?.toString().trim() ?? defaultValue);
  }

  String _validateCategory(dynamic category) {
    final validCategories = HabitCategory.values.map((e) => e.name).toList();
    final safeCategory = (category?.toString().toLowerCase() ?? 'lifestyle');
    return validCategories.contains(safeCategory) ? safeCategory : 'lifestyle';
  }

  String _validateTimeOfDay(dynamic timeOfDay) {
    final validTimes = HabitTimeOfDay.values.map((e) => e.name).toList();
    final safeTime = (timeOfDay?.toString().toLowerCase() ?? 'morning');
    return validTimes.contains(safeTime) ? safeTime : 'morning';
  }

  List<String> _validateReminderTimes(dynamic reminderTimes) {
    if (reminderTimes == null) {
      return HabitDefaults.habitDefaults['reminderTimes'];
    }

    if (reminderTimes is! List) {
      return HabitDefaults.habitDefaults['reminderTimes'];
    }

    final validTimes = reminderTimes
        .map((time) => time?.toString().trim())
        .where((time) =>
            time != null && ValidationPatterns.timeFormat.hasMatch(time))
        .map((time) => time!)
        .toList();

    return validTimes.isEmpty
        ? HabitDefaults.habitDefaults['reminderTimes']
        : validTimes;
  }
}
