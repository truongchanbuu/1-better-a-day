import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_common.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/enums/habit/goal_type.dart';
import '../../../../../core/extensions/num_extension.dart';
import '../../../../../core/extensions/string_extension.dart';
import '../../../../../generated/l10n.dart';
import '../../../../shared/presentations/widgets/icon_with_text.dart';
import '../../../domain/entities/goal_unit.dart';

class ProgressTracker extends StatefulWidget {
  final GoalType goalType;
  final double currentValue;
  final double targetValue;
  final GoalUnit goalUnit;
  final bool isActionButtonShown;

  const ProgressTracker({
    super.key,
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
        child: _isCircleProgressBuilt
            ? _buildCircleProgress()
            : _buildLinearProgress(),
      ),
    );
  }

  Widget _buildLinearProgress() {
    return LiquidLinearProgressIndicator(
      valueColor: _valueColor,
      backgroundColor: _progressBackgroundColor,
      center: _buildProgressCenterText(),
      value: 0.7,
      borderRadius: AppSpacing.circleRadius,
      borderColor: Colors.transparent,
      borderWidth: 1,
    );
  }

  Widget _buildCircleProgress() {
    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 200,
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
          const _WaterActionButtons(),
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
        ? '${(widget.currentValue / widget.targetValue).toStringAsFixedWithoutZero(1)}%'
        : '${widget.currentValue.toStringAsFixedWithoutZero(1)} / ${widget.targetValue} ${widget.goalUnit.name.toUpperCaseFirstLetter}';
  }

  bool get _isCircleProgressBuilt =>
      widget.goalType == GoalType.count &&
      (widget.goalUnit == GoalUnit.l || widget.goalUnit == GoalUnit.ml);

  double get _getAvailableValue => widget.currentValue.clamp(0, 1);
}

class _WaterActionButtons extends StatelessWidget {
  const _WaterActionButtons();

  static const Color _btnTxtColor = AppColors.lightText;
  static const BorderRadius _btnBorderRadius =
      BorderRadius.all(Radius.circular(AppSpacing.circleRadius));
  static const EdgeInsets _btnPadding = EdgeInsets.symmetric(
    vertical: AppSpacing.paddingM,
    horizontal: AppSpacing.paddingL,
  );
  static const double _btnFontSize = AppFontSize.bodyLarge;
  static const double _btnIconSize = 20;
  static const Alignment _btnAlignment = Alignment.center;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bounce(
          onPressed: () {},
          duration: AppCommons.buttonBounceDuration,
          child: IconWithText(
            alignment: _btnAlignment,
            icon: FontAwesomeIcons.plus,
            fontColor: _btnTxtColor,
            iconColor: _btnTxtColor,
            text: S.current.add_water_button,
            iconSize: _btnIconSize,
            fontSize: _btnFontSize,
            backgroundColor: AppColors.success,
            borderRadius: _btnBorderRadius,
            padding: _btnPadding,
          ),
        ),
        const SizedBox(height: AppSpacing.marginS),
        Bounce(
          onPressed: () {},
          duration: AppCommons.buttonBounceDuration,
          child: IconWithText(
            alignment: _btnAlignment,
            icon: FontAwesomeIcons.minus,
            backgroundColor: AppColors.error,
            text: S.current.remove_water_button,
            fontSize: _btnFontSize,
            fontColor: _btnTxtColor,
            iconColor: _btnTxtColor,
            iconSize: _btnIconSize,
            borderRadius: _btnBorderRadius,
            padding: _btnPadding,
          ),
        ),
      ],
    );
  }
}
