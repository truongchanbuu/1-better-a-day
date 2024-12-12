import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/helpers/date_time_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';

class ReminderSectionItem extends StatefulWidget {
  const ReminderSectionItem({super.key});

  @override
  State<ReminderSectionItem> createState() => _ReminderSectionItemState();
}

class _ReminderSectionItemState extends State<ReminderSectionItem> {
  bool isReminder = false;

  static const SizedBox _spacing = SizedBox(height: AppSpacing.marginM);
  static const _reminderFontSize = AppFontSize.h3;
  static const double _reminderIconSize = 20;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconWithText(
          icon: FontAwesomeIcons.calendar,
          text: DateTimeHelper.formatFullDate(
            DateTime.now().add(const Duration(days: 1)),
          ),
          fontSize: _reminderFontSize,
          iconSize: _reminderIconSize,
        ),
        _spacing,
        const IconWithText(
          icon: FontAwesomeIcons.clock,
          text: '7:30',
          fontSize: _reminderFontSize,
          iconSize: _reminderIconSize,
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: IconWithText(
            icon: FontAwesomeIcons.bell,
            text: isReminder
                ? S.current.active_button
                : S.current.inactive_button,
            fontSize: _reminderFontSize,
            iconSize: 22,
            iconColor: isReminder ? AppColors.primary : null,
          ),
          value: isReminder,
          onChanged: (value) => setState(() => isReminder = value),
        )
      ],
    );
  }
}
