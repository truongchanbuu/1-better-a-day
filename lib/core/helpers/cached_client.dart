import 'dart:convert';

import '../../config/log/app_logger.dart';
import '../../injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheClient {
  final SharedPreferencesWithCache prefs;
  const CacheClient(this.prefs);
  static final AppLogger _appLogger = getIt.get<AppLogger>();

  String? getString(String key) {
    try {
      return prefs.getString(key);
    } catch (e) {
      _appLogger.e('Failed to get string for key $key: $e');
      return null;
    }
  }

  Future<void> setString(String key, String value) async {
    try {
      await prefs.setString(key, value);
    } catch (e) {
      _appLogger.e('Failed to set string for key $key: $e');
      rethrow;
    }
  }

  int? getInt(String key) {
    try {
      return prefs.getInt(key);
    } catch (e) {
      _appLogger.e('Failed to get int for key $key: $e');
      return null;
    }
  }

  Future<void> setInt(String key, int value) async {
    try {
      await prefs.setInt(key, value);
    } catch (e) {
      _appLogger.e('Failed to set int for key $key: $e');
      rethrow;
    }
  }

  bool? getBool(String key) {
    try {
      return prefs.getBool(key);
    } catch (e) {
      _appLogger.e('Failed to get bool for key $key: $e');
      return null;
    }
  }

  Future<void> setBool(String key, bool value) async {
    try {
      await prefs.setBool(key, value);
    } catch (e) {
      _appLogger.e('Failed to set bool for key $key: $e');
      rethrow;
    }
  }

  List<String>? getStringList(String key) {
    try {
      return prefs.getStringList(key);
    } catch (e) {
      _appLogger.e('Failed to get string list for key $key: $e');
      return null;
    }
  }

  Future<void> setStringList(String key, List<String> value) async {
    try {
      await prefs.setStringList(key, value);
    } catch (e) {
      _appLogger.e('Failed to set string list for key $key: $e');
      rethrow;
    }
  }

  Map<String, dynamic>? getJson(String key) {
    try {
      final string = prefs.getString(key);
      if (string == null) return null;
      return jsonDecode(string) as Map<String, dynamic>;
    } catch (e) {
      _appLogger.e('Failed to get JSON for key $key: $e');
      return null;
    }
  }

  Future<void> setJson(String key, Map<String, dynamic> value) async {
    try {
      final string = jsonEncode(value);
      await prefs.setString(key, string);
    } catch (e) {
      _appLogger.e('Failed to set JSON for key $key: $e');
      rethrow;
    }
  }

  Future<void> remove(String key) async {
    try {
      await prefs.remove(key);
    } catch (e) {
      _appLogger.e('Failed to remove key $key: $e');
      rethrow;
    }
  }

  Future<void> clear() async {
    try {
      await prefs.clear();
    } catch (e) {
      _appLogger.e('Failed to clear cache: $e');
      rethrow;
    }
  }

  bool containsKey(String key) {
    try {
      return prefs.containsKey(key);
    } catch (e) {
      _appLogger.e('Failed to check key existence for $key: $e');
      return false;
    }
  }

  Set<String> getKeys() {
    try {
      return prefs.keys;
    } catch (e) {
      _appLogger.e('Failed to get keys: $e');
      return {};
    }
  }

  Future<void> reload() async {
    try {
      await prefs.reloadCache();
    } catch (e) {
      _appLogger.e('Failed to reload cache: $e');
      rethrow;
    }
  }
}
