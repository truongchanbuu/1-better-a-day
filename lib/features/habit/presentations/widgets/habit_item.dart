import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';

class HabitItem extends StatefulWidget {
  final bool isListView;
  const HabitItem({super.key, this.isListView = true});

  @override
  State<HabitItem> createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
  late final ValueNotifier<double> _progressNotifier;

  @override
  void initState() {
    super.initState();
    _progressNotifier = ValueNotifier(30);
  }

  static const _figureTextStyle = TextStyle(
    fontSize: AppFontSize.labelMedium,
    color: AppColors.grayText,
  );
  @override
  Widget build(BuildContext context) {
    return widget.isListView
        ? _buildListViewItem(context)
        : _buildGridViewItem(context);
  }

  Widget _buildListViewItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? AppColors.primaryDark
                : AppColors.grayBackgroundColor,
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
      ),
      margin: const EdgeInsets.all(AppSpacing.marginXS),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.paddingM),
      child: const Column(
        children: [
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: Text(
              'Reading Book',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.h3,
              ),
            ),
            subtitle: _HabitMeasurementLabel(textStyle: _figureTextStyle),
            trailing: _HabitTypeLabel(),
            contentPadding: EdgeInsets.zero,
          ),
          _HabitProgress(),
          Padding(
            padding: EdgeInsets.only(
              bottom: AppSpacing.marginS,
              top: AppSpacing.marginXS,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '30% Complete',
                  style: _figureTextStyle,
                ),
                Text(
                  '10 day streak',
                  style: _figureTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridViewItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        borderRadius:
            const BorderRadius.all(Radius.circular(AppSpacing.radiusS)),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? AppColors.primaryDark
                : AppColors.grayBackgroundColor,
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
      ),
      margin: const EdgeInsets.all(AppSpacing.marginXS),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned(
            right: 3,
            top: 3,
            child: _HabitTypeLabel(),
          ),
          const Positioned(
            left: 3,
            top: 5,
            child: _HabitMeasurementLabel(textStyle: _figureTextStyle),
          ),
          Container(
            padding: const EdgeInsets.only(
              top: AppSpacing.paddingXL,
              bottom: AppSpacing.paddingM,
            ),
            child: DashedCircularProgressBar.aspectRatio(
              aspectRatio: 1,
              maxProgress: 100,
              animation: true,
              progress: _progressNotifier.value,
              backgroundColor: AppColors.grayBackgroundColor,
              foregroundStrokeWidth: 10,
              backgroundStrokeWidth: 10,
              valueNotifier: _progressNotifier,
              child: ValueListenableBuilder(
                valueListenable: _progressNotifier,
                builder: (context, value, child) => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text(
                        'Reading book',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppFontSize.labelMedium,
                        ),
                      ),
                      Text(
                        '${value.toInt()}%',
                        style: _figureTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitTypeLabel extends StatelessWidget {
  const _HabitTypeLabel();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSpacing.circleRadius),
        ),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingS, vertical: AppSpacing.paddingXS),
      child: const Text(
        'Learning',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: AppFontSize.labelMedium,
        ),
      ),
    );
  }
}

class _HabitProgress extends StatelessWidget {
  const _HabitProgress();

  @override
  Widget build(BuildContext context) {
    return AnimatedProgressBar(
      width: MediaQuery.of(context).size.width,
      duration: const Duration(milliseconds: 500),
      value: 0.3,
      color: AppColors.primary,
      backgroundColor: AppColors.grayBackgroundColor,
    );
  }
}

class _HabitMeasurementLabel extends StatelessWidget {
  final TextStyle? textStyle;
  const _HabitMeasurementLabel({this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(
          FontAwesomeIcons.book,
          color: Colors.green,
          size: 20,
        ),
        const SizedBox(width: AppSpacing.marginXS),
        Text(
          '30 min',
          style: textStyle,
        ),
      ],
    );
  }
}
