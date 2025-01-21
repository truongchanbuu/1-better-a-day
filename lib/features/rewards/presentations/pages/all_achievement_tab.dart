import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/constants/app_common.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/rewards/achievement_level.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../habit/presentations/widgets/search_filter/filter_item.dart';
import '../../../shared/presentations/widgets/search_bar.dart';
import '../blocs/challenge_crud/challenge_crud_bloc.dart';
import '../widgets/achieved_goal_item.dart';

class AllAchievementTab extends StatefulWidget {
  const AllAchievementTab({super.key});

  @override
  State<AllAchievementTab> createState() => _AllAchievementTabState();
}

class _AllAchievementTabState extends State<AllAchievementTab> {
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadAllChallenges();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _loadAllChallenges() {
    context.read<ChallengeCrudBloc>().add(GetAllLocalChallenges());
  }

  static final String _allKey = S.current.all_selection;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.paddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSearchBar(
            hintText: S.current.search_achievement,
            onChanged: _onSearch,
          ),
          const SizedBox(height: AppSpacing.marginS),
          FilterItem(
            width: 120,
            title: S.current.challenge_level,
            items: AchievementLevel.values
                .map((e) => e.name.toUpperCaseFirstLetter)
                .toList()
              ..insert(0, _allKey),
            onChanged: (value) {
              if (value != null) {
                if (value == _allKey) {
                  _loadAllChallenges();
                } else {
                  final AchievementLevel level =
                      AchievementLevel.fromString(value);

                  context
                      .read<ChallengeCrudBloc>()
                      .add(SearchChallengeByLevel(level));
                }
              }
            },
          ),
          const SizedBox(height: AppSpacing.marginS),
          BlocBuilder<ChallengeCrudBloc, ChallengeCrudState>(
            builder: (context, state) {
              if (state is ChallengeLoading) {
                return LoadingIndicator(indicatorType: Indicator.pacman);
              }

              if (state is! AllChallengeGot || state.achievements.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                children: state.achievements
                    .map((achievement) =>
                        AchievedGoalItem(achievement: achievement))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(
      const Duration(milliseconds: AppCommons.searchDebounceTime),
      () {
        final searchText = value.toLowerCase().trim();
        if (searchText.isEmpty) {
          _loadAllChallenges();
        } else if (searchText.length >= 2) {
          context
              .read<ChallengeCrudBloc>()
              .add(SearchChallengeByKeyWords(searchText));
        }
      },
    );
  }
}
