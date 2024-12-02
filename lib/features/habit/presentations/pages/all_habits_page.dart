import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_common.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../widgets/habit_list.dart';
import '../widgets/habit_search_filter_bar.dart';

class AllHabitsPage extends StatefulWidget {
  const AllHabitsPage({super.key});

  @override
  State<AllHabitsPage> createState() => _AllHabitsPageState();
}

class _AllHabitsPageState extends State<AllHabitsPage> {
  bool _isHabitListView = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(AppSpacing.marginL),
          child: Column(
            children: <Widget>[
              // General Section
              _SectionContainer(
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
                      onTap: () {},
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
                          child: _StatisticItem(
                            icon: FontAwesomeIcons.fire,
                            iconColor: Colors.red,
                            label: S.current.current_streak,
                            value: '10',
                            valueTextColor: Colors.red,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: AppSpacing.marginS),
                        Expanded(
                          child: _StatisticItem(
                            icon: FontAwesomeIcons.listCheck,
                            iconColor: Colors.blue,
                            label: S.current.today_tasks,
                            value: S.current.done_tasks(5, 10),
                            valueTextColor: Colors.blue,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: AppSpacing.marginS),
                        Expanded(
                          child: _StatisticItem(
                            icon: FontAwesomeIcons.crown,
                            iconColor: Colors.green,
                            label: S.current.achievement_done,
                            value: '10',
                            valueTextColor: Colors.green,
                            onTap: () {
                              // Handle tap
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.marginL),

              // Habit List Title & Filter
              _SectionContainer(
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
                    const SizedBox(height: AppSpacing.marginM),
                    const HabitSearchFilterBar(),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.marginL),
              Expanded(
                child: HabitList(isListView: _isHabitListView),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  final Widget child;
  const _SectionContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.paddingM),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSpacing.radiusS),
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 3,
            color: Colors.black12,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _StatisticItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color? valueTextColor;
  final String label;
  final String value;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const _StatisticItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.onTap,
    this.backgroundColor,
    this.valueTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: AppCommons.buttonBounceDuration,
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ??
              (context.isDarkMode ? AppColors.primaryDark : Colors.white),
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
              style: TextStyle(fontSize: AppFontSize.bodySmall),
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
      ),
    );
  }
}
