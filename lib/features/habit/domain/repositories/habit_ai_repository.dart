import '../../data/models/habit_model.dart';
import '../../data/models/overall_analysis_result.dart';

abstract interface class HabitAIRepository {
  Future<OverallAnalysisResult> analyzeGoal(String goal,
      {String language = 'en'});
  OverallAnalysisResult quickAnalyzeGoal(String goal, {String language = 'en'});
  Future<HabitModel?> generateHabitWithSentence(String sentence,
      {String language = 'en'});
}
