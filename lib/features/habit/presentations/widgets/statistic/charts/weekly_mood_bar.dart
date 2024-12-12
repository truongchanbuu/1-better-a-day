import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/constants/app_color.dart';
import '../../../../../../core/constants/app_font_size.dart';
import '../../../../../../core/constants/app_spacing.dart';
import '../../../../../../core/enums/mood.dart';
import '../../../../../../core/extensions/string_extension.dart';
import '../../../../../../core/helpers/date_time_helper.dart';
import '../../../../domain/entities/mood_entry.dart';
import '../../animated_mood_icon.dart';

class WeeklyMoodBar extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final List<MoodEntry> moodEntries;

  const WeeklyMoodBar({
    super.key,
    this.startDate,
    this.endDate,
    required this.moodEntries,
  }) : assert(moodEntries.length <= 7, 'Only 7 days are allowed to display');

  @override
  State<WeeklyMoodBar> createState() => _WeeklyMoodBarState();
}

class _WeeklyMoodBarState extends State<WeeklyMoodBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<_DayMood> _processedMoods;

  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    startDate =
        widget.startDate ?? DateTime.now().subtract(const Duration(days: 7));
    endDate = widget.endDate ?? DateTime.now();

    _processedMoods = _processMoodData();

    _controllers = List.generate(
      _processedMoods.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 500 + (index * 100)),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      );
    }).toList();

    Future.delayed(const Duration(milliseconds: 200), () {
      for (var controller in _controllers) {
        controller.forward();
      }
    });
  }

  static const _aDay = Duration(days: 1);
  List<_DayMood> _processMoodData() {
    final moodMap = {
      for (var entry in widget.moodEntries) _dateToKey(entry.date): entry.mood
    };

    final days = <_DayMood>[];
    var currentDate = startDate;
    while (currentDate.isBefore(endDate.add(_aDay))) {
      final dateKey = _dateToKey(currentDate);
      final mood = moodMap[dateKey];

      days.add(_DayMood(
        date: currentDate,
        mood: mood,
        dayName: DateTimeHelper.getDayName(currentDate),
      ));

      currentDate = currentDate.add(_aDay);
    }

    return days;
  }

  String _dateToKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  static const _spacing = SizedBox(height: AppSpacing.marginS);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.paddingS),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _processedMoods.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.marginS),
        itemBuilder: (context, index) => _buildMoodColumn(
          dayMood: _processedMoods[index],
          animation: _animations[index],
        ),
      ),
    );
  }

  static const _moodTitleFontSize = AppFontSize.labelMedium;
  Widget _buildMoodColumn({
    required _DayMood dayMood,
    required Animation<double> animation,
  }) {
    return ScaleTransition(
      scale: animation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dayMood.dayName,
            style: const TextStyle(
              fontSize: AppFontSize.bodyMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
          _spacing,
          dayMood.date != null
              ? _buildDay(dayMood.date!.day)
              : _buildEmptyData(),
          _spacing,
          _buildMoodDay(dayMood.mood),
        ],
      ),
    );
  }

  Widget _buildMoodDay(Mood? mood) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(AppSpacing.paddingS),
          decoration: BoxDecoration(
            color: mood?.color != null
                ? mood!.color.withOpacity(0.2)
                : AppColors.grayBackgroundColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppSpacing.radiusM),
          ),
          child: Center(
            child: mood != null
                ? AnimatedMoodIcon(
                    mood: mood,
                    size: 32,
                  )
                : const FaIcon(
                    FontAwesomeIcons.minus,
                    color: AppColors.grayText,
                  ),
          ),
        ),
        _spacing,
        mood?.name != null
            ? Text(
                mood!.name.toUpperCaseFirstLetter,
                style: TextStyle(
                  fontSize: _moodTitleFontSize,
                  color: mood.color,
                  fontWeight: FontWeight.bold,
                ),
              )
            : _buildEmptyData(),
      ],
    );
  }

  Widget _buildDay(int day) {
    return Text(
      '$day',
      style: const TextStyle(
        fontSize: AppFontSize.labelLarge,
        color: AppColors.grayText,
      ),
    );
  }

  Widget _buildEmptyData() {
    return const Text(
      '-',
      style: TextStyle(
        fontSize: AppFontSize.labelLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.grayText,
      ),
    );
  }
}

class _DayMood {
  final DateTime? date;
  final Mood? mood;
  final String dayName;

  _DayMood({
    this.date,
    this.mood,
    required this.dayName,
  });
}
