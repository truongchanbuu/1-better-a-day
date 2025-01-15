import 'dart:async';

import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_common.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/habit/goal_unit.dart';
import '../../../../core/enums/habit/habit_category.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/num_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../notification/presentations/blocs/reminder/reminder_bloc.dart';
import '../../../shared/presentations/widgets/confirm_delete_dialog.dart';
import '../../domain/entities/habit_entity.dart';
import '../../domain/entities/habit_icon.dart';
import '../blocs/crud/habit_crud_bloc.dart';
import '../blocs/habit_history_crud/habit_history_crud_bloc.dart';
import '../pages/habit_detail_page.dart';
import 'crud_habit/edit_template_dialog.dart';
import 'generated_habit.dart';
import 'habit_action_button.dart';

enum HabitAction { skip, complete, nothing }

class HabitItem extends StatefulWidget {
  final HabitEntity habit;
  final bool isListView;

  const HabitItem({
    super.key,
    required this.habit,
    this.isListView = true,
  });

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

  late HabitEntity currentHabit;

  @override
  void initState() {
    super.initState();
    _itemKey = GlobalKey();
    currentHabit = widget.habit;
  }

  @override
  void didUpdateWidget(covariant HabitItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHabit = widget.habit;
  }

  static const _sliderMotion = DrawerMotion();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: _sliderMotion, children: [
        SlidableAction(
          onPressed: _onEditHabit,
          icon: FontAwesomeIcons.penToSquare,
          foregroundColor: AppColors.lightText,
          backgroundColor: Colors.green,
          label: widget.isListView ? S.current.edit_button : null,
        ),
      ]),
      endActionPane: ActionPane(motion: _sliderMotion, children: [
        SlidableAction(
          onPressed: _onDeleteHabit,
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
      onTap: _navigateToHabitDetail,
      onLongPress: () {
        setState(() {
          _isOverlay = !_isOverlay;
        });
      },
      child: Stack(
        children: [
          widget.isListView
              ? _ListViewItem(habit: currentHabit)
              : _GridViewItem(habit: currentHabit),
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

  void _onEditHabit(BuildContext funcContext) {
    final habitCrudBloc = funcContext.read<HabitCrudBloc>();

    SmartDialog.show(
      builder: (ctx) => EditTemplateDialog(
        child: BlocProvider.value(
          value: habitCrudBloc,
          child: BlocListener<HabitCrudBloc, HabitCrudState>(
            listener: (blocCtx, state) async {
              if (state is HabitCrudSucceed) {
                if (state.action == HabitCrudAction.update) {
                  SmartDialog.dismiss();
                  final alertDialog = AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    title: S.current.success_title,
                    desc: S.current.update_success_title,
                    btnOkOnPress: () {},
                  )..show();

                  await Future.delayed(AppCommons.alertShowDuration);
                  alertDialog.dismiss();

                  setState(() {
                    currentHabit = state.habits.first;
                  });
                }
              } else if (state is HabitCrudFailed) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  title: S.current.failure_title,
                  desc: state.errorMessage,
                ).show();
              }
            },
            child: GeneratedHabit(
              habit: currentHabit,
              onEdit: (habit) => habitCrudBloc.add(EditHabit(
                id: currentHabit.habitId,
                updatedHabit: habit,
              )),
            ),
          ),
        ),
      ),
    );
  }

  void _onDeleteHabit(BuildContext ctx) async {
    final habitCrudBloc = context.read<HabitCrudBloc>();
    bool isAllowed = await SmartDialog.show<bool>(
            builder: (innerCtx) => ConfirmDeleteDialog(
                  onDelete: () => SmartDialog.dismiss(result: true),
                  onCancel: () => SmartDialog.dismiss(result: false),
                )) ??
        false;

    if (isAllowed) {
      habitCrudBloc.add(DeleteHabit(currentHabit.habitId));
    }
  }

  void _navigateToHabitDetail() {
    Navigator.push(
      context,
      PageTransition(
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<HabitCrudBloc>()),
            BlocProvider.value(
                value: context.read<HabitHistoryCrudBloc>()
                  ..add(HabitHistoryCrudListByHabitId(currentHabit.habitId))),
            BlocProvider(create: (context) => getIt.get<ReminderBloc>()),
          ],
          child: HabitDetailPage(habit: currentHabit),
        ),
        type: PageTransitionType.leftToRight,
      ),
    );
  }
}

class _ListViewItem extends StatelessWidget {
  final HabitEntity habit;
  const _ListViewItem({required this.habit});

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
      child: Column(
        children: [
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: Text(
              habit.habitTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.h3,
              ),
              maxLines: 5,
            ),
            subtitle: _HabitMeasurementLabel(
              habitIcon: habit.habitIcon,
              category: habit.habitCategory,
              targetValue: habit.habitGoal.targetValue,
              goalUnit: habit.habitGoal.goalUnit.name,
              textStyle: HabitItem.figureTextStyle,
            ),
            trailing: _HabitIconLabel(category: habit.habitCategory),
            contentPadding: EdgeInsets.zero,
          ),
          _HabitProgress(progress: habit.habitProgress),
          Padding(
            padding: const EdgeInsets.only(
              bottom: AppSpacing.marginS,
              top: AppSpacing.marginXS,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.completed_progress(
                      (habit.habitProgress * 100).toStringAsFixedWithoutZero()),
                  style: HabitItem.figureTextStyle,
                ),
                Text(
                  habit.currentStreak.toString(),
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
  final HabitEntity habit;
  const _GridViewItem({required this.habit});

  @override
  State<_GridViewItem> createState() => _GridViewItemState();
}

class _GridViewItemState extends State<_GridViewItem> {
  late final ValueNotifier<double> _progressNotifier;

  @override
  void initState() {
    super.initState();
    _progressNotifier = ValueNotifier(widget.habit.habitProgress);
  }

  @override
  void dispose() {
    _progressNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
      header: Padding(
        padding: const EdgeInsets.all(AppSpacing.marginS),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _HabitMeasurementLabel(
              habitIcon: widget.habit.habitIcon,
              category: widget.habit.habitCategory,
              targetValue: widget.habit.habitGoal.targetValue,
              goalUnit: widget.habit.habitGoal.goalUnit.name,
              textStyle: HabitItem.figureTextStyle,
            ),
            _HabitIconLabel(category: widget.habit.habitCategory),
          ],
        ),
      ),
      footer: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.paddingS),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              widget.habit.habitTitle,
              style: const TextStyle(
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
          radius: 45,
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
  final HabitCategory category;
  const _HabitIconLabel({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: category.color.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSpacing.circleRadius),
        ),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingS, vertical: AppSpacing.paddingXS),
      child: Text(
        category.categoryName,
        style: TextStyle(
          color: category.color,
          fontWeight: FontWeight.bold,
          fontSize: AppFontSize.labelMedium,
        ),
      ),
    );
  }
}

class _HabitProgress extends StatelessWidget {
  final double progress;
  const _HabitProgress({this.progress = 0.0});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      padding: EdgeInsets.zero,
      percent: progress,
      progressColor: AppColors.primary,
      backgroundColor: AppColors.grayBackgroundColor,
    );
  }
}

class _HabitMeasurementLabel extends StatelessWidget {
  final HabitIcon habitIcon;
  final HabitCategory? category;
  final String goalUnit;
  final double targetValue;
  final TextStyle? textStyle;

  const _HabitMeasurementLabel({
    required this.habitIcon,
    this.category,
    required this.goalUnit,
    required this.targetValue,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final unit = GoalUnit.fromString(goalUnit);
    final unitName = unit == GoalUnit.custom ? goalUnit : unit.unitName;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.paddingS),
      child: Row(
        children: <Widget>[
          _buildIcon(),
          const SizedBox(width: AppSpacing.marginXS),
          Text(
            '$targetValue $unitName',
            style: textStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    if (habitIcon.key != PredefinedHabitIconKey.custom.name ||
        category == null) {
      return Iconify(
        habitIcon.icon,
        color: habitIcon.color,
        size: 20,
      );
    }

    return Icon(
      category!.iconData,
      color: category!.color,
      size: 20,
    );
  }
}
