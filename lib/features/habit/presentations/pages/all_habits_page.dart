import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/habit_category.dart';
import '../../../../core/enums/habit/habit_status.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/num_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';
import '../../../notification/presentations/blocs/reminder/reminder_bloc.dart';
import '../blocs/statistic_crud/statistic_crud_bloc.dart';
import '../helpers/shared_habit_action.dart';
import '../widgets/habit_list.dart';
import '../widgets/search_filter/habit_search_filter_bar.dart';
import '../widgets/habit_section_container.dart';
import 'habit_statistic_page.dart';

class AllHabitsPage extends StatefulWidget {
  const AllHabitsPage({super.key});

  @override
  State<AllHabitsPage> createState() => _AllHabitsPageState();
}

class _AllHabitsPageState extends State<AllHabitsPage> with RouteAware {
  HabitCategory? category;
  HabitStatus? status;
  String progress = '';
  bool _isHabitListView = true;

  @override
  void initState() {
    super.initState();
    _loadStatistic();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _loadStatistic();
    super.didPopNext();
  }

  void _loadStatistic() {
    context.read<StatisticCrudBloc>().add(LoadBriefStatistic());
  }

  static const _spacing = SizedBox(height: AppSpacing.marginL);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(AppSpacing.paddingL)
                .copyWith(bottom: AppSpacing.paddingXS),
            child: Column(
              children: <Widget>[
                // General Section
                BlocBuilder<StatisticCrudBloc, StatisticCrudState>(
                  buildWhen: (previous, current) =>
                      current is BriefStatisticLoaded,
                  builder: (context, state) {
                    if (state is StatisticLoading) {
                      return LoadingIndicator(indicatorType: Indicator.pacman);
                    }

                    if (state is! BriefStatisticLoaded) {
                      return const SizedBox.shrink();
                    }

                    return HabitSectionContainer(
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
                              S.current.habits(state.totalHabits),
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
                            ),
                            onTap: _showStatisticPage,
                            contentPadding: EdgeInsets.zero,
                            trailing: const Icon(
                              FontAwesomeIcons.chevronRight,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.marginS),
                          Row(
                            children: [
                              Expanded(
                                child: _BriefStatisticItem(
                                  icon: FontAwesomeIcons.fire,
                                  iconColor: Colors.red,
                                  label: S.current.longest_streak,
                                  value: state.longestStreak
                                      .toStringAsFixedWithoutZero(),
                                  valueTextColor: Colors.red,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.marginS),
                              Expanded(
                                child: _BriefStatisticItem(
                                  icon: FontAwesomeIcons.crown,
                                  iconColor: Colors.amber,
                                  label: S.current.achievement_done,
                                  value: state.totalAchievements
                                      .toStringAsFixedWithoutZero(),
                                  valueTextColor: Colors.amber,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
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
                      HabitSearchFilterBar(
                        onFilterChanged: (category, status, progress) {
                          setState(() {
                            this.category = category;
                            this.status = status;
                            this.progress = progress;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                _spacing,
                Expanded(
                  child: BlocProvider(
                    create: (context) => getIt.get<ReminderBloc>(),
                    child: HabitList(
                      category: category,
                      status: status,
                      progress: progress,
                      isListView: _isHabitListView,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _buildAddButton(),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: () => SharedHabitAction.showAddHabitOptions(context),
      style: ElevatedButton.styleFrom(
        shape: const BeveledRectangleBorder(
          side: BorderSide(width: 0.5, color: Colors.white),
        ),
        backgroundColor:
            context.isDarkMode ? AppColors.primaryDark : AppColors.primary,
      ),
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
            size: 30,
          ),
          const SizedBox(height: AppSpacing.marginS),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: AppFontSize.bodyMedium),
            overflow: TextOverflow.visible,
            maxLines: 3,
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
