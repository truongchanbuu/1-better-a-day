import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:readmore/readmore.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit/habit_status.dart';
import '../../../../../core/enums/habit/mood.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/num_extension.dart';
import '../../../../../generated/l10n.dart';
import '../../../../shared/presentations/widgets/text_with_circle_border_container.dart';
import '../../../../../core/enums/habit/goal_unit.dart';
import '../../../domain/entities/habit_history.dart';

class HistoryItem extends StatelessWidget {
  final HabitHistory history;
  const HistoryItem({super.key, required this.history});

  static const TextStyle _titleTextStyle =
      TextStyle(fontSize: AppFontSize.labelLarge);

  @override
  Widget build(BuildContext context) {
    final habitStatus = HabitStatus.fromString(history.executionStatus);

    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: AppColors.grayText,
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingM, vertical: AppSpacing.paddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWithCircleBorderContainer(
            title: history.executionStatus.toUpperCase(),
            backgroundColor: habitStatus.habitStatusColor,
            titleColor: habitStatus.habitStatusColor,
            fontSize: AppFontSize.labelLarge,
          ),
          _buildDoneDate(),
          _buildTarget(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Mood.fromString(history.mood).moodIcon,
              color: Colors.amber,
            ),
            title: Text(
              history.mood?.toUpperCase() ?? '',
              style: _titleTextStyle,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              FontAwesomeIcons.star,
              color: Colors.amberAccent,
            ),
            title: Text(
              (history.rating ?? 0).toStringAsFixedWithoutZero(1),
              style: _titleTextStyle,
            ),
          ),
          if (history.note != null) _buildNote(context),
        ],
      ),
    );
  }

  Widget _buildNote(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.8, color: AppColors.grayText),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(FontAwesomeIcons.message, color: Colors.blueAccent),
        title: ReadMoreText(
          history.note!,
          style: _titleTextStyle,
          trimCollapsedText: ' ${S.current.show_more}',
          trimExpandedText: ' ${S.current.show_less}',
          trimLines: 3,
          trimMode: TrimMode.Line,
          colorClickableText:
              context.isDarkMode ? AppColors.lightText : AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildDoneDate() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(FontAwesomeIcons.calendar, color: Colors.indigo),
      title: Text(
        formattedDate,
        style: _titleTextStyle,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            FontAwesomeIcons.clock,
            color: AppColors.grayText,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.marginS),
          Text(
            formattedTime,
            style: const TextStyle(
              color: AppColors.grayText,
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.labelLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTarget() {
    final GoalUnit goalUnit = GoalUnit.fromString(history.measurement);
    String unit = (goalUnit == GoalUnit.custom)
        ? goalUnit.unitName ?? '___'
        : goalUnit.name;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(goalUnit.unitIcon, color: Colors.purple),
      title: Text(
        '${history.quantity} $unit',
        style: _titleTextStyle,
      ),
    );
  }

  String get formattedDate => DateTimeFormat.onlyDate(history.date);
  String get formattedTime => history.date.toMoment().formatTimeWithSeconds();
}
