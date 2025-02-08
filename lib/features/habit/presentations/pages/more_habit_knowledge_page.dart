import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/domain/entities/tab_bar_item.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';

class MoreHabitKnowledgePage extends StatefulWidget {
  const MoreHabitKnowledgePage({super.key});

  @override
  State<MoreHabitKnowledgePage> createState() => _MoreHabitKnowledgePageState();
}

class _MoreHabitKnowledgePageState extends State<MoreHabitKnowledgePage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  final List<TabBarItem> _tabBarItems = [
    TabBarItem(title: S.current.science_tab, icon: Icons.science),
    TabBarItem(title: S.current.psy_tab, icon: Icons.psychology),
    TabBarItem(title: S.current.statistic_info_tab, icon: Icons.bar_chart),
  ];
  final List<_Insight> insights = [
    _Insight(
      title: S.current.compound_effect,
      desc: S.current.compound_effect_description,
    ),
    _Insight(
      title: S.current.power_of_timing,
      desc: S.current.power_of_timing_description,
    ),
    _Insight(
      title: S.current.pareto_principle,
      desc: S.current.pareto_principle_description,
    ),
  ];
  final List<_Quote> quotes = [
    _Quote(
      quote: S.current.quote_aristotle,
      author: S.current.author_aristotle,
    ),
    _Quote(
      quote: S.current.quote_james_clear,
      author: S.current.author_james_clear,
    ),
    _Quote(
      quote: S.current.quote_dwayne_johnson,
      author: S.current.author_dwayne_johnson,
    ),
  ];
  final List<_Fact> scienceFacts = [
    _Fact(
      title: S.current.science_21_day_rule,
      desc: S.current.science_21_day_rule_description,
      source: 'European Journal of Social Psychology',
      year: 2009,
    ),
    _Fact(
      title: S.current.science_neuroplasticity,
      desc: S.current.science_neuroplasticity_description,
      source: 'Journal of Neuroplasticity',
      year: 2018,
    ),
    _Fact(
      title: S.current.science_dopamine_habits,
      desc: S.current.science_dopamine_habits_description,
      source: 'Nature Neuroscience',
      year: 2020,
    ),
  ];
  final List<_Fact> psychologyFacts = [
    _Fact(
      title: S.current.psychology_cue_routine_reward,
      desc: S.current.psychology_cue_routine_reward_description,
      source: 'The Power of Habit - Charles Duhigg',
      year: 2012,
    ),
    _Fact(
      title: S.current.psychology_implementation_intentions,
      desc: S.current.psychology_implementation_intentions_description,
      source: 'American Journal of Psychology',
      year: 2017,
    ),
  ];
  final List<_Fact> statisticsFacts = [
    _Fact(
      title: S.current.statistics_success_rate,
      desc: S.current.statistics_success_rate_description,
      source: 'Duke University Research',
      year: 2021,
    ),
    _Fact(
      title: S.current.statistics_habit_formation_time,
      desc: S.current.statistics_habit_formation_time_description,
      source: 'Psychological Review',
      year: 2019,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabBarItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.isDarkMode
            ? AppColors.primaryDark
            : AppColors.grayBackgroundColor,
        bottomNavigationBar: _buildCarousel(
          items: quotes
              .map(
                (quote) => _SentenceTemplate(
                  title: quote.quote,
                  subTitle: quote.author,
                  backgroundColor: context.isDarkMode
                      ? AppColors.darkText
                      : AppColors.lightText,
                ),
              )
              .toList(),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCarousel(
                items: insights
                    .map(
                      (insight) => _SentenceTemplate(
                          title: insight.title, subTitle: insight.desc),
                    )
                    .toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.marginM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconWithText(
                      icon: FontAwesomeIcons.solidLightbulb,
                      text: S.current.know_more_about_habit,
                      iconColor: Colors.amber,
                      fontSize: AppFontSize.h3,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: AppSpacing.marginS),
                    ButtonsTabBar(
                      backgroundColor: AppColors.primary,
                      controller: _tabController,
                      contentPadding:
                          const EdgeInsets.only(right: AppSpacing.paddingS),
                      unselectedBackgroundColor: context.isDarkMode
                          ? AppColors.darkText
                          : AppColors.lightText,
                      unselectedLabelStyle: TextStyle(
                        color: context.isDarkMode
                            ? AppColors.lightText
                            : AppColors.darkText,
                      ),
                      tabs: _tabBarItems
                          .map((item) => Tab(
                                icon: Icon(item.icon),
                                text: item.title,
                              ))
                          .toList(),
                      onTap: (index) =>
                          setState(() => _tabController.index = index),
                    ),
                    const SizedBox(height: AppSpacing.marginS),
                    ..._getInfoList.map(
                      (fact) => _buildHabitInfo(fact),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<_Fact> get _getInfoList => switch (_tabController.index) {
        0 => scienceFacts,
        1 => psychologyFacts,
        2 => statisticsFacts,
        _ => [],
      };

  Widget _buildHabitInfo(_Fact fact) {
    return _SentenceTemplate(
      backgroundColor:
          context.isDarkMode ? AppColors.darkText : AppColors.lightText,
      textAlign: TextAlign.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      title: fact.title,
      subTitle: fact.desc,
      children: [
        Text(
          '${fact.source} - ${fact.year}',
          style: const TextStyle(
            color: AppColors.grayText,
            fontSize: AppFontSize.bodyLarge,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildCarousel({required List<Widget> items}) {
    return ExpandableCarousel(
      items: items,
      options: ExpandableCarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1,
        showIndicator: false,
        floatingIndicator: true,
      ),
    );
  }
}

class _SentenceTemplate extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color backgroundColor;
  final TextAlign textAlign;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;

  const _SentenceTemplate({
    required this.title,
    required this.subTitle,
    this.backgroundColor = AppColors.primary,
    this.children = const [],
    this.textAlign = TextAlign.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  static const _spacing = SizedBox(height: AppSpacing.marginS);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.primaryDark
            : backgroundColor.withValues(alpha: 0.2),
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.grayBackgroundColor,
            blurRadius: 2,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingM),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.h3,
            ),
            textAlign: textAlign,
            maxLines: 3,
            overflow: TextOverflow.visible,
          ),
          _spacing,
          Text(
            subTitle,
            style: TextStyle(
              color: context.isDarkMode ? AppColors.lightText : Colors.black38,
              fontSize: AppFontSize.h4,
            ),
            maxLines: 3,
            overflow: TextOverflow.visible,
            textAlign: textAlign,
          ),
          if (children.isNotEmpty) ...[
            _spacing,
            ...children,
          ]
        ],
      ),
    );
  }
}

class _Insight {
  final String title;
  final String desc;
  _Insight({required this.title, required this.desc});
}

class _Quote {
  final String quote;
  final String author;
  const _Quote({required this.quote, required this.author});
}

class _Fact {
  final String title;
  final String desc;
  final String source;
  final int year;
  const _Fact({
    required this.title,
    required this.desc,
    required this.source,
    required this.year,
  });
}
