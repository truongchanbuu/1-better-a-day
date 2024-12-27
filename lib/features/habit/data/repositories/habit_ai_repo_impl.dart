import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/log/app_logger.dart';
import '../../../../core/enums/habit/goal_type.dart';
import '../../../../core/enums/habit/habit_category.dart';
import '../../../../core/enums/habit/habit_time_of_day.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../domain/repositories/habit_ai_repository.dart';
import '../models/habit_analysis_result.dart';
import '../models/habit_model.dart';
import '../models/overall_analysis_result.dart';

enum AnalysisStatus {
  excellent,
  good,
  needsWork,
  poor,
}

class HabitAIRepoImpl implements HabitAIRepository {
  final GenerativeModel model;
  final _appLogger = getIt.get<AppLogger>();

  HabitAIRepoImpl(this.model);

  @override
  Future<HabitModel?> generateHabitWithSentence(String sentence,
      {String language = 'en'}) async {
    try {
      final prompt = _generateSMARThabitGoal(sentence, language: language);
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      print("RES: ${response.text}");
      if (response.text == null ||
          response.text!.isEmpty ||
          response.text == '{}') {
        _appLogger.e("Response text is empty.");
        return null;
      }

      final result = HabitResponseValidator.validateAndFormat(response.text!) ??
          HabitResponseValidator.createDefaultHabit();

      final habit = HabitModel.init();
      final habitId = const Uuid().v4();

      result['habitId'] = habitId;
      result['habitProgress'] = habit.habitProgress;
      result['currentStreak'] = 0;
      result['longestStreak'] = 0;
      result['habitStatus'] = habit.habitStatus;
      result['startDate'] = habit.startDate.toMoment().toIso8601String();
      result['endDate'] = habit.endDate.toMoment().toIso8601String();

      if (result['habitGoal'] is Map) {
        final goal = Map<String, dynamic>.from(result['habitGoal']);
        goal['goalId'] = const Uuid().v4();
        goal['habitId'] = habitId;
        goal['currentValue'] = 0;
        result['habitGoal'] = goal;
      } else {
        _appLogger.e("habitGoal structure is invalid.");
        return null;
      }

      return HabitModel.fromJson(result);
    } catch (e) {
      _appLogger.e("Error generating habit: $e");
      return null;
    }
  }

  @override
  Future<OverallAnalysisResult> analyzeGoal(String goal,
      {String language = 'en'}) async {
    try {
      final prompt = _analyzePrompt(goal, lang: language);
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      if (response.text == null) {
        _appLogger.i('No text response');
        return quickAnalyzeGoal(goal);
      }

      return OverallAnalysisResult.fromJson(jsonDecode(response.text!));
    } catch (e) {
      _appLogger.e(e);
      rethrow;
    }
  }

  String _analyzePrompt(String goal, {String lang = 'en'}) {
    return '''
      Analyze this habit goal using SMART criteria:
      "$goal" 
      
      Provide the following response in following JSON format only but in String text format only, not json file or any other format:
      {
        "specific": {
          "passed": boolean,
          "score": number (0-100),
        },
        "measurable": {
          // same structure as specific
        },
        "achievable": {
          // same structure as specific
        },
        "relevant": {
          // same structure as specific
        },
        "timeBound": {
          // same structure as specific
        },
        "overallScore": number (0-100),
        "summary": string,
        "improvedSentence": string
      }
      
      For each criterion:
      1. Check if it meets the SMART requirements
      2. Assign a score from 0-100
      3. Give a statement for improvement that meets all SMART requirements

      ${lang == 'vi' ? 'Please provide the analysis in Vietnamese.' : ''}
      ''';
  }

  String _generateSMARThabitGoal(String sentence, {String language = 'en'}) {
    return '''
      From this sentence about what I want to do: "$sentence" generate a SMART habit goal.
        Know that:
        S - Specific: What will you achieve? What will you do?
        M - Measurable: What data will you use to decide whether you've met the goal?
        A - Achievable: Are you sure you can do this? Do you have the right skills and resources?
        R - Relevant: Does the goal align with those of your team or organization? How will the result matter?
        T - Time-bound: What is the deadline for accomplishing the goal?
      
      Please only returns a only PLAIN TEXT in JSON format (no markdown and without any explanation) for the HabitEntity with the following structure:
      {
        "habitTitle": A concise, meaningful title for the habit.
        "habitDesc": A short description explaining the purpose and benefits of the habit.
        "habitGoal": An object specifying the goal:
         {
          "goalDesc": Description provides details about the specific goal related to that habit, which includes the target, type, and why it's necessary to achieve it,
          "goalType": The appropriate type of goal (e.g., completion, count, distance, duration),
          "targetValue": A specific measurable number that displays target of the goal,
          "goalFrequency": The frequency in day unit (e.g., 1, 2, 3, ...),
          "goalUnit": The appropriate unit (e.g., l for liters, minute, pages, ...).
         },
        "habitCategory": The relevant category for the habit (choose from HabitCategory: health, lifestyle, nutrition, etc.).
        "timeOfDay": The suggested time of day (morning, afternoon, evening, night, or anytime) for the habit that based on the reminder time.
        "reminderTime": A specific time (if needed) to remind the user to perform the habit only in valid String format 'hh:mm'. If user does not specify, you can provide a suitable time as a suggestion (if can) - default can be 6:00 for morning, 12:00 for afternoon, 18:00 for evening and 21:00 for night.
      }
      
      Example Response:
       For the habit "Drinking enough 2L water a day for staying fit and healthy." example generate the following output:
        {
        "habitTitle": "Drink 2L Water Daily",
        "habitDesc": "Stay hydrated and improve your overall health by drinking 2 liters of water every day.",
        "habitGoal": {
          "goalDesc": "Drink 2 liters of water daily to stay fit and healthy.",
          "goalType": "count",
          "targetValue": 2.0,
          "goalFrequency": 1,
          "goalUnit": "l"
        },
        "habitCategory": "health",
        "timeOfDay": "evening",
        "reminderTime": "18:00"
        }
    OR:
      If the sentence is too vague or cannot determine/generate an habit, then please ONLY returns an EMPTY STRING
    
    
    ${language == 'vi' ? 'Please provide the analysis in Vietnamese.' : ''}
    ''';
  }

  @override
  OverallAnalysisResult quickAnalyzeGoal(String goal,
      {String language = 'en'}) {
    final goalLower = goal.toLowerCase();

    final specifyResult = _analyzeSpecific(goalLower);
    final measurableResult = _analyzeMeasurable(goalLower);
    final achievableResult = _analyzeAchievable(goalLower);
    final relevantResult = _analyzeRelevant(goalLower);
    final timeBoundResult = _analyzeTimeBound(goalLower);

    final double score = (specifyResult.score +
            measurableResult.score +
            achievableResult.score +
            relevantResult.score +
            timeBoundResult.score) /
        5.0;

    final summary = _generateSummary(score.roundToDouble());

    return OverallAnalysisResult(
      specific: specifyResult.toAnalysisResult(),
      measurable: measurableResult.toAnalysisResult(),
      achievable: achievableResult.toAnalysisResult(),
      relevant: relevantResult.toAnalysisResult(),
      timeBound: timeBoundResult.toAnalysisResult(),
      overallScore: score,
      summary: summary,
      improvedSentence: '',
    );
  }

  _AnalysisResult _analyzeTimeBound(String goal) {
    List<String> timeBoundWords = [
      S.current.time_bound_deadline,
      S.current.time_bound_complete,
      S.current.time_bound_finish,
      S.current.time_bound_finalize,
      S.current.time_bound_achieve,
      S.current.time_bound_reach,
      S.current.time_bound_complete_by,
      S.current.time_bound_due,
      S.current.time_bound_end,
      S.current.time_bound_within,
      S.current.time_bound_before,
      S.current.time_bound_on,
      S.current.time_bound_by,
      S.current.time_bound_duration,
      S.current.time_bound_until,
      S.current.time_bound_start,
      S.current.time_bound_start_from,
      S.current.time_bound_start_by,
      S.current.time_bound_timeframe,
      S.current.time_bound_end_by,
      S.current.time_bound_goal,
      S.current.time_bound_end_date,
      S.current.time_bound_in_time,
      S.current.time_bound_time_limit,
      S.current.time_bound_timely,
      S.current.time_bound_immediate,
      S.current.time_bound_promptly,
      S.current.time_bound_soon,
      S.current.time_bound_quickly,
      S.current.time_bound_urgent,
      S.current.time_bound_scheduled,
      S.current.time_bound_set_date,
      S.current.time_bound_after,
      S.current.time_bound_soon_after,
      S.current.time_bound_next,
      S.current.time_bound_in_the_next,
      S.current.time_bound_within_the_next,
      S.current.time_bound_upon_completion,
      S.current.time_bound_post,
    ];

    final containsTimeBoundWord =
        timeBoundWords.any((word) => goal.toLowerCase().contains(word));

    final hasNumbers = RegExp(r'\d').hasMatch(goal);

    final suggestions = [
      if (containsTimeBoundWord) S.current.time_bound_suggestion_1,
      if (!hasNumbers) S.current.time_bound_suggestion_2,
    ];

    return _generateResult(
      isPassed: containsTimeBoundWord && hasNumbers,
      conditions: [containsTimeBoundWord, hasNumbers],
      suggestions: suggestions,
    );
  }

  _AnalysisResult _analyzeAchievable(String goal) {
    List<String> measurableNegativeWords = [
      S.current.measurable_negative_lose,
      S.current.measurable_negative_decline,
      S.current.measurable_negative_diminish,
      S.current.measurable_negative_decrease,
      S.current.measurable_negative_weaken,
      S.current.measurable_negative_fail,
      S.current.measurable_negative_revert,
      "100%"
    ];

    final containsNegativeWord = measurableNegativeWords
        .any((word) => goal.toLowerCase().contains(word));
    final hasNumbers = RegExp(r'\d').hasMatch(goal);

    final suggestions = [
      if (containsNegativeWord) S.current.achievable_suggestion_1,
      if (!hasNumbers) S.current.achievable_suggestion_2,
    ];

    return _generateResult(
      isPassed: !containsNegativeWord && hasNumbers,
      conditions: [hasNumbers, !containsNegativeWord],
      suggestions: suggestions,
    );
  }

  _AnalysisResult _analyzeRelevant(String goal) {
    List<String> relevantCriteriaWords = [
      S.current.relevant_increase,
      S.current.relevant_improve,
      S.current.relevant_optimize,
      S.current.relevant_boost,
      S.current.relevant_enhance,
      S.current.relevant_expand,
      S.current.relevant_strengthen,
      S.current.relevant_develop,
      S.current.relevant_raise,
      S.current.relevant_accomplish
    ];

    final containRelevantWords =
        relevantCriteriaWords.any((word) => goal.toLowerCase().contains(word));

    final suggestions = [
      if (containRelevantWords) S.current.achievable_suggestion_1,
    ];

    return _generateResult(
      isPassed: containRelevantWords,
      conditions: [containRelevantWords],
      suggestions: suggestions,
    );
  }

  _AnalysisResult _analyzeMeasurable(String goal) {
    final measurableWords = [
      S.current.measurable_meter,
      S.current.measurable_kilometer,
      S.current.measurable_mile,
      S.current.measurable_gram,
      S.current.measurable_kilogram,
      S.current.measurable_liter,
      S.current.measurable_milliliter,
      S.current.measurable_hour,
      S.current.measurable_minute,
      S.current.measurable_second,
      S.current.measurable_page,
      S.current.measurable_step,
      S.current.measurable_rep,
      S.current.measurable_set,
    ];

    final hasMeasurableWords = measurableWords.any(goal.contains);
    final hasNumbers = RegExp(r'\d').hasMatch(goal);
    final isPassed = hasMeasurableWords && hasNumbers;

    final suggestions = [
      if (!hasMeasurableWords) S.current.measurable_suggestion_1,
      if (!hasNumbers) S.current.measurable_suggestion_2,
    ];

    return _generateResult(
      isPassed: isPassed,
      conditions: [hasNumbers, hasMeasurableWords],
      suggestions: suggestions,
    );
  }

  _AnalysisResult _analyzeSpecific(String goal) {
    final hasActionVerb = actionVerbs.any(goal.contains);
    final hasQuantifier = RegExp(r'\d+').hasMatch(goal);
    final hasDetail = goal.split(' ').length >= 4;

    final isPassed = hasActionVerb && (hasQuantifier || hasDetail);

    final suggestions = [
      if (!hasActionVerb) S.current.specific_suggestion_2,
      if (!hasQuantifier) S.current.specific_suggestion_1,
      if (!hasDetail) S.current.specific_suggestion_3,
    ];

    return _generateResult(
      isPassed: isPassed,
      conditions: [hasActionVerb, hasQuantifier, hasDetail],
      suggestions: suggestions,
    );
  }

  _AnalysisResult _generateResult({
    required bool isPassed,
    required List<bool> conditions,
    required List<String> suggestions,
  }) {
    final status = _determineStatus(conditions);
    final score = _determineScore(conditions);
    final feedback = switch (status) {
      AnalysisStatus.excellent => S.current.specific_excellent,
      AnalysisStatus.good => S.current.specific_good,
      AnalysisStatus.needsWork => S.current.specific_needs_work,
      AnalysisStatus.poor => S.current.specific_poor,
    };

    return _AnalysisResult(
      isPassed: isPassed,
      feedback: feedback,
      suggestions: suggestions,
      status: status,
      score: score,
    );
  }

  double _determineScore(List<bool> conditions) =>
      (conditions.where((c) => c).length / conditions.length) * 100;

  AnalysisStatus _determineStatus(List<bool> conditions) {
    final percentage = _determineScore(conditions);

    if (percentage >= 90) return AnalysisStatus.excellent;
    if (percentage >= 70) return AnalysisStatus.good;
    if (percentage >= 40) return AnalysisStatus.needsWork;
    return AnalysisStatus.poor;
  }

  String _generateSummary(double score) {
    String template = '';
    if (score >= 90) {
      template = S.current.summary_excellent;
    } else if (score >= 70) {
      template = S.current.summary_good(score);
    } else if (score >= 40) {
      template = S.current.summary_needs_work(score);
    } else {
      template = S.current.summary_poor(score);
    }

    return template;
  }

  static List<String> get actionVerbs => [
        // Exercise
        S.current.action_exercise_run,
        S.current.action_exercise_walk,
        S.current.action_exercise_swim,
        S.current.action_exercise_workout,
        S.current.action_exercise_jog,
        S.current.action_exercise_yoga,
        S.current.action_exercise_stretch,
        S.current.action_exercise_gym,

        // Learning
        S.current.action_learning_read,
        S.current.action_learning_study,
        S.current.action_learning_practice,
        S.current.action_learning_write,
        S.current.action_learning_revise,
        S.current.action_learning_research,
        S.current.action_learning_learn,
        S.current.action_learning_master,

        // Health
        S.current.action_health_meditate,
        S.current.action_health_drink,
        S.current.action_health_eat,
        S.current.action_health_sleep,
        S.current.action_health_breathe,
        S.current.action_health_relax,
        S.current.action_health_rest,

        // Productivity
        S.current.action_productivity_complete,
        S.current.action_productivity_finish,
        S.current.action_productivity_achieve,
        S.current.action_productivity_accomplish,
        S.current.action_productivity_do,
        S.current.action_productivity_work,
        S.current.action_productivity_start,
        S.current.action_productivity_continue,

        // Creative
        S.current.action_creative_build,
        S.current.action_creative_create,
        S.current.action_creative_develop,
        S.current.action_creative_design,
        S.current.action_creative_write,
        S.current.action_creative_draw,
        S.current.action_creative_paint,
        S.current.action_creative_compose,

        // Social
        S.current.action_social_connect,
        S.current.action_social_meet,
        S.current.action_social_call,
        S.current.action_social_text,
        S.current.action_social_email,
        S.current.action_social_visit,
        S.current.action_social_spend,
        S.current.action_social_help,

        // Improvement
        S.current.action_improvement_reduce,
        S.current.action_improvement_increase,
        S.current.action_improvement_decrease,
        S.current.action_improvement_improve,
        S.current.action_improvement_enhance,
        S.current.action_improvement_optimize,
        S.current.action_improvement_upgrade,

        // Tracking
        S.current.action_tracking_track,
        S.current.action_tracking_measure,
        S.current.action_tracking_monitor,
        S.current.action_tracking_record,
        S.current.action_tracking_log,
        S.current.action_tracking_count,
        S.current.action_tracking_analyze,

        // Time
        S.current.action_time_spend,
        S.current.action_time_allocate,
        S.current.action_time_limit,
        S.current.action_time_schedule,
        S.current.action_time_plan,
        S.current.action_time_organize,
        S.current.action_time_manage,
      ];
}

class _AnalysisResult {
  final bool isPassed;
  final String feedback;
  final List<String> suggestions;
  final AnalysisStatus status;
  final double score;

  const _AnalysisResult({
    required this.isPassed,
    required this.feedback,
    required this.suggestions,
    required this.status,
    this.score = 0,
  });

  HabitAnalysisResult toAnalysisResult() {
    return HabitAnalysisResult(
      passed: isPassed,
      score: score,
    );
  }
}

class HabitResponseValidator {
  static final _appLogger = getIt.get<AppLogger>();

  // Default values for null fields
  static Map<String, dynamic> get _defaults => {
        'habitTitle': 'Untitled Habit',
        'habitDesc': 'No description provided',
        'habitCategory': 'lifestyle',
        'timeOfDay': 'morning',
        'reminderTime': '09:00',
      };

  // Default values for null goal fields
  static const Map<String, dynamic> _goalDefaults = {
    'goalDesc': 'No goal description provided',
    'goalType': 'completion',
    'targetValue': 1.0,
    'goalFrequency': 1,
    'goalUnit': 'times',
  };

  static const Map<String, dynamic> _requiredFields = {
    'habitTitle': String,
    'habitDesc': String,
    'habitGoal': Map<String, dynamic>,
    'habitCategory': String,
    'timeOfDay': String,
    'reminderTime': String,
  };

  static const _requiredGoalFields = {
    'goalDesc': String,
    'goalType': String,
    'targetValue': double,
    'goalFrequency': int,
    'goalUnit': String,
  };

  static final _validTimeOfDay =
      HabitTimeOfDay.values.map((e) => e.name).toList();
  static final _validGoalTypes = GoalType.values.map((e) => e.name).toList();
  static final _validCategories =
      HabitCategory.values.map((e) => e.name).toList();

  /// Extract JSON from possible markdown format
  static String _extractJsonFromResponse(String markdown) {
    final RegExp codeBlockRegex = RegExp(r'```(?:\w+)?\n([\s\S]*?)\n```');

    final Match? match = codeBlockRegex.firstMatch(markdown);

    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? '';
    }

    return markdown;
  }

  /// Safely get a string value with default
  static String _safeString(dynamic value, String defaultValue) {
    if (value == null || value.toString().trim().isEmpty) {
      return defaultValue;
    }
    return value.toString().trim();
  }

  /// Safely get a number value with default
  static double _safeNumber(dynamic value, double defaultValue) {
    if (value == null) return defaultValue;
    if (value is num) return value.toDouble();
    try {
      return double.parse(value.toString());
    } catch (_) {
      return defaultValue;
    }
  }

  /// Safely get an integer value with default
  static int _safeInteger(dynamic value, int defaultValue) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is double) return value.round();
    try {
      return int.parse(value.toString());
    } catch (_) {
      return defaultValue;
    }
  }

  /// Validate and sanitize habitGoal
  static Map<String, dynamic> _validateGoal(dynamic goalData) {
    final Map<String, dynamic> sanitizedGoal = {};

    if (goalData is! Map<String, dynamic>) {
      return Map<String, dynamic>.from(_goalDefaults);
    }

    // Sanitize each field
    sanitizedGoal['goalDesc'] =
        _safeString(goalData['goalDesc'], _goalDefaults['goalDesc']!);

    sanitizedGoal['goalType'] =
        _safeString(goalData['goalType'], _goalDefaults['goalType']!)
            .toLowerCase();

    if (!_validGoalTypes.contains(sanitizedGoal['goalType'])) {
      sanitizedGoal['goalType'] = _goalDefaults['goalType']!;
    }

    sanitizedGoal['targetValue'] = _safeNumber(
        goalData['targetValue'], _goalDefaults['targetValue']! as double);

    sanitizedGoal['goalFrequency'] = _safeInteger(
        goalData['goalFrequency'], _goalDefaults['goalFrequency']! as int);

    sanitizedGoal['goalUnit'] =
        _safeString(goalData['goalUnit'], _goalDefaults['goalUnit']!);

    return sanitizedGoal;
  }

  /// Validates and formats the Gemini response
  static Map<String, dynamic>? validateAndFormat(String responseText) {
    try {
      // Extract and parse JSON
      final jsonString = _extractJsonFromResponse(responseText.trim());
      final dynamic decoded = jsonDecode(jsonString);

      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Response is not a valid JSON object');
      }

      for (final field in _requiredFields.entries) {
        if (!decoded.containsKey(field.key)) {
          throw FormatException('Missing required field: ${field.key}');
        }

        if (field.value == String && decoded[field.key] is! String) {
          decoded[field.key] = "";
        }
      }

      final habitGoal = decoded['habitGoal'];
      if (habitGoal is! Map<String, dynamic>) {
        throw const FormatException('habitGoal must be an object');
      }

      // Validate required goal fields
      for (final field in _requiredGoalFields.entries) {
        if (!habitGoal.containsKey(field.key)) {
          throw FormatException('Missing required goal field: ${field.key}');
        }

        if (field.value == String && habitGoal[field.key] is! String) {
          throw FormatException(
              'Invalid type for goal.${field.key}: expected String');
        }
        if (field.value == num && habitGoal[field.key] is! num) {
          throw FormatException(
              'Invalid type for goal.${field.key}: expected number');
        }
      }

      // Create sanitized result map
      final Map<String, dynamic> result = {};

      // Sanitize basic fields
      result['habitTitle'] =
          _safeString(decoded['habitTitle'], _defaults['habitTitle']!);

      result['habitDesc'] =
          _safeString(decoded['habitDesc'], _defaults['habitDesc']!);

      result['habitCategory'] =
          _safeString(decoded['habitCategory'], _defaults['habitCategory']!)
              .toLowerCase();

      if (!_validCategories.contains(result['habitCategory'])) {
        result['habitCategory'] = _defaults['habitCategory']!;
      }

      result['timeOfDay'] =
          _safeString(decoded['timeOfDay'], _defaults['timeOfDay']!)
              .toLowerCase();

      if (!_validTimeOfDay.contains(result['timeOfDay'])) {
        result['timeOfDay'] = _defaults['timeOfDay']!;
      }

      // Handle reminderTime with special format validation
      String reminderTime =
          _safeString(decoded['reminderTime'], _defaults['reminderTime']!);

      if (!RegExp(r'^\d{2}:\d{2}$').hasMatch(reminderTime)) {
        reminderTime = _defaults['reminderTime']!;
      }
      result['reminderTime'] = reminderTime;

      // Handle habitGoal
      result['habitGoal'] = _validateGoal(decoded['habitGoal']);

      return result;
    } catch (e) {
      _appLogger.e('Validation error: $e');
      rethrow;
    }
  }

  /// Creates a completely default habit when validation fails
  static Map<String, dynamic> createDefaultHabit() {
    return {
      ..._defaults,
      'habitGoal': _goalDefaults,
    };
  }
}
