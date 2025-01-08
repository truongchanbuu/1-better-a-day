// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_icon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitIcon _$HabitIconFromJson(Map<String, dynamic> json) => HabitIcon(
      key: json['key'] as String,
      icon: json['icon'] as String,
      color: const ColorConverter().fromJson(json['color'] as String),
      size: (json['size'] as num?)?.toDouble() ?? 24.0,
    );

Map<String, dynamic> _$HabitIconToJson(HabitIcon instance) => <String, dynamic>{
      'key': instance.key,
      'icon': instance.icon,
      'color': const ColorConverter().toJson(instance.color),
      'size': instance.size,
    };
