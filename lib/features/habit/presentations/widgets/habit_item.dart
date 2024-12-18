import 'dart:async';

import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import 'habit_action_button.dart';

enum HabitAction { skip, complete, nothing }

class HabitItem extends StatefulWidget {
  final bool isListView;
  const HabitItem({super.key, this.isListView = true});

  static const figureTextStyle = TextStyle(
    fontSize: AppFontSize.labelMedium,
    color: AppColors.grayText,
  );

  static const BorderRadius itemBorderRadius =
      BorderRadius.all(Radius.circular(AppSpacing.radiusS));

  @override
  State<HabitItem> createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
  late final GlobalKey _itemKey;

  bool _isOverlay = false;
  HabitAction currentAction = HabitAction.nothing;

  @override
  void initState() {
    super.initState();
    _itemKey = GlobalKey();
  }

  static const _sliderMotion = DrawerMotion();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: _sliderMotion, children: [
        SlidableAction(
          onPressed: (context) {},
          icon: FontAwesomeIcons.penToSquare,
          foregroundColor: AppColors.lightText,
          backgroundColor: Colors.green,
          label: widget.isListView ? S.current.edit_button : null,
        ),
      ]),
      endActionPane: ActionPane(motion: _sliderMotion, children: [
        SlidableAction(
          onPressed: (context) {},
          icon: FontAwesomeIcons.trash,
          foregroundColor: AppColors.lightText,
          backgroundColor: AppColors.error,
          label: widget.isListView ? S.current.delete_button : null,
        ),
      ]),
      child: AnimatedSwitcherPlus.flipY(
        duration: const Duration(milliseconds: 300),
        child: currentAction != HabitAction.nothing
            ? _buildCover()
            : _buildItemWithOverlay(),
      ),
    );
  }

  Widget _buildCover() {
    final RenderBox itemBox = context.findRenderObject() as RenderBox;
    final double width = itemBox.size.width;
    final double height = itemBox.size.height;

    IconData? icon;
    Color? backgroundColor;
    switch (currentAction) {
      case HabitAction.skip:
        icon = Icons.next_plan;
        backgroundColor = AppColors.error;
        break;
      case HabitAction.complete:
        icon = FontAwesomeIcons.check;
        backgroundColor = AppColors.success;
        break;
      case HabitAction.nothing:
        break;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: HabitItem.itemBorderRadius,
      ),
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget _buildItemWithOverlay() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isOverlay = !_isOverlay;
        });
      },
      child: Stack(
        children: [
          widget.isListView ? const _ListViewItem() : const _GridViewItem(),
          if (_isOverlay)
            Positioned.fill(
              child: Container(
                key: _itemKey,
                decoration: BoxDecoration(
                  borderRadius: HabitItem.itemBorderRadius,
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HabitActionButton(
                        icon: FontAwesomeIcons.circleCheck,
                        iconColor: AppColors.success,
                        backgroundColor: Colors.white,
                        onTap: () {
                          setState(() {
                            _isOverlay = false;
                            currentAction = HabitAction.complete;
                          });

                          _toggleHabitStatus();
                        },
                      ),
                      const SizedBox(width: AppSpacing.marginL),
                      HabitActionButton(
                        icon: Icons.next_plan,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.error,
                        onTap: () {
                          setState(() {
                            _isOverlay = false;
                            currentAction = HabitAction.skip;
                          });

                          _toggleHabitStatus();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  void _toggleHabitStatus() {
    Timer(
        const Duration(seconds: 1),
        () => setState(() {
              currentAction = HabitAction.nothing;
            }));
  }
}

class _ListViewItem extends StatelessWidget {
  const _ListViewItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
        borderRadius: HabitItem.itemBorderRadius,
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
            subtitle:
                _HabitMeasurementLabel(textStyle: HabitItem.figureTextStyle),
            trailing: _HabitIconLabel(),
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
                  style: HabitItem.figureTextStyle,
                ),
                Text(
                  '10 day streak',
                  style: HabitItem.figureTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GridViewItem extends StatefulWidget {
  const _GridViewItem();

  @override
  State<_GridViewItem> createState() => _GridViewItemState();
}

class _GridViewItemState extends State<_GridViewItem> {
  late final ValueNotifier<double> _progressNotifier;

  @override
  void initState() {
    super.initState();
    _progressNotifier = ValueNotifier(0.3);
  }

  @override
  void dispose() {
    _progressNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: const Padding(
        padding: EdgeInsets.all(AppSpacing.marginS),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _HabitMeasurementLabel(textStyle: HabitItem.figureTextStyle),
            _HabitIconLabel(),
          ],
        ),
      ),
      footer: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: AppSpacing.paddingS, horizontal: AppSpacing.paddingXS),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              'Reading Book',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.labelLarge,
              ),
            ),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
          borderRadius: HabitItem.itemBorderRadius,
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
        padding: const EdgeInsets.only(
          top: AppSpacing.paddingL,
          bottom: AppSpacing.paddingS,
        ),
        child: CircularPercentIndicator(
          percent: _progressNotifier.value,
          radius: 50,
          lineWidth: 10,
          backgroundColor: AppColors.grayBackgroundColor,
          progressColor: AppColors.primary,
          center: ValueListenableBuilder(
            valueListenable: _progressNotifier,
            builder: (context, value, child) => Center(
              child: Text(
                '${(value * 100).toInt()}%',
                style: HabitItem.figureTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HabitIconLabel extends StatelessWidget {
  const _HabitIconLabel();

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
    return LinearPercentIndicator(
      padding: EdgeInsets.zero,
      percent: 0.3,
      progressColor: AppColors.primary,
      backgroundColor: AppColors.grayBackgroundColor,
    );
  }
}

class _HabitMeasurementLabel extends StatelessWidget {
  final TextStyle? textStyle;
  const _HabitMeasurementLabel({this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.paddingS),
      child: Row(
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
      ),
    );
  }
}
