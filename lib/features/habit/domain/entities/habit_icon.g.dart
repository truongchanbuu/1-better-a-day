// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_icon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitIcon _$HabitIconFromJson(Map<String, dynamic> json) => HabitIcon(
      key: json['key'] as String,
      icon: json['icon'] as String,
      color: _$JsonConverterFromJson<String, Color>(
          json['color'], const ColorConverter().fromJson),
      size: (json['size'] as num?)?.toDouble() ?? 24.0,
    );

Map<String, dynamic> _$HabitIconToJson(HabitIcon instance) => <String, dynamic>{
      'key': instance.key,
      'icon': instance.icon,
      'color': _$JsonConverterToJson<String, Color>(
          instance.color, const ColorConverter().toJson),
      'size': instance.size,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
