part of 'share_habit_bloc.dart';

sealed class ShareHabitEvent extends Equatable {
  const ShareHabitEvent();

  @override
  List<Object?> get props => [];
}

final class ShareHabitToFacebook extends ShareHabitEvent {
  final GlobalKey screenshotKey;
  final BuildContext context;
  final String? subject;
  final String? content;

  const ShareHabitToFacebook({
    required this.screenshotKey,
    required this.context,
    this.subject,
    this.content,
  });

  @override
  List<Object?> get props => [screenshotKey, context, subject, content];
}

final class SaveImage extends ShareHabitEvent {
  final String? name;
  final GlobalKey screenshotKey;
  final BuildContext context;

  const SaveImage({
    required this.context,
    required this.screenshotKey,
    this.name,
  });

  @override
  List<Object?> get props => [screenshotKey, context, name];
}
