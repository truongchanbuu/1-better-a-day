import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habit_icon.g.dart';

enum PredefinedHabitIconKey { water, exercise, time, education, custom }

@JsonSerializable()
class HabitIcon {
  final String key;
  final String icon;
  @ColorConverter()
  final Color color;
  final double size;

  const HabitIcon({
    required this.key,
    required this.icon,
    required this.color,
    this.size = 24.0,
  });

  static List<HabitIcon> predefinedIcons = [
    HabitIcon(
      key: PredefinedHabitIconKey.water.name,
      icon: Mdi.water_drop,
      color: Colors.blue,
    ),
    HabitIcon(
      key: PredefinedHabitIconKey.exercise.name,
      icon: Mdi.human_run,
      color: Colors.green,
    ),
    HabitIcon(
      key: PredefinedHabitIconKey.time.name,
      icon: Mdi.alarm,
      color: Colors.orange,
    ),
    HabitIcon(
      key: PredefinedHabitIconKey.education.name,
      icon: Mdi.book_open,
      color: Colors.brown,
    ),
    HabitIcon(
      key: PredefinedHabitIconKey.custom.name,
      icon: Mdi.help_circle,
      color: Colors.purple,
    ),
  ];

  static HabitIcon fromKey(PredefinedHabitIconKey key) {
    return predefinedIcons.firstWhere(
      (habitIcon) => habitIcon.key == key.name,
      orElse: () => predefinedIcons.last,
    );
  }

  factory HabitIcon.fromJson(Map<String, dynamic> json) =>
      _$HabitIconFromJson(json);

  Map<String, dynamic> toJson() => _$HabitIconToJson(this);
}

class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String json) =>
      Color(int.parse(json.replaceFirst('#', '0xFF')));

  @override
  String toJson(Color color) =>
      '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
}
