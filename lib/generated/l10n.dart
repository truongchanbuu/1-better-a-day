// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general_section {
    return Intl.message(
      'General',
      name: 'general_section',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language_tile {
    return Intl.message(
      'Language',
      name: 'language_tile',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english_choice {
    return Intl.message(
      'English',
      name: 'english_choice',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get vietnamese_choice {
    return Intl.message(
      'Vietnamese',
      name: 'vietnamese_choice',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme_tile {
    return Intl.message(
      'Theme',
      name: 'theme_tile',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get dark_theme {
    return Intl.message(
      'Dark Theme',
      name: 'dark_theme',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get light_theme {
    return Intl.message(
      'Light Theme',
      name: 'light_theme',
      desc: '',
      args: [],
    );
  }

  /// `Measurement Unit`
  String get measurement_unit_title {
    return Intl.message(
      'Measurement Unit',
      name: 'measurement_unit_title',
      desc: '',
      args: [],
    );
  }

  /// `Metric Unit`
  String get metric_unit {
    return Intl.message(
      'Metric Unit',
      name: 'metric_unit',
      desc: '',
      args: [],
    );
  }

  /// `Imperial Unit`
  String get imperial_unit {
    return Intl.message(
      'Imperial Unit',
      name: 'imperial_unit',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account_section {
    return Intl.message(
      'Account',
      name: 'account_section',
      desc: '',
      args: [],
    );
  }

  /// `Sign in/Sign up`
  String get authentication_choice {
    return Intl.message(
      'Sign in/Sign up',
      name: 'authentication_choice',
      desc: '',
      args: [],
    );
  }

  /// `Manage Account`
  String get manage_account {
    return Intl.message(
      'Manage Account',
      name: 'manage_account',
      desc: '',
      args: [],
    );
  }

  /// `Additional Information`
  String get app_info_section {
    return Intl.message(
      'Additional Information',
      name: 'app_info_section',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get terms_and_conditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'terms_and_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help_tile {
    return Intl.message(
      'Help',
      name: 'help_tile',
      desc: '',
      args: [],
    );
  }

  /// `Time of day`
  String get time_of_day_section {
    return Intl.message(
      'Time of day',
      name: 'time_of_day_section',
      desc: '',
      args: [],
    );
  }

  /// `Dawn`
  String get dawn_tile {
    return Intl.message(
      'Dawn',
      name: 'dawn_tile',
      desc: '',
      args: [],
    );
  }

  /// `Afternoon`
  String get afternoon_tile {
    return Intl.message(
      'Afternoon',
      name: 'afternoon_tile',
      desc: '',
      args: [],
    );
  }

  /// `Dusk`
  String get dusk_tile {
    return Intl.message(
      'Dusk',
      name: 'dusk_tile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
