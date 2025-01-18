import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/log/app_logger.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../domain/repositories/habit_ai_repository.dart';
import '../helpers/habit_ai_repo_helper.dart';
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
      final prompt = generateSMARTHabitPrompt(sentence, language: language);
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      _appLogger.d("AI Response: ${response.text}");

      if (response.text == null ||
          response.text!.isEmpty ||
          response.text == '{}') {
        _appLogger.e("Response text is empty.");
        return null;
      }

      // Initialize validator and validate response
      final validator = HabitResponseValidator();
      final validationResult = validator.validateAndFormat(response.text!);

      if (!validationResult.isValid || validationResult.data == null) {
        _appLogger
            .e("Validation failed: ${validationResult.errors.join(', ')}");
        return null;
      }

      // Get validated data
      final validatedData = Map<String, dynamic>.from(validationResult.data!);
      final habit = HabitModel.init();
      final habitId = const Uuid().v4();

      // Merge validated data with additional fields
      final enrichedData = {
        ...validatedData,
        'habitId': habitId,
        'habitProgress': habit.habitProgress,
        'currentStreak': 0,
        'longestStreak': 0,
        'habitStatus': habit.habitStatus.name,
        'startDate': habit.startDate.toMoment().toIso8601String(),
        'endDate': habit.endDate.toMoment().toIso8601String(),
      };

      // Process habit goal
      final habitGoal = validatedData['habitGoal'];
      if (habitGoal is Map<String, dynamic>) {
        enrichedData['habitGoal'] = {
          ...habitGoal,
          'goalId': const Uuid().v4(),
          'habitId': habitId,
          'currentValue': 0,
        };
      } else {
        _appLogger.e("Invalid habit goal structure");
        return null;
      }

      _appLogger.d("Creating habit model with data: $enrichedData");
      return HabitModel.fromJson(enrichedData);
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

  String generateSMARTHabitPrompt(String sentence, {String language = 'en'}) {
    return '''
You are a specialized AI assistant for habit formation using SMART criteria. Analyze this habit intention: "$sentence" and create a detailed habit structure.

Instructions:
1. Analyze the input for SMART elements:
   - Specific: What exactly needs to be done?
   - Measurable: What are the quantifiable metrics?
   - Achievable: Is it realistic given normal constraints?
   - Relevant: Does it align with personal development?
   - Time-bound: What's the frequency and timing?

2. Goal Types and Units Guide:
   - Duration goals: Use minutes (e.g., meditation, exercise)
   - Count goals: Use appropriate units (pages, glasses, steps)
   - Completion goals: Simple yes/no tasks
   - Distance goals: Use km or m

3. Icon Selection Rules:
   - Health: {
       "key": "health_heart",
       "icon": "<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="48" height="48" preserveAspectRatio="xMidYMid meet" viewBox="0 0 48 48"><path fill="currentColor" d="M6 18.724C6 12.641 10.036 7 15.563 7c3.835 0 6.68 2.53 8.437 6.121C25.756 9.531 28.602 7 32.438 7 37.965 7 42 12.642 42 18.724 42 31.744 24 41 24 41S6 32.304 6 18.724Z"/></svg>",
       "color": "#FF4081"
   }
   - Education: {
       "key": "education_book",
       "icon": "<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="currentColor" d="M13 12h7v1.5h-7m0-4h7V11h-7m0 3.5h7V16h-7m8-12H3a2 2 0 00-2 2v13a2 2 0 002 2h18a2 2 0 002-2V6a2 2 0 00-2-2m0 15h-9V6h9"/></svg>",
       "color": "#4CAF50"
   }
   - Productivity: {
       "key": "productivity_lightning",
       "icon": "<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="currentColor" d="M11 2v2.07A8.002 8.002 0 004.07 11H2v2h2.07A8.002 8.002 0 0011 19.93V22h2v-2.07A8.002 8.002 0 0019.93 13H22v-2h-2.07A8.002 8.002 0 0013 4.07V2m-2 4.08V8h2V6.09c2.5.41 4.5 2.41 4.92 4.91H16v2h1.91c-.41 2.5-2.41 4.5-4.91 4.92V16h-2v1.91C8.5 17.5 6.5 15.5 6.08 13H8v-2H6.09C6.5 8.5 8.5 6.5 11 6.08M12 11a1 1 0 00-1 1 1 1 0 001 1 1 1 0 001-1 1 1 0 00-1-1Z"/></svg>",
       "color": "#FFC107"
   }
   - Mindfulness: {
       "key": "mindfulness_meditation",
       "icon": "<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="currentColor" d="M12 4c1.11 0 2 .89 2 2s-.89 2-2 2-2-.89-2-2 .9-2 2-2m9 12v-2c-2.24 0-4.16-.96-5.6-2.68l-1.34-1.6A1.98 1.98 0 0012.53 9H11.5c-.61 0-1.17.26-1.55.72l-1.34 1.6C7.16 13.04 5.24 14 3 14v2c2.77 0 5.19-1.17 7-3.25V15l-3.88 1.55c-.67.27-1.12.95-1.12 1.66C5 19.2 5.8 20 6.79 20H9v-.5a2.5 2.5 0 012.5-2.5h3c.28 0 .5.22.5.5s-.22.5-.5.5h-3c-.83 0-1.5.67-1.5 1.5v.5h7.21c.99 0 1.79-.8 1.79-1.79 0-.71-.45-1.39-1.12-1.66L14 15v-2.25c1.81 2.08 4.23 3.25 7 3.25Z"/></svg>",
       "color": "#9C27B0"
   }
   - Lifestyle: {
       "key": "lifestyle_home",
       "icon": "<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="currentColor" d="M4.5 11A1.5 1.5 0 006 9.5 1.5 1.5 0 004.5 8 1.5 1.5 0 003 9.5 1.5 1.5 0 004.5 11m17.67-1.83c0-3.87-3.13-7-7-7a7 7 0 00-7 7c0 3.47 2.52 6.33 5.83 6.89V20H6v-3h1v-4a1 1 0 00-1-1H3a1 1 0 00-1 1v4h1v5h16v-2h-3v-3.88a7 7 0 006.17-6.95Z"/></svg>",
       "color": "#3F51B5"
   }
   - Nutrition: {
       "key": "nutrition_apple",
       "icon": "<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="48" height="48" preserveAspectRatio="xMidYMid meet" viewBox="0 0 48 48"><g fill="currentColor"><path fill-rule="evenodd" d="M7.065 17.388c-1.122-1.027-1.888-2.693-2.038-5.384a.954.954 0 01.977-.996c1.675.03 2.958.144 3.938.433.42-1.089 1.257-2.116 2.512-3.055a.913.913 0 011.092 0c1.266.946 2.106 1.983 2.523 3.082 1.009-.34 2.302-.438 3.93-.462a.954.954 0 01.974.998c-.15 2.691-.916 4.357-2.038 5.383.548.409.866 1.093.75 1.834A119.747 119.747 0 0118.176 27H12v2h5.705a122.579 122.579 0 01-2.958 10.209 1.828 1.828 0 01-3.494 0A116.1 116.1 0 019.917 35H12v-2H9.341c-.946-3.391-1.65-6.47-2.161-9H11v-2H6.793c-.2-1.085-.357-2.02-.477-2.78a1.902 1.902 0 01.749-1.832Zm7.134-5.211.682 1.8 1.825-.614c.503-.169 1.184-.27 2.154-.32-.297 1.932-1.012 2.748-1.665 3.17-.931.602-2.288.785-4.165.787h-.06c-1.877-.002-3.234-.185-4.165-.788-.652-.421-1.366-1.236-1.664-3.164 1.001.055 1.713.157 2.235.311l1.768.522.664-1.72c.19-.495.559-1.05 1.192-1.634.64.59 1.01 1.151 1.199 1.65Zm19.508 1.53c-1.973 1.973-2.165 4.727-1.056 7.32C37.505 17.85 43 21.78 43 28c0 5.523-4.925 10-11 10s-11-4.477-11-10c0-5.792 4.765-9.6 9.34-7.53-.781-2.8-.377-5.848 1.953-8.177l1.414 1.414Zm6.263 16.535a1 1 0 10-1.94-.485 4.426 4.426 0 01-3.273 3.273 1 1 0 00.486 1.94 6.426 6.426 0 004.727-4.727Z" clip-rule="evenodd"/><path d="M34 18c3 0 5-2 5-5-3 0-5 2-5 5Z"/></g></svg>",
       "color": "#8BC34A"
   }
   - Social: {
       "key": "social_group",
       "icon": "<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="currentColor" d="M12 5.5A3.5 3.5 0 0115.5 9a3.5 3.5 0 01-3.5 3.5A3.5 3.5 0 018.5 9 3.5 3.5 0 0112 5.5M5 8c.56 0 1.08.15 1.53.42-.15 1.43.27 2.85 1.13 3.96C7.16 13.34 6.16 14 5 14a3 3 0 01-3-3 3 3 0 013-3m14 0a3 3 0 013 3 3 3 0 01-3 3c-1.16 0-2.16-.66-2.66-1.62a5.536 5.536 0 001.13-3.96c.45-.27.97-.42 1.53-.42M5.5 18.25c0-2.07 2.91-3.75 6.5-3.75s6.5 1.68 6.5 3.75V20h-13v-1.75M0 20v-1.5c0-1.39 1.89-2.56 4.45-2.9-.59.68-.95 1.62-.95 2.65V20H0m24 0h-3.5v-1.75c0-1.03-.36-1.97-.95-2.65 2.56.34 4.45 1.51 4.45 2.9V20Z"/></svg>",
       "color": "#00BCD4"
   }
   - Finance: {
       "key": "finance_money",
       "icon": "<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="currentColor" d="M3 6h18v12H3V6m9 3a3 3 0 013 3 3 3 0 01-3 3 3 3 0 01-3-3 3 3 0 013-3M7 8a2 2 0 01-2 2v4a2 2 0 012 2h10a2 2 0 012-2v-4a2 2 0 01-2-2H7Z"/></svg>",
       "color": "#009688"
   }
   - Creativity: {
       "key": "creativity_palette",
       "icon": "<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="currentColor" d="M21.33 12.91c.09 1.55-.62 3.04-1.89 3.95l.77 1.49c.23.45.26.98.06 1.45-.19.47-.58.84-1.06 1l-.79.25a1.687 1.687 0 01-1.86-.55L14.44 18c-.89-.15-1.73-.53-2.44-1.1-.5.15-1 .23-1.5.23-.88 0-1.76-.27-2.5-.79-.53.16-1.07.23-1.62.22-.79.01-1.57-.15-2.3-.45a4.105 4.105 0 01-2.43-3.61c-.08-.72.04-1.45.35-2.11-.29-.75-.32-1.57-.07-2.33C2.3 7.11 3 6.32 3.87 5.82c.58-1.69 2.21-2.82 4-2.7 1.6-1.5 4.05-1.66 5.83-.37.42-.11.86-.17 1.3-.17 1.36-.03 2.65.57 3.5 1.64 2.04.53 3.5 2.35 3.58 4.47.05 1.11-.25 2.2-.86 3.13.07.36.11.72.11 1.09m-5-1.41c.57.07 1.02.5 1.02 1.07a1 1 0 01-1 1h-.63c-.32.9-.88 1.69-1.62 2.29.25.09.51.14.77.21 5.13-.07 4.53-3.2 4.53-3.25a2.592 2.592 0 00-2.69-2.49 1 1 0 01-1-1 1 1 0 011-1c1.23.03 2.41.49 3.33 1.3.05-.29.08-.59.08-.89-.06-1.24-.62-2.32-2.87-2.53-1.25-2.96-4.4-1.32-4.4-.4-.03.23.21.72.25.75a1 1 0 011 1c0 .55-.45 1-1 1-.53-.02-1.03-.22-1.43-.56-.48.31-1.03.5-1.6.56-.57.05-1.04-.35-1.07-.9a.968.968 0 01.88-1.1c.16-.02.94-.14.94-.77 0-.66.25-1.29.68-1.79-.92-.25-1.91.08-2.91 1.29C6.75 5 6 5.25 5.45 7.2 4.5 7.67 4 8 3.78 9c1.08-.22 2.19-.13 3.22.25.5.19.78.75.59 1.29-.19.52-.77.78-1.29.59-.73-.32-1.55-.34-2.3-.06-.32.27-.32.83-.32 1.27 0 .74.37 1.43 1 1.83.53.27 1.12.41 1.71.4-.15-.26-.28-.53-.39-.81a1.038 1.038 0 011.96-.68c.4 1.14 1.42 1.92 2.62 2.05 1.37-.07 2.59-.88 3.19-2.13.23-1.38 1.34-1.5 2.56-1.5m2 7.47-.62-1.3-.71.16 1 1.25.33-.11m-4.65-8.61a1 1 0 00-.91-1.03c-.71-.04-1.4.2-1.93.67-.57.58-.87 1.38-.84 2.19a1 1 0 001 1c.57 0 1-.45 1-1 0-.27.07-.54.23-.76.12-.1.27-.15.43-.15.55.03 1.02-.38 1.02-.92Z"/></svg>",
       "color": "#E91E63"
   }
   - Environmental: {
       "key": "environmental_tree",
       "icon": "<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="currentColor" d="M2 22v-2s5-2 10-2 10 2 10 2v2H2m9.3-12.9c-1.2-3.9-7.3-3-7.3-3s.2 7.8 5.9 6.6C9.5 9.8 8 9 8 9c2.8 0 3 3.4 3 3.4V17h2v-4.2s0-3.9 3-4.9c0 0-2 3-2 5 7 .7 7-8.9 7-8.9s-8.9-1-9.7 5.1Z"/></svg>",
       "color": "#4CAF50"
   }
   - Custom: {
       "key": "custom_star",
       "icon": "<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" preserveAspectRatio="xMidYMid meet" viewBox="0 0 24 24"><path fill="currentColor" d="M12 15.5A3.5 3.5 0 018.5 12 3.5 3.5 0 0112 8.5a3.5 3.5 0 013.5 3.5 3.5 3.5 0 01-3.5 3.5m7.43-2.53c.04-.32.07-.64.07-.97 0-.33-.03-.66-.07-1l2.11-1.63c.19-.15.24-.42.12-.64l-2-3.46c-.12-.22-.39-.31-.61-.22l-2.49 1c-.52-.39-1.06-.73-1.69-.98l-.37-2.65A.506.506 0 0014 2h-4c-.25 0-.46.18-.5.42l-.37 2.65c-.63.25-1.17.59-1.69.98l-2.49-1c-.22-.09-.49 0-.61.22l-2 3.46c-.13.22-.07.49.12.64L4.57 11c-.04.34-.07.67-.07 1 0 .33.03.65.07.97l-2.11 1.66c-.19.15-.25.42-.12.64l2 3.46c.12.22.39.3.61.22l2.49-1.01c.52.4 1.06.74 1.69.99l.37 2.65c.04.24.25.42.5.42h4c.25 0 .46-.18.5-.42l.37-2.65c.63-.26 1.17-.59 1.69-.99l2.49 1.01c.22.08.49 0 .61-.22l2-3.46c.12-.22.07-.49-.12-.64l-2.11-1.66Z"/></svg>",
       "color": "#757575"
   }

4. Frequency Generation Rules:
   - For daily habits: Use "daily" type and interval is not null with {"type": "days", value: 1}
   - For weekly habits: Use "weekDays" with specific days (1=Monday to 7=Sunday)
   - For monthly habits: Use "monthly" with specific dates (1-31)
   - For interval-based: Use "interval" with appropriate TimeInterval

5. Time of Day Guidelines:
   morning: 5:00-11:59
   afternoon: 12:00-16:59
   evening: 17:00-20:59
   night: 21:00-4:59
   anytime: Based on flexibility
   
6. Every fields that have pre-defined enum must only be within those.

Return a JSON string with this exact structure (no markdown, no explanation):
{
  "habitTitle": string, // A concise, meaningful title for the habit.
  "habitDesc": string, // A short description explaining the purpose and benefits of the habit.
  "habitGoal": {
    "goalDesc": string, // Description provides details about the specific goal related to that habit, which includes the target, type, and why it's necessary to achieve it.
    "goalType": "completion"|"count"|"distance"|"duration",
    "targetValue": number,
    "goalFrequency": {
      "type": "interval"|"daily"|"weekDays"|"monthly",
      "interval": {"value": number, "type": "months"|"days"|"hours"|"minutes"} | null,
      "monthlyDates": [number] | null,
      "weekDays": [number] | null,
      "lastCompletionTime": null
    },
    "goalUnit": "reps"|"sets"|"l"|"ml"|"page"|"day"|"second"|"minutes"|"hour"|"cm"|"km"|"m"|"steps"|"miles"|"times|glasses",
  },
  "habitIcon": {
    "key": string,
    "icon": string (use exact SVG string from icon selection rules),
    "color": string (hex color from icon selection rules)
  },
  "habitCategory": string,
  "timeOfDay": string,
  "reminderTimes": [string],
  "habitStatus": "inProgress",
}

Reminder Times Template:
morning: ["06:00", "08:00"]
afternoon: ["12:00", "14:00"]
evening: ["18:00", "19:00"]
night: ["21:00", "22:00"]
anytime: Based on context

Example inputs and expected handling:
✓ "Read 20 pages every morning" (Specific count, time)
✓ "Meditate for 10 minutes daily" (Specific duration, frequency)
✓ "Exercise 3 times a week" (Specific frequency)
✗ "Be more healthy" (Too vague)
✗ "Read more" (Not measurable)

${language == 'vi' ? '''Additional Vietnamese context:
        - Translate all descriptions and titles to Vietnamese
        - Keep technical terms (habitTitle, goalType, etc.) in English
        - Use Vietnamese time and date formats
        - Adapt reminder times to Vietnamese daily routines
        ''' : ''}

    If input lacks SMART elements, return an empty string.
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
