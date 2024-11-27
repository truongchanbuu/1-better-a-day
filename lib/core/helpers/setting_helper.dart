import 'package:intl/intl.dart';

import '../../generated/l10n.dart';
import '../../injection_container.dart';
import '../constants/app_storage_key.dart';
import 'cached_client.dart';
import 'date_time_helper.dart';

enum LanguageCode { en, vi }

enum MeasurementSystem { metric, imperial }

class SettingHelper {
  static final cachedClient = getIt.get<CacheClient>();

  static bool get isDarkMode =>
      cachedClient.getBool(AppStorageKey.appThemeCachedKey) ?? false;

  static String get langCode {
    final language = cachedClient.getString(AppStorageKey.appLanguageCachedKey);
    return language ?? Intl.getCurrentLocale().split('_').first;
  }

  static List<String> get supportedLanguages => S.delegate.supportedLocales
      .map((locale) => langCodeToFullName(locale.toString()))
      .toList();

  static Map<String, String> get _langMap => {
        'vi': S.current.vietnamese_choice,
        'en': S.current.english_choice,
      };

  static String langCodeToFullName(String langCode) {
    return _langMap[langCode] ?? 'en';
  }

  static String langFullNameToCode(String fullName) {
    return _langMap.entries
        .firstWhere(
          (entry) => entry.value.toLowerCase() == fullName.toLowerCase(),
          orElse: () => _langMap.entries.last,
        )
        .key;
  }

  static String get measurementSystem {
    final measurementSystem =
        cachedClient.getString(AppStorageKey.appMeasurementUnitCachedKey);
    return measurementSystem ?? MeasurementSystem.metric.name;
  }

  static String get dawn =>
      cachedClient.getString(AppStorageKey.appDawnTimeCachedKey) ??
      DateTimeHelper.dawnTimeString;
  static String get afternoon =>
      cachedClient.getString(AppStorageKey.appAfternoonTimeCachedKey) ??
      DateTimeHelper.afternoonTimeString;
  static String get dusk =>
      cachedClient.getString(AppStorageKey.appDuskTimeCachedKey) ??
      DateTimeHelper.duskTimeString;
}
