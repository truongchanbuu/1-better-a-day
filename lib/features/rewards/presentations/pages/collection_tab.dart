import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/jam.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:moment_dart/moment_dart.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/rewards/achievement_level.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';
import '../../domain/entities/achievements/achievement_entity.dart';
import '../blocs/challenge_crud/challenge_crud_bloc.dart';
import '../blocs/collection_crud/collection_crud_bloc.dart';

class CollectionTab extends StatelessWidget {
  const CollectionTab({super.key});

  static const _emptyValue = '____';
  static const _spacing = SizedBox(height: AppSpacing.marginM);
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChallengeCrudBloc, ChallengeCrudState>(
      listener: (context, state) =>
          context.read<CollectionCrudBloc>().add(LoadCollectionData()),
      listenWhen: (previous, current) => current is ChallengeUnlocked,
      child: BlocConsumer<CollectionCrudBloc, CollectionCrudState>(
        listener: (context, state) {
          if (state is CollectionLoadedFailed) {
            AwesomeDialog(
              context: context,
              title: S.current.failure_title,
              desc: state.message,
            ).show();
          }
        },
        builder: (context, state) {
          if (state is CollectionLoading) {
            return LoadingIndicator(indicatorType: Indicator.pacman);
          }

          if (state is CollectionLoaded) {
            return Container(
              padding: const EdgeInsets.all(AppSpacing.marginM),
              child: Column(
                children: [
                  _buildRewards(context, state),
                  _spacing,
                  _buildQuickStats(context, state),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildRewards(BuildContext context, CollectionLoaded state) {
    return Container(
      color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
      padding: const EdgeInsets.all(AppSpacing.marginM),
      child: Column(
        children: [
          _RowItem(
            title: S.current.total_achievement(state.totalAchievements),
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
                        subTitle: state.levelStats[level]?.progressText,
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
                        subTitle: state.levelStats[level]?.progressText,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context, CollectionLoaded state) {
    String formatAchievement(AchievementEntity? achievement) {
      if (achievement == null) return _emptyValue;
      final date =
          achievement.unlockedDate?.toMoment().formatDateTime() ?? _emptyValue;
      return '${achievement.achievementName} - $date';
    }

    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        borderRadius: BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
      ),
      padding: EdgeInsets.all(AppSpacing.paddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconWithText(
            icon: Icons.numbers,
            text: S.current.quick_stats_title,
            fontWeight: FontWeight.bold,
            fontSize: AppFontSize.h4,
          ),
          _buildStatTile(
            S.current.latest_achievement_title,
            state.lastAchievedChallenge?.achievementName ?? _emptyValue,
          ),
          _buildStatTile(
            S.current.first_achievement_title,
            formatAchievement(state.firstAchievedChallenge),
          ),
          _buildStatTile(
            S.current.most_achieved_level,
            state.mostAchievedLevel?.name.toUpperCaseFirstLetter ?? _emptyValue,
            state.mostAchievedLevel?.color,
          ),
          _buildStatTile(
            S.current.most_achieved_type,
            state.mostAchievedType?.name.toUpperCaseFirstLetter ?? _emptyValue,
          ),
        ],
      ),
    );
  }

  Widget _buildStatTile(String title, String value, [Color? valueColor]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: AppFontSize.h4),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.h4,
                color: valueColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
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
