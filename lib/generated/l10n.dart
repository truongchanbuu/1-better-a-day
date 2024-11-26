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

  /// `By signing in/signing up, you accept our Terms and Conditions and consent to our Privacy Policy`
  String get term_and_condition_statement {
    return Intl.message(
      'By signing in/signing up, you accept our Terms and Conditions and consent to our Privacy Policy',
      name: 'term_and_condition_statement',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout_button {
    return Intl.message(
      'Log out',
      name: 'logout_button',
      desc: '',
      args: [],
    );
  }

  /// `An reset-password mail will be sent to your email`
  String get recovery_description {
    return Intl.message(
      'An reset-password mail will be sent to your email',
      name: 'recovery_description',
      desc: '',
      args: [],
    );
  }

  /// `Please do not empty the field`
  String get empty_field {
    return Intl.message(
      'Please do not empty the field',
      name: 'empty_field',
      desc: '',
      args: [],
    );
  }

  /// `Please check your information again`
  String get invalid_form {
    return Intl.message(
      'Please check your information again',
      name: 'invalid_form',
      desc: '',
      args: [],
    );
  }

  /// `Password must have at least 6 characters`
  String get invalid_password {
    return Intl.message(
      'Password must have at least 6 characters',
      name: 'invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `Email is not valid or badly formatted.`
  String get invalid_email {
    return Intl.message(
      'Email is not valid or badly formatted.',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `This user has been disabled. Please contact support for help.`
  String get user_disabled {
    return Intl.message(
      'This user has been disabled. Please contact support for help.',
      name: 'user_disabled',
      desc: '',
      args: [],
    );
  }

  /// `An account already exists for that email.`
  String get email_already_in_use {
    return Intl.message(
      'An account already exists for that email.',
      name: 'email_already_in_use',
      desc: '',
      args: [],
    );
  }

  /// `Operation is not allowed. Please contact support.`
  String get operation_not_allowed {
    return Intl.message(
      'Operation is not allowed. Please contact support.',
      name: 'operation_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a stronger password.`
  String get weak_password {
    return Intl.message(
      'Please enter a stronger password.',
      name: 'weak_password',
      desc: '',
      args: [],
    );
  }

  /// `Email is not found, please create an account.`
  String get user_not_found {
    return Intl.message(
      'Email is not found, please create an account.',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password, please try again.`
  String get wrong_password {
    return Intl.message(
      'Incorrect password, please try again.',
      name: 'wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Account exists with different credentials.`
  String get account_exists_with_different_credential {
    return Intl.message(
      'Account exists with different credentials.',
      name: 'account_exists_with_different_credential',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email or password.`
  String get invalid_credential {
    return Intl.message(
      'Invalid email or password.',
      name: 'invalid_credential',
      desc: '',
      args: [],
    );
  }

  /// `The credential verification code received is invalid.`
  String get invalid_verification_code {
    return Intl.message(
      'The credential verification code received is invalid.',
      name: 'invalid_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `The credential verification ID received is invalid.`
  String get invalid_verification_id {
    return Intl.message(
      'The credential verification ID received is invalid.',
      name: 'invalid_verification_id',
      desc: '',
      args: [],
    );
  }

  /// `An unknown exception occurred.`
  String get unknown_exception {
    return Intl.message(
      'An unknown exception occurred.',
      name: 'unknown_exception',
      desc: '',
      args: [],
    );
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
  String get manage_account_choice {
    return Intl.message(
      'Manage Account',
      name: 'manage_account_choice',
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
