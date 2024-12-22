// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_analysis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitAnalysisResult _$HabitAnalysisResultFromJson(Map<String, dynamic> json) =>
    HabitAnalysisResult(
      passed: json['passed'] as bool,
      score: (json['score'] as num).toDouble(),
    );

Map<String, dynamic> _$HabitAnalysisResultToJson(
        HabitAnalysisResult instance) =>
    <String, dynamic>{
      'passed': instance.passed,
      'score': instance.score,
    };
