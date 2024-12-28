import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/formatters/range_input_formatter.dart';
import '../../../../../generated/l10n.dart';

class HabitProgressingStatusSlider extends StatefulWidget {
  final double singleValue;
  final String rangeValues;
  const HabitProgressingStatusSlider({
    super.key,
    this.singleValue = 0.0,
    this.rangeValues = '',
  });

  @override
  State<HabitProgressingStatusSlider> createState() =>
      _HabitProgressingStatusSliderState();
}

class _HabitProgressingStatusSliderState
    extends State<HabitProgressingStatusSlider> {
  late final TextEditingController _singleController;
  late final TextEditingController _startController, _endController;
  late final FocusNode _singleFocus, _startFocus, _endFocus;

  late double _singleValue;
  bool _isRangeMode = false;
  bool _isEditing = false;
  late SfRangeValues _rangeValues;

  @override
  void initState() {
    super.initState();
    _singleValue = widget.singleValue;

    if (widget.rangeValues.isNotEmpty) {
      final values = widget.rangeValues.split('-');
      _rangeValues = SfRangeValues(
        double.tryParse(values[0]) ?? 0,
        double.tryParse(values[1]) ?? 100,
      );
      _isRangeMode = true;
    } else {
      _rangeValues = const SfRangeValues(0.0, 100.0);
    }

    _startController =
        TextEditingController(text: _rangeValues.start.toInt().toString());
    _endController =
        TextEditingController(text: _rangeValues.end.toInt().toString());
    _singleController =
        TextEditingController(text: _singleValue.toInt().toString());
    _singleFocus = FocusNode();
    _startFocus = FocusNode();
    _endFocus = FocusNode();
  }

  @override
  void dispose() {
    _singleController.dispose();
    _singleFocus.dispose();
    _startFocus.dispose();
    _endFocus.dispose();
    super.dispose();
  }

  final _textStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: AppFontSize.h3,
  );
  final _inputDecoration = const InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.all(AppSpacing.paddingS),
  );
  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return GestureDetector(
      onDoubleTap: _saveProgress,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkText : AppColors.lightText,
          borderRadius: BorderRadius.circular(AppSpacing.radiusS),
        ),
        padding: const EdgeInsets.all(AppSpacing.paddingM),
        margin: const EdgeInsets.all(AppSpacing.marginL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildSlider(),
            const SizedBox(height: AppSpacing.marginM),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _isEditing ? _buildInputFields() : _buildDisplayText(),
        MSHCheckbox(
          style: MSHCheckboxStyle.fillScaleColor,
          colorConfig: MSHColorConfig(
            fillColor: (_) => AppColors.primary,
            checkColor: (_) => AppColors.lightText,
          ),
          size: 25,
          value: _isRangeMode,
          onChanged: (value) => setState(() => _isRangeMode = value),
        ),
      ],
    );
  }

  Widget _buildDisplayText() {
    return GestureDetector(
      onDoubleTap: () => setState(() {
        _isEditing = true;
        (_isRangeMode ? _startFocus : _singleFocus).requestFocus();
        if (!_isRangeMode) {
          _singleController.text = _singleValue.toInt().toString();
        } else {
          _startController.text = _rangeValues.start.toInt().toString();
          _endController.text = _rangeValues.end.toInt().toString();
        }
      }),
      child: Row(
        children: [
          Text(
            _isRangeMode
                ? '${_rangeValues.start.toInt()}% - ${_rangeValues.end.toInt()}%'
                : '${_singleValue.toInt()}%',
            style: _textStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildInputFields() {
    if (!_isRangeMode) {
      return _buildTextField(
        focus: _singleFocus,
        controller: _singleController,
        onSubmitted: (_) => _saveProgress(),
        onChanged: (value) =>
            setState(() => _singleValue = double.tryParse(value) ?? 0),
        min: 0,
        max: 100,
      );
    }

    return Row(
      children: [
        _buildTextField(
          controller: _startController,
          focus: _startFocus,
          onSubmitted: (_) => _endFocus.requestFocus(),
          onChanged: (value) => setState(() {
            if (value.isEmpty) return;
            double startValue = double.tryParse(value) ?? 0;

            _rangeValues = _rangeValues.copyWith(start: startValue);
          }),
          min: 0,
          max: _rangeValues.end.toInt(),
        ),
        Text(' - ', style: _textStyle),
        _buildTextField(
          controller: _endController,
          focus: _endFocus,
          onSubmitted: (_) => setState(() => _isEditing = false),
          onChanged: (value) => setState(() {
            if (value.isEmpty) return;
            double endValue = double.tryParse(value) ?? 0;

            _rangeValues = _rangeValues.copyWith(end: endValue);
          }),
          min: _rangeValues.start.toInt(),
          max: 100,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required FocusNode focus,
    TextEditingController? controller,
    required Function(String) onSubmitted,
    required Function(String) onChanged,
    required int min,
    required int max,
  }) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextField(
        controller: controller,
        focusNode: focus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        decoration: _inputDecoration,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          RangeInputFormatter(min: min, max: max),
        ],
        onSubmitted: onSubmitted,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSlider() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _isRangeMode
          ? SfRangeSlider(
              values: _rangeValues,
              min: 0,
              max: 100,
              stepSize: 1,
              interval: 10,
              showLabels: true,
              showDividers: true,
              enableTooltip: true,
              onChanged: (values) => setState(() => _rangeValues = values),
            )
          : SfSlider(
              value: _singleValue,
              min: 0,
              max: 100,
              stepSize: 1,
              interval: 10,
              showLabels: true,
              showDividers: true,
              enableTooltip: true,
              onChanged: (value) => setState(() => _singleValue = value),
            ),
    );
  }

  static final _textButtonStyle =
      TextButton.styleFrom(overlayColor: AppColors.grayText);
  Widget _buildActionButtons() {
    return Row(
      children: [
        const Spacer(),
        TextButton(
          onPressed: SmartDialog.dismiss,
          style: _textButtonStyle,
          child: Text(
            S.current.cancel_button,
            style: const TextStyle(
              color: AppColors.error,
            ),
          ),
        ),
        TextButton(
          onPressed: _onAccept,
          style: _textButtonStyle,
          child: Text(
            S.current.accept_button,
          ),
        ),
      ],
    );
  }

  void _saveProgress() {
    setState(() {
      if (_singleController.text.isNotEmpty) {
        _singleValue = double.parse(_singleController.text);
      }
      _singleController.clear();
      _isEditing = false;
    });
  }

  void _onAccept() {
    if (!_isRangeMode) {
      SmartDialog.dismiss(result: _singleValue.toInt().toString());
    } else {
      SmartDialog.dismiss(
        result: '${_rangeValues.start.toInt()}-${_rangeValues.end.toInt()}',
      );
    }
  }
}
