import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habit_analysis_result.g.dart';

@JsonSerializable()
class HabitAnalysisResult extends Equatable {
  final bool passed;
  final double score;

  const HabitAnalysisResult({
    required this.passed,
    required this.score,
  });

  factory HabitAnalysisResult.init() {
    return const HabitAnalysisResult(passed: false, score: 0);
  }

  HabitAnalysisResult copyWith({
    bool? passed,
    double? score,
  }) {
    return HabitAnalysisResult(
      passed: passed ?? this.passed,
      score: score ?? this.score,
    );
  }

  factory HabitAnalysisResult.fromJson(Map<String, dynamic> json) =>
      _$HabitAnalysisResultFromJson(json);

  Map<String, dynamic> toJson() => _$HabitAnalysisResultToJson(this);

  @override
  List<Object> get props => [passed, score];
}
