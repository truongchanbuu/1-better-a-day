part of 'review_habit_action_bloc.dart';

sealed class ReviewHabitActionEvent extends Equatable {
  const ReviewHabitActionEvent();

  @override
  List<Object> get props => [];
}

final class ChangeRating extends ReviewHabitActionEvent {
  final double rating;
  const ChangeRating(this.rating);
}

final class ChangeMood extends ReviewHabitActionEvent {
  final Mood mood;
  const ChangeMood(this.mood);
}

final class ChangeNote extends ReviewHabitActionEvent {
  final String note;
  const ChangeNote(this.note);
}

final class ValidateReview extends ReviewHabitActionEvent {}
