import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_common.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../widgets/habit_list.dart';
import '../widgets/search_filter/habit_search_filter_bar.dart';
import '../widgets/habit_section_container.dart';
import 'habit_statistic_page.dart';

class AllHabitsPage extends StatefulWidget {
  const AllHabitsPage({super.key});

  @override
  State<AllHabitsPage> createState() => _AllHabitsPageState();
}

class _AllHabitsPageState extends State<AllHabitsPage> {
  bool _isHabitListView = true;

  static const _spacing = SizedBox(height: AppSpacing.marginL);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.paddingL)
              .copyWith(bottom: AppSpacing.paddingXS),
          child: Column(
            children: <Widget>[
              // General Section
              HabitSectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        S.current.statistic_section,
                        style: const TextStyle(
                          fontSize: AppFontSize.h2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        S.current.habits(10),
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      onTap: _showStatisticPage,
                      contentPadding: EdgeInsets.zero,
                      trailing: const Icon(
                        FontAwesomeIcons.chevronRight,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.marginL),
                    Row(
                      children: [
                        Expanded(
                          child: _BriefStatisticItem(
                            icon: FontAwesomeIcons.fire,
                            iconColor: Colors.red,
                            label: S.current.longest_streak,
                            value: '10',
                            valueTextColor: Colors.red,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.marginS),
                        Expanded(
                          child: _BriefStatisticItem(
                            icon: FontAwesomeIcons.listCheck,
                            iconColor: Colors.blue,
                            label: S.current.today_tasks,
                            value: S.current.done_tasks(5, 10),
                            valueTextColor: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.marginS),
                        Expanded(
                          child: _BriefStatisticItem(
                            icon: FontAwesomeIcons.crown,
                            iconColor: Colors.green,
                            label: S.current.achievement_done,
                            value: '10',
                            valueTextColor: Colors.green,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              _spacing,
              // Habit List Title & Filter
              HabitSectionContainer(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.all_habits,
                          style: const TextStyle(
                            fontSize: AppFontSize.h2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(
                              () => _isHabitListView = !_isHabitListView),
                          child: _isHabitListView
                              ? const Icon(FontAwesomeIcons.list)
                              : const Icon(FontAwesomeIcons.grip),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.marginL),
                    const HabitSearchFilterBar(),
                  ],
                ),
              ),
              _spacing,
              Expanded(
                child: HabitList(isListView: _isHabitListView),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildAddButton(),
      ),
    );
  }

  Widget _buildAddButton() {
    return Bounce(
      duration: AppCommons.buttonBounceDuration,
      onPressed: () {},
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
        ),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.paddingM),
        margin: const EdgeInsets.all(AppSpacing.paddingS),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.circlePlus,
              color: AppColors.lightText,
            ),
            const SizedBox(width: AppSpacing.marginM),
            Text(
              S.current.add_habit.toUpperCase(),
              style: const TextStyle(
                fontSize: AppFontSize.h2,
                fontWeight: FontWeight.bold,
                color: AppColors.lightText,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showStatisticPage() {
    Navigator.push(
        context,
        PageTransition(
          child: const HabitStatisticPage(),
          type: PageTransitionType.leftToRight,
        ));
  }
}

class _BriefStatisticItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color? valueTextColor;
  final String label;
  final String value;

  const _BriefStatisticItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.valueTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.primaryDark : Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSpacing.radiusS),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: Colors.black12,
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingS),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          const SizedBox(height: AppSpacing.marginS),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: AppFontSize.bodySmall),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: AppFontSize.h3,
              fontWeight: FontWeight.bold,
              color: valueTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
