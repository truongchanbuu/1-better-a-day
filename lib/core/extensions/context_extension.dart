import 'package:flutter/material.dart';

extension SettingExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}
