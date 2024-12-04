import 'dart:async';

import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

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
          _isOverlay = true;
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
    _progressNotifier = ValueNotifier(30);
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
            _HabitTypeLabel(),
          ],
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
          top: AppSpacing.paddingXXL,
          bottom: AppSpacing.paddingS,
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
                    style: HabitItem.figureTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
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
