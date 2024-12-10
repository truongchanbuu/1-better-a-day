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

  /// `Success`
  String get success_title {
    return Intl.message(
      'Success',
      name: 'success_title',
      desc: '',
      args: [],
    );
  }

  /// `Failure`
  String get failure_title {
    return Intl.message(
      'Failure',
      name: 'failure_title',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning_title {
    return Intl.message(
      'Warning',
      name: 'warning_title',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading_title {
    return Intl.message(
      'Loading...',
      name: 'loading_title',
      desc: '',
      args: [],
    );
  }

  /// `Searching...`
  String get searching_title {
    return Intl.message(
      'Searching...',
      name: 'searching_title',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send_button {
    return Intl.message(
      'Send',
      name: 'send_button',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept_button {
    return Intl.message(
      'Accept',
      name: 'accept_button',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel_button {
    return Intl.message(
      'Cancel',
      name: 'cancel_button',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete_button {
    return Intl.message(
      'Delete',
      name: 'delete_button',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit_button {
    return Intl.message(
      'Edit',
      name: 'edit_button',
      desc: '',
      args: [],
    );
  }

  /// `Find`
  String get find_button {
    return Intl.message(
      'Find',
      name: 'find_button',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select_button {
    return Intl.message(
      'Select',
      name: 'select_button',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get start_date {
    return Intl.message(
      'Start Date',
      name: 'start_date',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get end_date {
    return Intl.message(
      'End Date',
      name: 'end_date',
      desc: '',
      args: [],
    );
  }

  /// `Show More`
  String get show_more {
    return Intl.message(
      'Show More',
      name: 'show_more',
      desc: '',
      args: [],
    );
  }

  /// `Show less`
  String get show_less {
    return Intl.message(
      'Show less',
      name: 'show_less',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status_title {
    return Intl.message(
      'Status',
      name: 'status_title',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get select_date_title {
    return Intl.message(
      'Select Date',
      name: 'select_date_title',
      desc: '',
      args: [],
    );
  }

  /// `Select Date Range`
  String get select_range_date_title {
    return Intl.message(
      'Select Date Range',
      name: 'select_range_date_title',
      desc: '',
      args: [],
    );
  }

  /// `The number is out of range`
  String get out_of_range {
    return Intl.message(
      'The number is out of range',
      name: 'out_of_range',
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

  /// `Re-authenticate with Google`
  String get re_auth_with_google {
    return Intl.message(
      'Re-authenticate with Google',
      name: 're_auth_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Re-authenticate with Email`
  String get re_auth_with_email {
    return Intl.message(
      'Re-authenticate with Email',
      name: 're_auth_with_email',
      desc: '',
      args: [],
    );
  }

  /// `Login Failure`
  String get login_failure_title {
    return Intl.message(
      'Login Failure',
      name: 'login_failure_title',
      desc: '',
      args: [],
    );
  }

  /// `Login Success`
  String get login_success_title {
    return Intl.message(
      'Login Success',
      name: 'login_success_title',
      desc: '',
      args: [],
    );
  }

  /// `Update Failure`
  String get update_failure_title {
    return Intl.message(
      'Update Failure',
      name: 'update_failure_title',
      desc: '',
      args: [],
    );
  }

  /// `Update Success`
  String get update_success_title {
    return Intl.message(
      'Update Success',
      name: 'update_success_title',
      desc: '',
      args: [],
    );
  }

  /// `A mail has been sent to your new email`
  String get verify_email_sent {
    return Intl.message(
      'A mail has been sent to your new email',
      name: 'verify_email_sent',
      desc: '',
      args: [],
    );
  }

  /// `Please try again later`
  String get try_again {
    return Intl.message(
      'Please try again later',
      name: 'try_again',
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

  /// `Phone number is not valid`
  String get invalid_phone {
    return Intl.message(
      'Phone number is not valid',
      name: 'invalid_phone',
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

  /// `Please select a valid age`
  String get invalid_age {
    return Intl.message(
      'Please select a valid age',
      name: 'invalid_age',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get passwords_do_not_match {
    return Intl.message(
      'Password does not match',
      name: 'passwords_do_not_match',
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

  /// `All Habits`
  String get all_habits {
    return Intl.message(
      'All Habits',
      name: 'all_habits',
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

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Birthdate`
  String get birth_date {
    return Intl.message(
      'Birthdate',
      name: 'birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personal_info_section {
    return Intl.message(
      'Personal Information',
      name: 'personal_info_section',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age_field {
    return Intl.message(
      'Age',
      name: 'age_field',
      desc: '',
      args: [],
    );
  }

  /// `Display Name`
  String get display_name {
    return Intl.message(
      'Display Name',
      name: 'display_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone_number {
    return Intl.message(
      'Phone',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender_field {
    return Intl.message(
      'Gender',
      name: 'gender_field',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password_field {
    return Intl.message(
      'Password',
      name: 'password_field',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password_field {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password_field',
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

  /// `No Date Selected`
  String get no_date_selected {
    return Intl.message(
      'No Date Selected',
      name: 'no_date_selected',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0{No habits} =1{1 habit} other{{count} habits}}`
  String habits(num count) {
    return Intl.plural(
      count,
      zero: 'No habits',
      one: '1 habit',
      other: '$count habits',
      name: 'habits',
      desc: '',
      args: [count],
    );
  }

  /// `Habit Name`
  String get habit_name {
    return Intl.message(
      'Habit Name',
      name: 'habit_name',
      desc: '',
      args: [],
    );
  }

  /// `Habit Details`
  String get habit_detail {
    return Intl.message(
      'Habit Details',
      name: 'habit_detail',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistic_section {
    return Intl.message(
      'Statistics',
      name: 'statistic_section',
      desc: '',
      args: [],
    );
  }

  /// `Longest Streak`
  String get longest_streak {
    return Intl.message(
      'Longest Streak',
      name: 'longest_streak',
      desc: '',
      args: [],
    );
  }

  /// `Trend`
  String get trend_section {
    return Intl.message(
      'Trend',
      name: 'trend_section',
      desc: '',
      args: [],
    );
  }

  /// `Today Tasks`
  String get today_tasks {
    return Intl.message(
      'Today Tasks',
      name: 'today_tasks',
      desc: '',
      args: [],
    );
  }

  /// `{completedTasks}/{totalTasks}`
  String done_tasks(int completedTasks, int totalTasks) {
    return Intl.message(
      '$completedTasks/$totalTasks',
      name: 'done_tasks',
      desc: 'The done tasks for today',
      args: [completedTasks, totalTasks],
    );
  }

  /// `Achievement`
  String get achievement_done {
    return Intl.message(
      'Achievement',
      name: 'achievement_done',
      desc: '',
      args: [],
    );
  }

  /// `Add Habit`
  String get add_habit {
    return Intl.message(
      'Add Habit',
      name: 'add_habit',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress_section {
    return Intl.message(
      'Progress',
      name: 'progress_section',
      desc: '',
      args: [],
    );
  }

  /// `You are {value}% on your way`
  String on_your_way(Object value) {
    return Intl.message(
      'You are $value% on your way',
      name: 'on_your_way',
      desc: '',
      args: [value],
    );
  }

  /// `Duration`
  String get duration_title {
    return Intl.message(
      'Duration',
      name: 'duration_title',
      desc: '',
      args: [],
    );
  }

  /// `Target`
  String get target_title {
    return Intl.message(
      'Target',
      name: 'target_title',
      desc: '',
      args: [],
    );
  }

  /// `Mark as done`
  String get mark_as_done {
    return Intl.message(
      'Mark as done',
      name: 'mark_as_done',
      desc: '',
      args: [],
    );
  }

  /// `Mark as pause`
  String get mark_as_pause {
    return Intl.message(
      'Mark as pause',
      name: 'mark_as_pause',
      desc: '',
      args: [],
    );
  }

  /// `Tracker`
  String get tracker_section {
    return Intl.message(
      'Tracker',
      name: 'tracker_section',
      desc: '',
      args: [],
    );
  }

  /// `Add 250ML`
  String get add_water_button {
    return Intl.message(
      'Add 250ML',
      name: 'add_water_button',
      desc: '',
      args: [],
    );
  }

  /// `Remove 250ML`
  String get remove_water_button {
    return Intl.message(
      'Remove 250ML',
      name: 'remove_water_button',
      desc: '',
      args: [],
    );
  }

  /// `Start Tracking`
  String get start_tracking {
    return Intl.message(
      'Start Tracking',
      name: 'start_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Pause Tracking`
  String get pause_tracking {
    return Intl.message(
      'Pause Tracking',
      name: 'pause_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Current Distance`
  String get current_distance {
    return Intl.message(
      'Current Distance',
      name: 'current_distance',
      desc: '',
      args: [],
    );
  }

  /// `Total Distance`
  String get total_distance {
    return Intl.message(
      'Total Distance',
      name: 'total_distance',
      desc: '',
      args: [],
    );
  }

  /// `We don't have permission to track your distance`
  String get not_allow_track {
    return Intl.message(
      'We don\'t have permission to track your distance',
      name: 'not_allow_track',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history_section {
    return Intl.message(
      'History',
      name: 'history_section',
      desc: '',
      args: [],
    );
  }

  /// `All Detail History`
  String get all_detail_history {
    return Intl.message(
      'All Detail History',
      name: 'all_detail_history',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get detail_section {
    return Intl.message(
      'Detail',
      name: 'detail_section',
      desc: '',
      args: [],
    );
  }

  /// `Mood`
  String get mood_title {
    return Intl.message(
      'Mood',
      name: 'mood_title',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date_title {
    return Intl.message(
      'Date',
      name: 'date_title',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all_statistic_page {
    return Intl.message(
      'All',
      name: 'all_statistic_page',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active_statistic_page {
    return Intl.message(
      'Active',
      name: 'active_statistic_page',
      desc: '',
      args: [],
    );
  }

  /// `Pause`
  String get pause_statistic_page {
    return Intl.message(
      'Pause',
      name: 'pause_statistic_page',
      desc: '',
      args: [],
    );
  }

  /// `Achieved`
  String get achieved_statistic_page {
    return Intl.message(
      'Achieved',
      name: 'achieved_statistic_page',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get failed_statistic_page {
    return Intl.message(
      'Failed',
      name: 'failed_statistic_page',
      desc: '',
      args: [],
    );
  }

  /// `Total Habit`
  String get total_habit {
    return Intl.message(
      'Total Habit',
      name: 'total_habit',
      desc: '',
      args: [],
    );
  }

  /// `Active Habit`
  String get active_habit {
    return Intl.message(
      'Active Habit',
      name: 'active_habit',
      desc: '',
      args: [],
    );
  }

  /// `Failed Habit`
  String get failed_habit {
    return Intl.message(
      'Failed Habit',
      name: 'failed_habit',
      desc: '',
      args: [],
    );
  }

  /// `Achieved Habit`
  String get achieved_habit {
    return Intl.message(
      'Achieved Habit',
      name: 'achieved_habit',
      desc: '',
      args: [],
    );
  }

  /// `Paused Habit`
  String get paused_habit {
    return Intl.message(
      'Paused Habit',
      name: 'paused_habit',
      desc: '',
      args: [],
    );
  }

  /// `In Progress Habit`
  String get in_progress_habit {
    return Intl.message(
      'In Progress Habit',
      name: 'in_progress_habit',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0 {No achievements} =1 {1 achievement} other {{count} achievements}}`
  String total_achievement(int count) {
    return Intl.plural(
      count,
      zero: 'No achievements',
      one: '1 achievement',
      other: '$count achievements',
      name: 'total_achievement',
      desc: 'Total number of achievements',
      args: [count],
    );
  }

  /// `{count, plural, =0 {No Streak} =1 {1 Streak} other {{count} Streaks}}`
  String total_streak(int count) {
    return Intl.plural(
      count,
      zero: 'No Streak',
      one: '1 Streak',
      other: '$count Streaks',
      name: 'total_streak',
      desc: 'Total number of streaks',
      args: [count],
    );
  }

  /// `Overall Completion Rate`
  String get overall_completion_rate {
    return Intl.message(
      'Overall Completion Rate',
      name: 'overall_completion_rate',
      desc: '',
      args: [],
    );
  }

  /// `Completion Rate`
  String get completion_rate {
    return Intl.message(
      'Completion Rate',
      name: 'completion_rate',
      desc: '',
      args: [],
    );
  }

  /// `Category Distribution`
  String get category_distribution {
    return Intl.message(
      'Category Distribution',
      name: 'category_distribution',
      desc: '',
      args: [],
    );
  }

  /// `Status Distribution`
  String get habit_status_distribution {
    return Intl.message(
      'Status Distribution',
      name: 'habit_status_distribution',
      desc: '',
      args: [],
    );
  }

  /// `Time-Based Progress`
  String get time_based_progress {
    return Intl.message(
      'Time-Based Progress',
      name: 'time_based_progress',
      desc: '',
      args: [],
    );
  }

  /// `Next Page`
  String get next_habits_button {
    return Intl.message(
      'Next Page',
      name: 'next_habits_button',
      desc: '',
      args: [],
    );
  }

  /// `Previous Page`
  String get previous_habits_button {
    return Intl.message(
      'Previous Page',
      name: 'previous_habits_button',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly_process_section {
    return Intl.message(
      'Weekly',
      name: 'weekly_process_section',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly_process_section {
    return Intl.message(
      'Monthly',
      name: 'monthly_process_section',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0 { "Today" } =1 {A day ago} other {Last {count} days}}`
  String last_n_day(int count) {
    return Intl.plural(
      count,
      zero: ' "Today" ',
      one: 'A day ago',
      other: 'Last $count days',
      name: 'last_n_day',
      desc: '',
      args: [count],
    );
  }

  /// `{selection, select, positive {+{percentageValue}% compared to last week} negative {-{percentageValue}% compared to last week} neutral {No change from last week} other {No change from last week}}`
  String change_from_last_week(String selection, int percentageValue) {
    return Intl.select(
      selection,
      {
        'positive': '+$percentageValue% compared to last week',
        'negative': '-$percentageValue% compared to last week',
        'neutral': 'No change from last week',
        'other': 'No change from last week',
      },
      name: 'change_from_last_week',
      desc: '',
      args: [selection, percentageValue],
    );
  }

  /// `{count, plural, =0 {Achieved: 0} =1 {Achieved: 1} other {Achieved: {count}}}`
  String achieved(int count) {
    return Intl.plural(
      count,
      zero: 'Achieved: 0',
      one: 'Achieved: 1',
      other: 'Achieved: $count',
      name: 'achieved',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =0 {Failed: 0} =1 {Failed: 1} other {Failed: {count}}}`
  String failed(int count) {
    return Intl.plural(
      count,
      zero: 'Failed: 0',
      one: 'Failed: 1',
      other: 'Failed: $count',
      name: 'failed',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =0 {Paused: 0} =1 {Paused: 1} other {Paused: {count}}}`
  String paused(int count) {
    return Intl.plural(
      count,
      zero: 'Paused: 0',
      one: 'Paused: 1',
      other: 'Paused: $count',
      name: 'paused',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =0 {In Progress: 0} =1 {In Progress: 1} other {In Progress: {count}}}`
  String in_progress(int count) {
    return Intl.plural(
      count,
      zero: 'In Progress: 0',
      one: 'In Progress: 1',
      other: 'In Progress: $count',
      name: 'in_progress',
      desc: '',
      args: [count],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
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
