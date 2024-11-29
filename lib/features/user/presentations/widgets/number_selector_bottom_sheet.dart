import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../generated/l10n.dart';

class NumberSelectorBottomSheet extends StatefulWidget {
  final int initialAge;
  final void Function(int age)? onSelected;

  const NumberSelectorBottomSheet({
    super.key,
    this.initialAge = 0,
    this.onSelected,
  });

  @override
  State<NumberSelectorBottomSheet> createState() =>
      _NumberSelectorBottomSheetState();
}

class _NumberSelectorBottomSheetState extends State<NumberSelectorBottomSheet> {
  late final TextEditingController _numberInputController;

  int _currentAge = 0;

  @override
  void initState() {
    super.initState();
    _numberInputController = TextEditingController();
    _currentAge = widget.initialAge;
  }

  @override
  void dispose() {
    _numberInputController.dispose();
    super.dispose();
  }

  static const int _minAge = 0;
  static const int _maxAge = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.marginL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              TextFormField(
                controller: _numberInputController,
                onFieldSubmitted: _onAgeSelected,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: '0',
                  suffixIcon: IconButton(
                    onPressed: () =>
                        _onAgeSelected(_numberInputController.text),
                    icon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.search,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
              ),
              NumberPicker(
                value: _currentAge,
                selectedTextStyle: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
                itemWidth: double.infinity,
                minValue: _minAge,
                maxValue: _maxAge,
                onChanged: (value) => _onAgeSelected(value.toString()),
                haptics: true,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => widget.onSelected?.call(_currentAge),
            child: Text(
              S.current.accept_button,
              style: const TextStyle(color: AppColors.lightText),
            ),
          ),
        ],
      ),
    );
  }

  void _onAgeSelected(String age) {
    int selectedAge = int.tryParse(age) ?? _currentAge;

    if (selectedAge < _minAge || selectedAge > _maxAge) {
      SmartDialog.showNotify(
        msg: S.current.invalid_age,
        notifyType: NotifyType.warning,
        alignment: Alignment.bottomCenter,
        useAnimation: true,
        debounce: true,
        animationType: SmartAnimationType.fade,
      );
      return;
    }

    setState(() {
      _currentAge = int.tryParse(age) ?? _currentAge;
    });
  }
}
