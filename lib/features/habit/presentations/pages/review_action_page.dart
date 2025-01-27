import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/mood.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/habit_history.dart';
import '../blocs/habit_history_crud/habit_history_crud_bloc.dart';
import '../blocs/review_habit_action/review_habit_action_bloc.dart';
import '../widgets/animated_mood_icon.dart';

class ReviewActionPage extends StatefulWidget {
  final HabitHistory history;
  const ReviewActionPage({super.key, required this.history});

  @override
  State<ReviewActionPage> createState() => _ReviewActionPageState();
}

class _ReviewActionPageState extends State<ReviewActionPage> {
  late final FocusNode _focusNode;
  late final TextEditingController _noteController;
  late HabitHistory history;

  @override
  void initState() {
    super.initState();
    history = widget.history;
    _focusNode = FocusNode();
    _noteController = TextEditingController(text: history.note);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _noteController.dispose();
    super.dispose();
  }

  static const double _iconSize = 70;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => _focusNode.unfocus(),
        child: BlocListener<ReviewHabitActionBloc, ReviewHabitActionState>(
          listener: (context, state) {
            if (state is ValidateError) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                title: S.current.failure_title,
                desc: state.errorMessage,
              ).show();
            } else if (state is ValidateSuccess) {
              context
                  .read<HabitHistoryCrudBloc>()
                  .add(HabitHistoryCrudUpdate(history));
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                title: S.current.success_title,
                btnOkText: S.current.go_home_button,
                btnOkOnPress: () {
                  Navigator.pop(context);
                },
              ).show();
            }
          },
          child: Scaffold(
            appBar: AppBar(title: const Text('Review Habit')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.paddingL),
              child: BlocBuilder<ReviewHabitActionBloc, ReviewHabitActionState>(
                builder: (context, state) {
                  if (state.note.isNotEmpty) {
                    history = history.copyWith(
                      mood: () => state.mood,
                      note: () => state.note,
                      rating: () => state.rating,
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: RatingBar.builder(
                          initialRating: history.rating ?? state.rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 50,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            context
                                .read<ReviewHabitActionBloc>()
                                .add(ChangeRating(rating));
                          },
                        ),
                      ),
                      const SizedBox(height: AppSpacing.marginM),
                      Center(
                        child: SizedBox(
                          width: _iconSize,
                          height: _iconSize,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                useSafeArea: true,
                                useRootNavigator: true,
                                builder: (ctx) => BlocProvider.value(
                                  value: context.read<ReviewHabitActionBloc>(),
                                  child: MoodSelectionSheet(
                                    currentMood: history.mood ?? state.mood,
                                    onMoodSelected: (mood) {
                                      context
                                          .read<ReviewHabitActionBloc>()
                                          .add(ChangeMood(mood));
                                    },
                                  ),
                                ),
                              );
                            },
                            child: AnimatedMoodIcon(
                              mood: history.mood ?? state.mood,
                              size: _iconSize,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.marginL),
                      TextField(
                        controller: _noteController,
                        focusNode: _focusNode,
                        onSubmitted: isHistoryChanged
                            ? (_) => context
                                .read<ReviewHabitActionBloc>()
                                .add(ValidateReview())
                            : null,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: S.current.note_hint,
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          context
                              .read<ReviewHabitActionBloc>()
                              .add(ChangeNote(value));
                        },
                      ),
                      if (history.note?.isEmpty ?? true) ...[
                        const SizedBox(height: AppSpacing.marginL),
                        Wrap(
                          spacing: 8,
                          children: state.mood.listNote
                              .map(
                                (suggestion) => ActionChip(
                                  label: Text(suggestion),
                                  onPressed: () {
                                    _noteController.text = state.note;
                                    context
                                        .read<ReviewHabitActionBloc>()
                                        .add(ChangeNote(suggestion));
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ],
                      const SizedBox(height: AppSpacing.marginL),
                      ElevatedButton(
                        onPressed: isHistoryChanged
                            ? () => context
                                .read<ReviewHabitActionBloc>()
                                .add(ValidateReview())
                            : null,
                        child: Text(
                          S.current.note_title,
                          style: const TextStyle(
                            color: AppColors.lightText,
                            fontWeight: FontWeight.bold,
                            fontSize: AppFontSize.h4,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get isHistoryChanged =>
      (history.mood != null && history.mood != widget.history.mood) ||
      (history.rating != null && history.rating != widget.history.rating) ||
      (history.note != widget.history.note);
}

class MoodSelectionSheet extends StatelessWidget {
  final Mood currentMood;
  final Function(Mood) onMoodSelected;

  const MoodSelectionSheet({
    super.key,
    required this.currentMood,
    required this.onMoodSelected,
  });

  static const double _iconSize = 40;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.marginS),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.current.select_mood_title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.h4,
            ),
          ),
          const SizedBox(height: AppSpacing.marginS),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: Mood.values
                  .map(
                    (mood) => GestureDetector(
                      onTap: () {
                        onMoodSelected(mood);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: currentMood == mood ? AppColors.primary : null,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppSpacing.radiusS),
                          ),
                        ),
                        padding: const EdgeInsets.all(AppSpacing.paddingM),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: _iconSize,
                              height: _iconSize,
                              child: AnimatedMoodIcon(
                                mood: mood,
                                size: _iconSize,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.marginS),
                            Text(
                              mood.moodName,
                              style: TextStyle(
                                fontWeight: currentMood == mood
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: currentMood == mood
                                    ? AppColors.lightText
                                    : AppColors.darkText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
