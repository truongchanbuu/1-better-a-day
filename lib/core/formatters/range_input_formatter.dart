import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../generated/l10n.dart';

class RangeInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final int value = int.parse(newValue.text);
    if (value < min || value > max) {
      SmartDialog.showToast(S.current.out_of_range);
      return oldValue;
    }

    return newValue;
  }
}
