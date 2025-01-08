import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum ReminderStatus {
  @JsonValue('active')
  active,
  @JsonValue('skipped')
  skipped,
  @JsonValue('canceled')
  canceled,
  @JsonValue('completed')
  completed,
}
