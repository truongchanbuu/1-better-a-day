part of 'review_habit_action_bloc.dart';

sealed class ReviewHabitActionState extends Equatable {
  final double rating;
  final Mood mood;
  final String note;
  final bool isMoodManuallySet;
  final String? errorMessage;

  const ReviewHabitActionState({
    required this.rating,
    required this.mood,
    required this.isMoodManuallySet,
    required this.note,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        rating,
        mood,
        note,
        isMoodManuallySet,
        errorMessage,
      ];
}

final class ReviewHabitActionInitial extends ReviewHabitActionState {
  const ReviewHabitActionInitial({
    required super.rating,
    required super.mood,
    required super.isMoodManuallySet,
    required super.note,
  });
}

final class RatingChanged extends ReviewHabitActionState {
  RatingChanged({
    required ReviewHabitActionState current,
    required super.rating,
    Mood? mood,
  }) : super(
          isMoodManuallySet: current.isMoodManuallySet,
          mood: mood ?? current.mood,
          note: current.note,
          errorMessage: null,
        );
}

final class MoodChanged extends ReviewHabitActionState {
  MoodChanged({
    required ReviewHabitActionState current,
    required super.mood,
  }) : super(
          isMoodManuallySet: true,
          rating: current.rating,
          note: current.note,
          errorMessage: null,
        );
}

final class NoteChanged extends ReviewHabitActionState {
  NoteChanged({
    required ReviewHabitActionState current,
    required super.note,
  }) : super(
          isMoodManuallySet: current.isMoodManuallySet,
          rating: current.rating,
          mood: current.mood,
          errorMessage: null,
        );
}

final class ValidateError extends ReviewHabitActionState {
  ValidateError({
    required ReviewHabitActionState current,
    required super.errorMessage,
  }) : super(
          mood: current.mood,
          note: current.note,
          isMoodManuallySet: current.isMoodManuallySet,
          rating: current.rating,
        );
}

final class ValidateSuccess extends ReviewHabitActionState {
  ValidateSuccess({required ReviewHabitActionState current})
      : super(
          rating: current.rating,
          isMoodManuallySet: current.isMoodManuallySet,
          note: current.note,
          mood: current.mood,
          errorMessage: null,
        );
}
