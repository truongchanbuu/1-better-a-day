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
import '../../../../../core/enums/habit/goal_type.dart';
import '../../../../../core/enums/tab_type.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/num_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
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
  int waterAmount = 250;
  double _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.currentValue;
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
            print(state);
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
      value: _getAvailableValue,
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
            value: _getAvailableValue,
            center: _buildProgressCenterText(),
            direction: Axis.vertical,
          ),
        ),
        if (widget.isActionButtonShown) ...[
          const SizedBox(height: AppSpacing.marginL),
          _WaterActionButtons(
            waterAmount: waterAmount,
            onBtnPressed: () {
              print(widget.habitId);
              context.read<HabitHistoryCrudBloc>().add(AddWaterHabitHistory(
                    habitId: widget.habitId,
                    quantity: waterAmount,
                    targetValue: widget.targetValue.toInt(),
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
        color: _getAvailableValue >= 0.55
            ? AppColors.lightText
            : AppColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: AppFontSize.h4,
      ),
    );
  }

  String _getProgressValue() {
    return _percentMode
        ? '${(_currentValue / widget.targetValue).toStringAsFixedWithoutZero(1)}%'
        : '${_currentValue.toStringAsFixedWithoutZero(1)} / ${widget.targetValue} ${widget.goalUnit.name.toUpperCaseFirstLetter}';
  }

  bool get _isCircleProgressBuilt =>
      (widget.goalType == GoalType.count ||
          widget.goalType == GoalType.completion) &&
      (widget.goalUnit == GoalUnit.l || widget.goalUnit == GoalUnit.ml);

  double get _getAvailableValue => _currentValue.clamp(0, 1);
}

class _WaterActionButtons extends StatelessWidget {
  final VoidCallback onBtnPressed;
  final int waterAmount;
  const _WaterActionButtons({
    required this.onBtnPressed,
    required this.waterAmount,
  });

  @override
  Widget build(BuildContext context) {
    return _buildWaterInteractiveButton(
      onSettingPressed: _onSettingPressed,
      text: S.current.add_water_button(waterAmount),
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

  void _onSettingPressed() {
    SmartDialog.show(builder: (context) => const _WaterActionButtonSettings());
  }
}

class _WaterActionButtonSettings extends StatefulWidget {
  const _WaterActionButtonSettings();

  @override
  State<_WaterActionButtonSettings> createState() =>
      _WaterActionButtonSettingsState();
}

class _WaterActionButtonSettingsState
    extends State<_WaterActionButtonSettings> {
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: '0');
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
                hintText: 'ml',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.check,
                    color: AppColors.primary,
                  ),
                ),
              ),
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
                children: [300, 400, 500, 1000, 2000]
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          _amountController.text = e.toString();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: AppSpacing.paddingXS,
                          ),
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
