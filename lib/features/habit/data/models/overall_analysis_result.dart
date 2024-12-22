import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'habit_analysis_result.dart';

part 'overall_analysis_result.g.dart';

@JsonSerializable()
class OverallAnalysisResult extends Equatable {
  final HabitAnalysisResult specific;
  final HabitAnalysisResult measurable;
  final HabitAnalysisResult achievable;
  final HabitAnalysisResult relevant;
  final HabitAnalysisResult timeBound;
  final double overallScore;
  final String summary;
  final String improvedSentence;

  const OverallAnalysisResult({
    required this.specific,
    required this.measurable,
    required this.achievable,
    required this.relevant,
    required this.timeBound,
    required this.overallScore,
    required this.summary,
    required this.improvedSentence,
  });

  factory OverallAnalysisResult.init() {
    return OverallAnalysisResult(
      specific: HabitAnalysisResult.init(),
      measurable: HabitAnalysisResult.init(),
      achievable: HabitAnalysisResult.init(),
      relevant: HabitAnalysisResult.init(),
      timeBound: HabitAnalysisResult.init(),
      overallScore: 0,
      summary: '',
      improvedSentence: '',
    );
  }

  OverallAnalysisResult copyWith({
    HabitAnalysisResult? specific,
    HabitAnalysisResult? measurable,
    HabitAnalysisResult? achievable,
    HabitAnalysisResult? relevant,
    HabitAnalysisResult? timeBound,
    double? overallScore,
    String? summary,
    String? improvedSentence,
  }) {
    return OverallAnalysisResult(
      specific: specific ?? this.specific,
      measurable: measurable ?? this.measurable,
      achievable: achievable ?? this.achievable,
      relevant: relevant ?? this.relevant,
      timeBound: timeBound ?? this.timeBound,
      overallScore: overallScore ?? this.overallScore,
      summary: summary ?? this.summary,
      improvedSentence: improvedSentence ?? this.improvedSentence,
    );
  }

  factory OverallAnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$OverallAnalysisResultFromJson(json);

  Map<String, dynamic> toJson() => _$OverallAnalysisResultToJson(this);

  @override
  List<Object?> get props {
    return [
      specific,
      measurable,
      achievable,
      relevant,
      timeBound,
      overallScore,
      summary,
      improvedSentence,
    ];
  }
}
