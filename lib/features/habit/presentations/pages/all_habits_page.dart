import 'package:flutter/material.dart';

import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../generated/l10n.dart';

class AllHabitsPage extends StatelessWidget {
  const AllHabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.marginL),
            child: Column(
              children: [
                // General Section
                _SectionContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            S.current.static_section,
                            style: const TextStyle(
                              fontSize: AppFontSize.h1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
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
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(AppSpacing.radiusS),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 5,
            color: Colors.black12,
          ),
        ],
      ),
      child: child,
    );
  }
}
