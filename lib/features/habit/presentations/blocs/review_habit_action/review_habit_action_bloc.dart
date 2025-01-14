import 'package:bloc_event_transformers/bloc_event_transformers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/habit/mood.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entities/habit_history.dart';

part 'review_habit_action_event.dart';
part 'review_habit_action_state.dart';

class ReviewHabitActionBloc
    extends Bloc<ReviewHabitActionEvent, ReviewHabitActionState> {
  final HabitHistory history;
  ReviewHabitActionBloc(this.history)
      : super(ReviewHabitActionInitial(
          rating: history.rating ?? 5,
          note: history.note ?? '',
          mood: history.mood ?? Mood.great,
          isMoodManuallySet: false,
        )) {
    on<ChangeRating>(_onRatingChanged);
    on<ChangeMood>(_onMoodChanged);
    on<ChangeNote>(_onNoteChanged,
        transformer: debounce(const Duration(milliseconds: 200)));
    on<ValidateReview>(_onValidate);
  }

  void _onValidate(ValidateReview event, Emitter<ReviewHabitActionState> emit) {
    if (state.note.isEmpty) {
      emit(ValidateError(current: state, errorMessage: S.current.empty_field));
    } else {
      emit(ValidateSuccess(current: state));
    }
  }

  void _onRatingChanged(
      ChangeRating event, Emitter<ReviewHabitActionState> emit) {
    if (!state.isMoodManuallySet) {
      emit(RatingChanged(
        current: state,
        rating: event.rating,
        mood: _getMoodFromRating(event.rating),
      ));
    } else {
      emit(RatingChanged(current: state, rating: event.rating));
    }
  }

  void _onMoodChanged(ChangeMood event, Emitter<ReviewHabitActionState> emit) {
    emit(MoodChanged(current: state, mood: event.mood));
  }

  void _onNoteChanged(ChangeNote event, Emitter<ReviewHabitActionState> emit) {
    emit(NoteChanged(current: state, note: event.note.trim()));
  }

  Mood _getMoodFromRating(double rating) {
    if (rating >= 4.5) return Mood.great;
    if (rating >= 4) return Mood.good;
    if (rating >= 3) return Mood.neutral;
    if (rating >= 1.5) return Mood.bad;
    return Mood.terrible;
  }
}
