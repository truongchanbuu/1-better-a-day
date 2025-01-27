import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';

class NotFoundAndRefresh extends StatelessWidget {
  final String title;
  final VoidCallback onRefresh;
  const NotFoundAndRefresh({
    super.key,
    required this.title,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.grayText,
            fontSize: AppFontSize.h3,
          ),
        ),
        IconButton(
          onPressed: onRefresh,
          icon: const Icon(
            Icons.refresh,
            color: AppColors.grayText,
          ),
        ),
      ],
    );
  }
}
