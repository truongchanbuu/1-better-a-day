import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../../config/log/app_logger.dart';
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

      if (response.text == null) {
        return null;
      }

      print(
          'data: ${response.text} - RUNTIME TYPE ${response.text.runtimeType}');
    } catch (e) {
      _appLogger.e(e);
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

  String _getDataFromHabitGoal(String goal, {String language = 'en'}) {
    return '''
      From this SMART habit goal "$goal" generate only a plain text but in JSON format for the HabitEntity with the following structure:
        habitTitle: A concise, meaningful title for the habit.
        habitDesc: A short description explaining the purpose and benefits of the habit.
        habitGoal: An object specifying:goalDesc: A detailed description of the goal.
        goalType: The appropriate type from GoalType enum (e.g., count, custom).
        targetValue: The specific measurable target value (e.g., 2 for 2L).
        goalFrequency: The frequency (e.g., daily, weekly).
        goalUnit: The appropriate unit from GoalUnit enum (e.g., l for liters).
        habitCategory: The relevant category for the habit (choose from HabitCategory: health, lifestyle, nutrition, etc.).
        timeOfDay: The suggested time of day (morning, afternoon, evening, night, or anytime) for the habit.
        startDate: Default to the current date in ISO 8601 format.
        endDate: Default to 21 days after the startDate in ISO 8601 format.
        reminderTime: A specific time (if needed) to remind the user to perform the habit in ISO 8601 format.
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
          "timeOfDay": "anytime",
          "startDate": "2024-12-19T00:00:00Z",
          "endDate": "2025-01-09T00:00:00Z",
          "reminderTime": "2024-12-19T08:00:00Z"
        }
        
      ${language == 'vi' ? 'Please provide the analysis in Vietnamese.' : ''}
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
      
      Please only returns a plain text but in JSON format (without any explanation) for the HabitEntity with the following structure:
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
        habitCategory: The relevant category for the habit (choose from HabitCategory: health, lifestyle, nutrition, etc.).
        timeOfDay: The suggested time of day (morning, afternoon, evening, night, or anytime) for the habit that based on the reminder time.
        startDate: Default to the current date in ISO 8601 format.
        endDate: Default to 21 days after the startDate in ISO 8601 format.
        reminderTime: A specific time (if needed) to remind the user to perform the habit in ISO 8601 format.
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
        "timeOfDay": "anytime",
        "startDate": "2024-12-19T00:00:00Z",
        "endDate": "2025-01-09T00:00:00Z",
        "reminderTime": "2024-12-19T08:00:00Z"
        }

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
      S.current.timebound_deadline,
      S.current.timebound_complete,
      S.current.timebound_finish,
      S.current.timebound_finalize,
      S.current.timebound_achieve,
      S.current.timebound_reach,
      S.current.timebound_complete_by,
      S.current.timebound_due,
      S.current.timebound_end,
      S.current.timebound_within,
      S.current.timebound_before,
      S.current.timebound_on,
      S.current.timebound_by,
      S.current.timebound_duration,
      S.current.timebound_until,
      S.current.timebound_start,
      S.current.timebound_start_from,
      S.current.timebound_start_by,
      S.current.timebound_timeframe,
      S.current.timebound_end_by,
      S.current.timebound_goal,
      S.current.timebound_end_date,
      S.current.timebound_in_time,
      S.current.timebound_time_limit,
      S.current.timebound_timely,
      S.current.timebound_immediate,
      S.current.timebound_promptly,
      S.current.timebound_soon,
      S.current.timebound_quickly,
      S.current.timebound_urgent,
      S.current.timebound_scheduled,
      S.current.timebound_set_date,
      S.current.timebound_after,
      S.current.timebound_soon_after,
      S.current.timebound_next,
      S.current.timebound_in_the_next,
      S.current.timebound_within_the_next,
      S.current.timebound_upon_completion,
      S.current.timebound_post,
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
    final actionVerbs = [
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
