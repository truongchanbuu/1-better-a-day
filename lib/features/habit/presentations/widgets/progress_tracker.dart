import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_common.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/enums/goal_type.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';
import '../../domain/enitites/goal_unit.dart';

class ProgressTracker extends StatefulWidget {
  final GoalType goalType;
  final double currentValue;
  final double targetValue;
  final GoalUnit goalUnit;

  const ProgressTracker({
    super.key,
    required this.goalType,
    required this.currentValue,
    required this.targetValue,
    required this.goalUnit,
  });

  @override
  State<ProgressTracker> createState() => _ProgressTrackerState();
}

class _ProgressTrackerState extends State<ProgressTracker> {
  bool _percentMode = false;
  double currentProgress = 0;

  @override
  void initState() {
    super.initState();
    currentProgress = widget.currentValue.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProgressIndicator(),
        if (_isCircleProgressBuilt) ...[
          const SizedBox(height: AppSpacing.marginL),
          _buildActionButtons()
        ],
      ],
    );
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
    );
  }

  Widget _buildCircleProgress() {
    return SizedBox(
      width: 200,
      height: 200,
      child: LiquidCircularProgressIndicator(
        valueColor: _valueColor,
        backgroundColor: _progressBackgroundColor,
        value: currentProgress,
        center: _buildProgressCenterText(),
        direction: Axis.vertical,
      ),
    );
  }

  Widget _buildProgressCenterText() {
    return Text(
      _getProgressValue(),
      style: TextStyle(
        color:
            currentProgress >= 0.55 ? AppColors.lightText : AppColors.primary,
        fontWeight: FontWeight.bold,
        fontSize: AppFontSize.h4,
      ),
    );
  }

  String _getProgressValue() {
    return _percentMode
        ? '${(widget.currentValue / widget.targetValue).toStringAsFixed(1)}%'
        : '${widget.currentValue.toStringAsFixed(1)} / ${widget.targetValue} ${widget.goalUnit.name.toUpperCaseFirstLetter}';
  }

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
  Widget _buildActionButtons() {
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

  bool get _isCircleProgressBuilt =>
      widget.goalType == GoalType.count &&
      (widget.goalUnit == GoalUnit.l || widget.goalUnit == GoalUnit.ml);
}
