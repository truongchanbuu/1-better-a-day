import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_storage_key.dart';
import '../../../../../core/helpers/cached_client.dart';
import '../../../../../core/helpers/setting_helper.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final CacheClient cacheClient;
  SettingsCubit(this.cacheClient) : super(SettingsInitial());

  Locale get currentLocale => Locale.fromSubtags(languageCode: state.language);
  bool get isDarkMode => state.isDarkMode;

  Future<void> languageChanged(String value) async {
    final langCode = SettingHelper.langFullNameToCode(value);
    await cacheClient.setString(AppStorageKey.appLanguageCachedKey, langCode);
    emit(LanguageChanged(state, langCode));
  }

  Future<void> themeChanged(bool value) async {
    await cacheClient.setBool(AppStorageKey.appThemeCachedKey, value);
    emit(ThemeModeChanged(state, value));
  }

  Future<void> measurementSystemChanged(String value) async {
    await cacheClient.setString(
        AppStorageKey.appMeasurementUnitCachedKey, value);
    emit(MeasurementSystemChanged(state, value));
  }

  Future<void> timeChanged(String key, String value) async {
    await cacheClient.setString(key, value);
    switch (key) {
      case AppStorageKey.appDawnTimeCachedKey:
        emit(TimeChanged(state, dawn: value));
        break;
      case AppStorageKey.appAfternoonTimeCachedKey:
        emit(TimeChanged(state, afternoon: value));
        break;
      case AppStorageKey.appDuskTimeCachedKey:
        emit(TimeChanged(state, dusk: value));
        break;
      case AppStorageKey.appLastReminderTime:
        emit(TimeChanged(state, lastReminderTime: value));
        break;
    }
  }
}
