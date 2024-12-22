// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overall_analysis_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverallAnalysisResult _$OverallAnalysisResultFromJson(
        Map<String, dynamic> json) =>
    OverallAnalysisResult(
      specific: HabitAnalysisResult.fromJson(
          json['specific'] as Map<String, dynamic>),
      measurable: HabitAnalysisResult.fromJson(
          json['measurable'] as Map<String, dynamic>),
      achievable: HabitAnalysisResult.fromJson(
          json['achievable'] as Map<String, dynamic>),
      relevant: HabitAnalysisResult.fromJson(
          json['relevant'] as Map<String, dynamic>),
      timeBound: HabitAnalysisResult.fromJson(
          json['timeBound'] as Map<String, dynamic>),
      overallScore: (json['overallScore'] as num).toDouble(),
      summary: json['summary'] as String,
      improvedSentence: json['improvedSentence'] as String,
    );

Map<String, dynamic> _$OverallAnalysisResultToJson(
        OverallAnalysisResult instance) =>
    <String, dynamic>{
      'specific': instance.specific,
      'measurable': instance.measurable,
      'achievable': instance.achievable,
      'relevant': instance.relevant,
      'timeBound': instance.timeBound,
      'overallScore': instance.overallScore,
      'summary': instance.summary,
      'improvedSentence': instance.improvedSentence,
    };
