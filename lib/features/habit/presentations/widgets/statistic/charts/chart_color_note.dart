import 'package:flutter/material.dart';

import '../../../../../../core/constants/app_spacing.dart';

class ChartColorNote extends StatelessWidget {
  final List<ColorNoteItem> items;

  const ChartColorNote({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      spacing: 10,
      children: items
          .map(
            (item) => _ColorNote(
              color: item.color,
              title: item.title,
            ),
          )
          .toList(),
    );
  }
}

class _ColorNote extends StatelessWidget {
  final Color color;
  final String title;

  const _ColorNote({
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: AppSpacing.marginS),
        Text(title)
      ],
    );
  }
}

class ColorNoteItem {
  final Color color;
  final String title;

  const ColorNoteItem({
    required this.color,
    required this.title,
  });
}
