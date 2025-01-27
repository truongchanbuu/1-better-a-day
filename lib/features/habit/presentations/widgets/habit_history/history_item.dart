import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:readmore/readmore.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit/mood.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/num_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../generated/l10n.dart';
import '../../../../shared/presentations/widgets/icon_with_text.dart';
import '../../../../shared/presentations/widgets/text_with_circle_border_container.dart';
import '../../../../../core/enums/habit/goal_unit.dart';
import '../../../domain/entities/habit_history.dart';
import '../../helpers/shared_habit_action.dart';

class HistoryItem extends StatefulWidget {
  final HabitHistory history;
  const HistoryItem({super.key, required this.history});

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  late final CustomPopupMenuController _customPopupMenuController;

  @override
  void initState() {
    super.initState();
    _customPopupMenuController = CustomPopupMenuController();
  }

  @override
  void dispose() {
    _customPopupMenuController.dispose();
    super.dispose();
  }

  static const TextStyle _titleTextStyle =
      TextStyle(fontSize: AppFontSize.labelLarge);

  @override
  Widget build(BuildContext context) {
    final dayStatus = widget.history.executionStatus;

    final basedColor =
        context.isDarkMode ? AppColors.darkText : AppColors.lightText;
    final menuTextColor =
        !context.isDarkMode ? AppColors.darkText : AppColors.lightText;

    return CustomPopupMenu(
      controller: _customPopupMenuController,
      arrowColor: basedColor,
      position: PreferredPosition.top,
      verticalMargin: 0,
      menuBuilder: () {
        return GestureDetector(
          onTap: () {
            _customPopupMenuController.hideMenu();
            SharedHabitAction.onRateAndNote(context, widget.history);
          },
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
              color: basedColor,
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(AppSpacing.paddingS),
            child: IconWithText(
              icon: FontAwesomeIcons.noteSticky,
              text: S.current.note_title,
              iconColor: menuTextColor,
              fontColor: menuTextColor,
              fontSize: AppFontSize.bodyLarge,
            ),
          ),
        );
      },
      pressType: PressType.longPress,
      child: Container(
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
              title: dayStatus.statusName.toUpperCase(),
              backgroundColor: dayStatus.statusColor,
              titleColor: dayStatus.statusColor,
              fontSize: AppFontSize.labelLarge,
            ),
            _buildDoneDate(),
            _buildTarget(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                widget.history.mood?.moodIcon ?? Mood.neutral.moodIcon,
                color: Colors.amber,
              ),
              title: Text(
                widget.history.mood?.name.toUpperCase() ?? '...',
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
                (widget.history.rating ?? 0).toStringAsFixedWithoutZero(),
                style: _titleTextStyle,
              ),
            ),
            if (widget.history.note != null) _buildNote(context),
          ],
        ),
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
          widget.history.note!,
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
    final GoalUnit goalUnit = widget.history.measurement;
    String unit =
        (goalUnit == GoalUnit.custom) ? goalUnit.unitName : goalUnit.name;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(goalUnit.unitIcon, color: goalUnit.unitColor),
      title: Text(
        '${widget.history.targetValue} ${unit.toUpperCaseFirstLetter}',
        style: _titleTextStyle,
      ),
    );
  }

  String get formattedDate => widget.history.date.toMoment().formatDate();

  String get formattedTime =>
      widget.history.date.toMoment().formatTimeWithSeconds();
}
