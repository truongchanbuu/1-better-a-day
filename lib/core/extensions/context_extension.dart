import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/settings/presentations/bloc/settings_cubit/settings_cubit.dart';

extension SettingExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  Locale get locale =>
      select((SettingsCubit settings) => settings.currentLocale);
}
