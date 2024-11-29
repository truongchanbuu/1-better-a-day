import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';

class AccountSettingSection extends StatelessWidget {
  final String title;
  final List<Widget> items;
  const AccountSettingSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.marginL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 5),
          Column(children: items)
        ],
      ),
    );
  }
}
