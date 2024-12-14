import 'package:flutter/material.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/jam.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/habit_category.dart';
import '../../../../core/enums/rewards/achievement_level.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../generated/l10n.dart';

class CollectionTab extends StatelessWidget {
  const CollectionTab({super.key});

  static const _spacing = SizedBox(height: AppSpacing.marginM);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.marginM),
      child: Column(
        children: [
          _buildRewards(context),
          _spacing,
          _AchievementSection(title: S.current.personal_achievements),
          _spacing,
          _AchievementSection(title: S.current.community_challenges),
        ],
      ),
    );
  }

  Widget _buildRewards(BuildContext context) {
    return Container(
      color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
      padding: const EdgeInsets.all(AppSpacing.marginM),
      child: Column(
        children: [
          _RowItem(
            title: S.current.total_achievement(10),
            icon: Jam.trophy,
            iconColor: Colors.amber,
          ),
          _spacing,
          Row(
            children: AchievementLevel.values
                .take(2)
                .map((level) => Expanded(
                      child: _RowItem(
                        title: level.name.toUpperCaseFirstLetter,
                        icon: Jam.medal,
                        iconColor: level.color,
                        subTitle: '12/20',
                      ),
                    ))
                .toList(),
          ),
          _spacing,
          Row(
            children: AchievementLevel.values
                .skip(2)
                .take(2)
                .map((level) => Expanded(
                      child: _RowItem(
                        title: level.name.toUpperCaseFirstLetter,
                        icon: Jam.medal,
                        iconColor: level.color,
                        subTitle: '12/20',
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _RowItem extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String icon;
  final Color? iconColor;

  const _RowItem({
    required this.title,
    required this.icon,
    this.iconColor,
    this.subTitle,
  });

  static const _spacing = SizedBox(height: AppSpacing.marginXS);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Iconify(
          icon,
          size: 35,
          color: iconColor,
        ),
        _spacing,
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.h4,
          ),
        ),
        _spacing,
        if (subTitle != null)
          Text(
            subTitle!,
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.h4,
            ),
          )
      ],
    );
  }
}

class _AchievementSection extends StatelessWidget {
  final String title;
  const _AchievementSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
      alignment: AlignmentDirectional.centerStart,
      padding: const EdgeInsets.all(AppSpacing.marginM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.h3,
            ),
          ),
          const SizedBox(height: AppSpacing.marginS),
          ...HabitCategory.values.map((category) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.categoryName,
                    style: const TextStyle(fontSize: AppFontSize.bodyLarge),
                  ),
                  const Text(
                    '3/8',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: AppFontSize.bodyLarge,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
