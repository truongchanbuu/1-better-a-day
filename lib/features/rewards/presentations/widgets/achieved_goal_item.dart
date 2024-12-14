import 'package:colorful_iconify_flutter/icons/twemoji.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';
import '../../../shared/presentations/widgets/text_with_circle_border_container.dart';

class AchievedGoalItem extends StatelessWidget {
  const AchievedGoalItem({super.key});

  static const _spacing = SizedBox(height: AppSpacing.marginS);
  static const _subTitleColor = AppColors.grayText;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusM)),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingM, vertical: AppSpacing.paddingS),
      margin: const EdgeInsets.all(AppSpacing.marginS),
      child: const Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Iconify(Twemoji.person_in_lotus_position),
            title: Text(
              '30-Day Meditation Master',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.h3,
              ),
            ),
            subtitle: Text(
              'Completed 30 days of morning meditation',
              maxLines: 3,
              style: TextStyle(
                color: _subTitleColor,
                fontSize: AppFontSize.bodyLarge,
              ),
            ),
          ),
          _spacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconWithText(
                icon: FontAwesomeIcons.calendar,
                text: 'Earned: 12/10/2024',
                iconSize: 20,
                fontSize: AppFontSize.labelLarge,
                fontColor: _subTitleColor,
                iconColor: _subTitleColor,
              ),
              TextWithCircleBorderContainer(
                title: 'Epic',
                backgroundColor: Colors.purple,
              )
            ],
          ),
          _spacing,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconWithText(
                icon: FontAwesomeIcons.calendar,
                text: '30 Streak',
                iconSize: 20,
                fontSize: AppFontSize.labelLarge,
                fontColor: _subTitleColor,
                iconColor: _subTitleColor,
              ),
              Text(
                '450 total minutes',
                style: TextStyle(
                  color: _subTitleColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
