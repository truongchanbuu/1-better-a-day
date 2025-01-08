import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/day_status.dart';
import '../../../../core/enums/habit/mood.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/helpers/date_time_helper.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/habit_history.dart';
import '../blocs/habit_history_crud/habit_history_crud_bloc.dart';
import '../widgets/habit_streak_calendar.dart';
import '../widgets/habit_history/history_item.dart';
import '../widgets/search_filter/habit_date_picker.dart';
import '../widgets/search_filter/filter_item.dart';

class HabitHistoryPage extends StatefulWidget {
  final String habitId;
  final List<HabitHistory> habitHistories;

  const HabitHistoryPage({
    super.key,
    required this.habitId,
    required this.habitHistories,
  });

  @override
  State<HabitHistoryPage> createState() => _HabitHistoryPageState();
}

class _HabitHistoryPageState extends State<HabitHistoryPage> {
  List<HabitHistory> histories = [];
  String? selectedDate;

  @override
  void initState() {
    super.initState();
    histories = widget.habitHistories;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<HabitHistoryCrudBloc, HabitHistoryCrudState>(
        listener: (context, state) {
          setState(() {
            if (state is HabitHistoryCrudSuccess) {
              if (state.type == HabitHistoryCrudEventType.list) {
                setState(() => histories = state.histories);
              }
            }
          });
        },
        child: Scaffold(
          appBar: AppBar(title: Text(S.current.history_section)),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(
                  vertical: AppSpacing.marginS, horizontal: AppSpacing.marginM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HabitStreakCalendar(
                    completedDates: DateTimeHelper.getDatesByStatus(
                        histories, DayStatus.completed),
                    failedDates: DateTimeHelper.getDatesByStatus(
                        histories, DayStatus.failed),
                    skippedDates: DateTimeHelper.getDatesByStatus(
                        histories, DayStatus.skipped),
                    onDaySelected: (date, status) {},
                  ),
                  const SizedBox(height: AppSpacing.marginM),
                  Text(
                    S.current.detail_section,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppFontSize.h1,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.marginS),
                  _FilterBar(
                    onFilter: (status, mood, date) {
                      context
                          .read<HabitHistoryCrudBloc>()
                          .add(SearchHabitsByFilter(
                            habitId: widget.habitId,
                            status: status,
                            mood: mood,
                            date: date,
                          ));
                    },
                  ),
                  const SizedBox(height: AppSpacing.marginM),
                  ...histories.map((history) => HistoryItem(history: history)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterBar extends StatefulWidget {
  final void Function(DayStatus? status, Mood? mood, String date) onFilter;

  const _FilterBar({required this.onFilter});

  @override
  State<_FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<_FilterBar> {
  DayStatus? currentStatus;
  Mood? currentMood;
  String currentSelectedDate = '';
  bool _isDateSelectedShown = false;

  static const String allKey = 'All';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FilterItem(
                width: 170,
                title: S.current.status_title,
                items: DayStatus.values
                    .map((e) => e.statusName.toUpperCaseFirstLetter)
                    .toList()
                  ..insert(0, allKey),
                onChanged: (value) {
                  if (value?.isEmpty ?? true) {
                    currentStatus = null;
                  } else {
                    final dayStatus = DayStatus.fromMultiLangString(value);
                    currentStatus = dayStatus;
                  }

                  widget.onFilter(
                      currentStatus, currentMood, currentSelectedDate);
                },
              ),
              FilterItem(
                width: 150,
                title: S.current.mood_title,
                items: Mood.values.map((e) => e.moodName).toList()
                  ..insert(0, allKey),
                onChanged: (value) {
                  if (value?.isEmpty ?? true) {
                    currentMood = null;
                  } else {
                    final mood = Mood.fromMultiString(value);
                    currentMood = mood;
                  }

                  widget.onFilter(
                      currentStatus, currentMood, currentSelectedDate);
                },
              ),
              FilterItem(
                width: 150,
                title: S.current.date_title,
                items: const [],
                iconStyleData: const IconStyleData(icon: Icon(null)),
                onTap: () {
                  setState(() => _isDateSelectedShown = !_isDateSelectedShown);
                },
              ),
            ],
          ),
        ),
        AnimatedSwitcherPlus.translationRight(
          duration: const Duration(milliseconds: 500),
          child: _isDateSelectedShown
              ? HabitDatePicker(
                  onSelected: (selected) {
                    if (selected.isNotEmpty) {
                      currentSelectedDate = selected;
                      widget.onFilter(
                          currentStatus, currentMood, currentSelectedDate);
                    }
                  },
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
