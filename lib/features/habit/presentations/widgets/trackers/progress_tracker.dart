import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_common.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit/day_status.dart';
import '../../../../../core/enums/habit/goal_type.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/num_extension.dart';
import '../../../../../generated/l10n.dart';
import '../../../../shared/presentations/widgets/icon_with_text.dart';
import '../../../../../core/enums/habit/goal_unit.dart';
import '../../../../shared/presentations/widgets/text_with_circle_border_container.dart';
import '../../blocs/habit_history_crud/habit_history_crud_bloc.dart';

class ProgressTracker extends StatefulWidget {
  final String habitId;
  final GoalType goalType;
  final double currentValue;
  final double targetValue;
  final GoalUnit goalUnit;
  final bool isActionButtonShown;

  const ProgressTracker({
    super.key,
    required this.habitId,
    required this.goalType,
    required this.currentValue,
    required this.targetValue,
    required this.goalUnit,
    this.isActionButtonShown = true,
  });

  @override
  State<ProgressTracker> createState() => _ProgressTrackerState();
}

class _ProgressTrackerState extends State<ProgressTracker> {
  bool _percentMode = false;
  double waterAmount = 250;
  double _currentValue = 0;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.currentValue;
    if (widget.goalUnit == GoalUnit.l) {
      waterAmount = waterAmount / 1000;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildProgressIndicator();
  }

  static const _valueColor = AlwaysStoppedAnimation(AppColors.primary);
  static const _progressBackgroundColor = AppColors.grayBackgroundColor;
  Widget _buildProgressIndicator() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _percentMode = !_percentMode;
          });
        },
        child: BlocListener<HabitHistoryCrudBloc, HabitHistoryCrudState>(
          listener: (context, state) {
            if (state is HabitHistoryCrudSuccess) {
              setState(() {
                _isCompleted = state.histories.isNotEmpty &&
                    (state.histories.first.executionStatus ==
                            DayStatus.completed ||
                        state.histories.first.executionStatus ==
                            DayStatus.skipped);
              });

              if (state.type == HabitHistoryCrudEventType.update ||
                  state.type == HabitHistoryCrudEventType.read) {
                setState(() {
                  _currentValue = state.histories.first.currentValue;
                });
              }
            }
          },
          child: _isCircleProgressBuilt
              ? _buildCircleProgress()
              : _buildLinearProgress(),
        ),
      ),
    );
  }

  Widget _buildLinearProgress() {
    return LiquidLinearProgressIndicator(
      valueColor: _valueColor,
      backgroundColor: _progressBackgroundColor,
      center: _buildProgressCenterText(),
      value: _currentValue,
      borderRadius: AppSpacing.circleRadius,
      borderColor: Colors.transparent,
      borderWidth: 1,
    );
  }

  Widget _buildCircleProgress() {
    return Column(
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: LiquidCircularProgressIndicator(
            valueColor: _valueColor,
            backgroundColor: _progressBackgroundColor,
            value: percentPerTargetValue,
            center: _buildProgressCenterText(),
            direction: Axis.vertical,
          ),
        ),
        if (widget.isActionButtonShown && !_isCompleted) ...[
          const SizedBox(height: AppSpacing.marginL),
          _WaterActionButtons(
            habitId: widget.habitId,
            goalUnit: widget.goalUnit,
            targetValue: widget.targetValue,
            waterAmount: waterAmount,
            onBtnPressed: () {
              context.read<HabitHistoryCrudBloc>().add(AddWaterHabitHistory(
                    habitId: widget.habitId,
                    quantity: waterAmount,
                    targetValue: widget.targetValue,
                    measurementUnit: widget.goalUnit,
                  ));
            },
          ),
        ],
      ],
    );
  }

  Widget _buildProgressCenterText() {
    return Text(
      _getProgressValue(),
      style: TextStyle(
        color: percentPerTargetValue >= 0.5
            ? AppColors.lightText
            : AppColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: AppFontSize.h4,
      ),
    );
  }

  String _getProgressValue() {
    return _percentMode
        ? '${(percentPerTargetValue * 100).toStringAsFixedWithoutZero(1)}%'
        : '${_currentValue.toStringAsFixedWithoutZero(2)} / ${widget.targetValue} ${widget.goalUnit.shortName}';
  }

  double get percentPerTargetValue => _currentValue / widget.targetValue;

  bool get _isCircleProgressBuilt =>
      (widget.goalType == GoalType.count ||
          widget.goalType == GoalType.completion) &&
      (widget.goalUnit == GoalUnit.l || widget.goalUnit == GoalUnit.ml);
}

class _WaterActionButtons extends StatelessWidget {
  final String habitId;
  final GoalUnit goalUnit;
  final double targetValue;
  final VoidCallback onBtnPressed;
  final double waterAmount;

  const _WaterActionButtons({
    required this.habitId,
    required this.targetValue,
    required this.onBtnPressed,
    required this.waterAmount,
    required this.goalUnit,
  });

  @override
  Widget build(BuildContext context) {
    return _buildWaterInteractiveButton(
      onSettingPressed: () => _onSettingPressed(context),
      text: S.current.add_water_button((waterAmount * 1000).toInt()),
      backgroundColor: AppColors.success,
      icon: FontAwesomeIcons.plus,
      onBtnPressed: onBtnPressed,
    );
  }

  static const Color _btnTxtColor = AppColors.lightText;
  static const BorderRadius _btnBorderRadius = BorderRadius.all(
    Radius.circular(AppSpacing.circleRadius),
  );
  static const EdgeInsets _btnPadding = EdgeInsets.symmetric(
    vertical: AppSpacing.paddingM,
    horizontal: AppSpacing.paddingL,
  );
  static const double _btnFontSize = AppFontSize.bodyLarge;
  static const double _btnIconSize = 20;
  static const Alignment _btnAlignment = Alignment.center;
  Widget _buildWaterInteractiveButton({
    required VoidCallback onSettingPressed,
    required String text,
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onBtnPressed,
  }) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) => onSettingPressed(),
            icon: FontAwesomeIcons.gear,
            spacing: 0,
            backgroundColor: AppColors.success,
            borderRadius:
                BorderRadius.all(Radius.circular(AppSpacing.circleRadius)),
          ),
        ],
      ),
      child: Bounce(
        onPressed: onBtnPressed,
        duration: AppCommons.buttonBounceDuration,
        child: IconWithText(
          alignment: _btnAlignment,
          text: text,
          icon: icon,
          iconColor: _btnTxtColor,
          fontColor: _btnTxtColor,
          iconSize: _btnIconSize,
          fontSize: _btnFontSize,
          backgroundColor: backgroundColor,
          borderRadius: _btnBorderRadius,
          padding: _btnPadding,
        ),
      ),
    );
  }

  void _onSettingPressed(BuildContext context) {
    SmartDialog.show(
        tag: 'water_settings',
        builder: (ctx) => BlocProvider.value(
              value: context.read<HabitHistoryCrudBloc>(),
              child: _WaterActionButtonSettings(
                onAmountSubmit: (value) {
                  context.read<HabitHistoryCrudBloc>().add(AddWaterHabitHistory(
                        habitId: habitId,
                        quantity: value,
                        targetValue: targetValue,
                        measurementUnit: goalUnit,
                      ));
                },
                goalUnit: goalUnit,
              ),
            ));
  }
}

class _WaterActionButtonSettings extends StatefulWidget {
  final void Function(double value) onAmountSubmit;
  final GoalUnit goalUnit;

  const _WaterActionButtonSettings({
    required this.onAmountSubmit,
    required this.goalUnit,
  });

  @override
  State<_WaterActionButtonSettings> createState() =>
      _WaterActionButtonSettingsState();
}

class _WaterActionButtonSettingsState
    extends State<_WaterActionButtonSettings> {
  late final TextEditingController _amountController;
  late final List<num> _waterAmounts;

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: '0 ${widget.goalUnit.shortName}');
    _waterAmounts = [300, 400, 500, 1000, 2000].map((e) {
      if (widget.goalUnit == GoalUnit.ml ||
          widget.goalUnit == GoalUnit.glasses) {
        return e;
      } else {
        return e / 1000;
      }
    }).toList();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        margin: const EdgeInsets.all(AppSpacing.marginL),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingL,
          vertical: AppSpacing.paddingM,
        ),
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.darkText : AppColors.lightText,
          borderRadius: BorderRadius.circular(AppSpacing.radiusM),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                hintText: widget.goalUnit.shortName,
                suffixIcon: IconButton(
                  onPressed: () async {
                    SmartDialog.dismiss(tag: 'water_settings');
                    double value = double.tryParse(
                          _amountController.text.split(' ').first,
                        ) ??
                        0;

                    if (widget.goalUnit == GoalUnit.l) {
                      value *= 1000;
                    }

                    widget.onAmountSubmit(value);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.check,
                    color: AppColors.primary,
                  ),
                ),
              ),
              onChanged: (value) {
                _amountController.text = '$value ${widget.goalUnit.shortName}';
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4)
              ],
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: AppSpacing.marginS),
            Text(
              S.current.quick_add_water_button,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.h4,
              ),
            ),
            const SizedBox(height: AppSpacing.marginS),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _waterAmounts
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          _amountController.text =
                              '${e.toStringAsFixedWithoutZero()} ${widget.goalUnit.shortName}';
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: AppSpacing.paddingXS),
                          child: TextWithCircleBorderContainer(
                            title: e.toString(),
                            fontSize: AppFontSize.bodyLarge,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
