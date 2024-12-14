import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import 'reward_tab.dart';
import 'share_challenge_tab.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({super.key});

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  final List<GButton> bottomTabs = [
    GButton(icon: FontAwesomeIcons.gift, text: S.current.my_reward_tab),
    GButton(icon: FontAwesomeIcons.rocket, text: S.current.discover_tab),
    GButton(
        icon: FontAwesomeIcons.star, text: S.current.my_custom_challenge_tab),
  ];

  int currentBottomNavbarIndex = 0;

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      const RewardTab(),
      const ShareChallengeTab(tab: ShareTab.discover),
      const ShareChallengeTab(tab: ShareTab.customChallenge)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.isDarkMode
            ? AppColors.primaryDark
            : AppColors.grayBackgroundColor,
        body: SingleChildScrollView(
          child: AnimatedSwitcherPlus.translationRight(
            duration: const Duration(milliseconds: 500),
            child: pages[currentBottomNavbarIndex],
          ),
        ),
        bottomNavigationBar: GNav(
          tabs: bottomTabs,
          haptic: true,
          rippleColor: Colors.grey.shade300,
          hoverColor: Colors.grey.shade300,
          activeColor: AppColors.primary,
          gap: 10,
          onTabChange: (value) =>
              setState(() => currentBottomNavbarIndex = value),
        ),
      ),
    );
  }
}
