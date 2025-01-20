import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/search_bar.dart';
import '../widgets/shared_habit_item.dart';

enum ShareTab { discover, customChallenge }

class ShareChallengeTab extends StatelessWidget {
  final ShareTab tab;
  const ShareChallengeTab({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.marginM),
      child: Column(
        children: [
          AppSearchBar(
            hintText: tab == ShareTab.discover
                ? S.current.search_community_challenge
                : S.current.search_my_custom_challenge,
          ),
          const SizedBox(height: AppSpacing.marginM),
          ...List.generate(10, (index) => SharedHabitItem(tab: tab)),
        ],
      ),
    );
  }
}
