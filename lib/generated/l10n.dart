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

  /// `No Data`
  String get no_data_title {
    return Intl.message(
      'No Data',
      name: 'no_data_title',
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

  /// `Save`
  String get save_button {
    return Intl.message(
      'Save',
      name: 'save_button',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active_button {
    return Intl.message(
      'Active',
      name: 'active_button',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get inactive_button {
    return Intl.message(
      'Inactive',
      name: 'inactive_button',
      desc: '',
      args: [],
    );
  }

  /// `Go Home`
  String get go_home_button {
    return Intl.message(
      'Go Home',
      name: 'go_home_button',
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

  /// `Less`
  String get less_title {
    return Intl.message(
      'Less',
      name: 'less_title',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more_title {
    return Intl.message(
      'More',
      name: 'more_title',
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

  /// `Day`
  String get day_title {
    return Intl.message(
      'Day',
      name: 'day_title',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month_title {
    return Intl.message(
      'Month',
      name: 'month_title',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year_title {
    return Intl.message(
      'Year',
      name: 'year_title',
      desc: '',
      args: [],
    );
  }

  /// `Total: {count}`
  String total(int count) {
    return Intl.message(
      'Total: $count',
      name: 'total',
      desc: '',
      args: [count],
    );
  }

  /// `friend`
  String get friend_title {
    return Intl.message(
      'friend',
      name: 'friend_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete this?`
  String get delete_title {
    return Intl.message(
      'Are you sure to delete this?',
      name: 'delete_title',
      desc: '',
      args: [],
    );
  }

  /// `This cannot be undone`
  String get delete_warning {
    return Intl.message(
      'This cannot be undone',
      name: 'delete_warning',
      desc: '',
      args: [],
    );
  }

  /// `Not Found`
  String get not_found {
    return Intl.message(
      'Not Found',
      name: 'not_found',
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

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
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

  /// `Challenges`
  String get challenges_screen {
    return Intl.message(
      'Challenges',
      name: 'challenges_screen',
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
  String get additional_information {
    return Intl.message(
      'Additional Information',
      name: 'additional_information',
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

  /// `More Knowledge about habit`
  String get know_more_about_habit {
    return Intl.message(
      'More Knowledge about habit',
      name: 'know_more_about_habit',
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

  /// `Habit Description`
  String get habit_desc {
    return Intl.message(
      'Habit Description',
      name: 'habit_desc',
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

  /// `Habit Category`
  String get habit_category {
    return Intl.message(
      'Habit Category',
      name: 'habit_category',
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

  /// `Current Progress`
  String get current_progress {
    return Intl.message(
      'Current Progress',
      name: 'current_progress',
      desc: '',
      args: [],
    );
  }

  /// `{count}% Completed`
  String completed_progress(Object count) {
    return Intl.message(
      '$count% Completed',
      name: 'completed_progress',
      desc: '',
      args: [count],
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

  /// `You completed this habit today`
  String get daily_completed {
    return Intl.message(
      'You completed this habit today',
      name: 'daily_completed',
      desc: '',
      args: [],
    );
  }

  /// `You delayed this habit today`
  String get daily_paused {
    return Intl.message(
      'You delayed this habit today',
      name: 'daily_paused',
      desc: '',
      args: [],
    );
  }

  /// `Rate & Note`
  String get rate_and_note_completed_habit {
    return Intl.message(
      'Rate & Note',
      name: 'rate_and_note_completed_habit',
      desc: '',
      args: [],
    );
  }

  /// `Pick Icon`
  String get pick_icon {
    return Intl.message(
      'Pick Icon',
      name: 'pick_icon',
      desc: '',
      args: [],
    );
  }

  /// `Pick Color`
  String get pick_color {
    return Intl.message(
      'Pick Color',
      name: 'pick_color',
      desc: '',
      args: [],
    );
  }

  /// `Heath and Sport`
  String get health_and_sport {
    return Intl.message(
      'Heath and Sport',
      name: 'health_and_sport',
      desc: '',
      args: [],
    );
  }

  /// `Education and Improvement`
  String get education_and_improvement {
    return Intl.message(
      'Education and Improvement',
      name: 'education_and_improvement',
      desc: '',
      args: [],
    );
  }

  /// `Mental Health`
  String get mental_health {
    return Intl.message(
      'Mental Health',
      name: 'mental_health',
      desc: '',
      args: [],
    );
  }

  /// `Daily Routine`
  String get daily_routine {
    return Intl.message(
      'Daily Routine',
      name: 'daily_routine',
      desc: '',
      args: [],
    );
  }

  /// `Productivity`
  String get productivity {
    return Intl.message(
      'Productivity',
      name: 'productivity',
      desc: '',
      args: [],
    );
  }

  /// `Social and Family`
  String get society_and_family {
    return Intl.message(
      'Social and Family',
      name: 'society_and_family',
      desc: '',
      args: [],
    );
  }

  /// `Failed`
  String get status_failed {
    return Intl.message(
      'Failed',
      name: 'status_failed',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get status_in_progress {
    return Intl.message(
      'In Progress',
      name: 'status_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Paused`
  String get status_paused {
    return Intl.message(
      'Paused',
      name: 'status_paused',
      desc: '',
      args: [],
    );
  }

  /// `Skipped`
  String get status_skipped {
    return Intl.message(
      'Skipped',
      name: 'status_skipped',
      desc: '',
      args: [],
    );
  }

  /// `Achieved`
  String get status_achieved {
    return Intl.message(
      'Achieved',
      name: 'status_achieved',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get status_pending {
    return Intl.message(
      'Pending',
      name: 'status_pending',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get status_unknown {
    return Intl.message(
      'Unknown',
      name: 'status_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get status_completed {
    return Intl.message(
      'Completed',
      name: 'status_completed',
      desc: '',
      args: [],
    );
  }

  /// `Lack of Time`
  String get habit_failure_reason_lack_of_time {
    return Intl.message(
      'Lack of Time',
      name: 'habit_failure_reason_lack_of_time',
      desc: '',
      args: [],
    );
  }

  /// `Lack of Motivation`
  String get habit_failure_reason_lack_of_motivation {
    return Intl.message(
      'Lack of Motivation',
      name: 'habit_failure_reason_lack_of_motivation',
      desc: '',
      args: [],
    );
  }

  /// `Health Issues`
  String get habit_failure_reason_health_issues {
    return Intl.message(
      'Health Issues',
      name: 'habit_failure_reason_health_issues',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected Events`
  String get habit_failure_reason_unexpected_events {
    return Intl.message(
      'Unexpected Events',
      name: 'habit_failure_reason_unexpected_events',
      desc: '',
      args: [],
    );
  }

  /// `Forgetfulness`
  String get habit_failure_reason_forgetfulness {
    return Intl.message(
      'Forgetfulness',
      name: 'habit_failure_reason_forgetfulness',
      desc: '',
      args: [],
    );
  }

  /// `Too Difficult`
  String get habit_failure_reason_too_difficult {
    return Intl.message(
      'Too Difficult',
      name: 'habit_failure_reason_too_difficult',
      desc: '',
      args: [],
    );
  }

  /// `Lack of Resources`
  String get habit_failure_reason_lack_of_resources {
    return Intl.message(
      'Lack of Resources',
      name: 'habit_failure_reason_lack_of_resources',
      desc: '',
      args: [],
    );
  }

  /// `Procrastination`
  String get habit_failure_reason_procrastination {
    return Intl.message(
      'Procrastination',
      name: 'habit_failure_reason_procrastination',
      desc: '',
      args: [],
    );
  }

  /// `External Distractions`
  String get habit_failure_reason_external_distractions {
    return Intl.message(
      'External Distractions',
      name: 'habit_failure_reason_external_distractions',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get habit_failure_reason_other {
    return Intl.message(
      'Other',
      name: 'habit_failure_reason_other',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get habit_failure_reason_unknown {
    return Intl.message(
      'Unknown',
      name: 'habit_failure_reason_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Lack of Time`
  String get habit_pause_reason_lack_of_time {
    return Intl.message(
      'Lack of Time',
      name: 'habit_pause_reason_lack_of_time',
      desc: '',
      args: [],
    );
  }

  /// `Lack of Motivation`
  String get habit_pause_reason_lack_of_motivation {
    return Intl.message(
      'Lack of Motivation',
      name: 'habit_pause_reason_lack_of_motivation',
      desc: '',
      args: [],
    );
  }

  /// `Health Issues`
  String get habit_pause_reason_health_issues {
    return Intl.message(
      'Health Issues',
      name: 'habit_pause_reason_health_issues',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected Events`
  String get habit_pause_reason_unexpected_events {
    return Intl.message(
      'Unexpected Events',
      name: 'habit_pause_reason_unexpected_events',
      desc: '',
      args: [],
    );
  }

  /// `Need for Rest`
  String get habit_pause_reason_need_for_rest {
    return Intl.message(
      'Need for Rest',
      name: 'habit_pause_reason_need_for_rest',
      desc: '',
      args: [],
    );
  }

  /// `Reassessment`
  String get habit_pause_reason_reassessment {
    return Intl.message(
      'Reassessment',
      name: 'habit_pause_reason_reassessment',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get habit_pause_reason_other {
    return Intl.message(
      'Other',
      name: 'habit_pause_reason_other',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get habit_pause_reason_unknown {
    return Intl.message(
      'Unknown',
      name: 'habit_pause_reason_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get habit_category_health {
    return Intl.message(
      'Health',
      name: 'habit_category_health',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get habit_category_education {
    return Intl.message(
      'Education',
      name: 'habit_category_education',
      desc: '',
      args: [],
    );
  }

  /// `Productivity`
  String get habit_category_productivity {
    return Intl.message(
      'Productivity',
      name: 'habit_category_productivity',
      desc: '',
      args: [],
    );
  }

  /// `Mindfulness`
  String get habit_category_mindfulness {
    return Intl.message(
      'Mindfulness',
      name: 'habit_category_mindfulness',
      desc: '',
      args: [],
    );
  }

  /// `Lifestyle`
  String get habit_category_lifestyle {
    return Intl.message(
      'Lifestyle',
      name: 'habit_category_lifestyle',
      desc: '',
      args: [],
    );
  }

  /// `Nutrition`
  String get habit_category_nutrition {
    return Intl.message(
      'Nutrition',
      name: 'habit_category_nutrition',
      desc: '',
      args: [],
    );
  }

  /// `Social`
  String get habit_category_social {
    return Intl.message(
      'Social',
      name: 'habit_category_social',
      desc: '',
      args: [],
    );
  }

  /// `Finance`
  String get habit_category_finance {
    return Intl.message(
      'Finance',
      name: 'habit_category_finance',
      desc: '',
      args: [],
    );
  }

  /// `Creativity`
  String get habit_category_creativity {
    return Intl.message(
      'Creativity',
      name: 'habit_category_creativity',
      desc: '',
      args: [],
    );
  }

  /// `Environmental`
  String get habit_category_environmental {
    return Intl.message(
      'Environmental',
      name: 'habit_category_environmental',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get habit_category_unknown {
    return Intl.message(
      'Unknown',
      name: 'habit_category_unknown',
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

  /// `Add {count}ML`
  String add_water_button(Object count) {
    return Intl.message(
      'Add ${count}ML',
      name: 'add_water_button',
      desc: '',
      args: [count],
    );
  }

  /// `Remove {count}ssucML`
  String remove_water_button(Object count) {
    return Intl.message(
      'Remove ${count}ssucML',
      name: 'remove_water_button',
      desc: '',
      args: [count],
    );
  }

  /// `Quick Add`
  String get quick_add_water_button {
    return Intl.message(
      'Quick Add',
      name: 'quick_add_water_button',
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

  /// `Great`
  String get mood_great {
    return Intl.message(
      'Great',
      name: 'mood_great',
      desc: '',
      args: [],
    );
  }

  /// `Good`
  String get mood_good {
    return Intl.message(
      'Good',
      name: 'mood_good',
      desc: '',
      args: [],
    );
  }

  /// `Neutral`
  String get mood_neutral {
    return Intl.message(
      'Neutral',
      name: 'mood_neutral',
      desc: '',
      args: [],
    );
  }

  /// `Bad`
  String get mood_bad {
    return Intl.message(
      'Bad',
      name: 'mood_bad',
      desc: '',
      args: [],
    );
  }

  /// `Terrible`
  String get mood_terrible {
    return Intl.message(
      'Terrible',
      name: 'mood_terrible',
      desc: '',
      args: [],
    );
  }

  /// `No history found`
  String get history_empty {
    return Intl.message(
      'No history found',
      name: 'history_empty',
      desc: '',
      args: [],
    );
  }

  /// `Cannot get any history`
  String get cannot_get_any_history {
    return Intl.message(
      'Cannot get any history',
      name: 'cannot_get_any_history',
      desc: '',
      args: [],
    );
  }

  /// `Cannot store history`
  String get cannot_store_history {
    return Intl.message(
      'Cannot store history',
      name: 'cannot_store_history',
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

  /// `Miss`
  String get miss_title {
    return Intl.message(
      'Miss',
      name: 'miss_title',
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

  /// `Same Habit`
  String get same_type_habit {
    return Intl.message(
      'Same Habit',
      name: 'same_type_habit',
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

  /// `{count, plural, =0 {No Achievements} =1 {1 Achievement} other {{count} Achievements}}`
  String total_achievement(int count) {
    return Intl.plural(
      count,
      zero: 'No Achievements',
      one: '1 Achievement',
      other: '$count Achievements',
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

  /// `Total Pause Time`
  String get total_paused_time {
    return Intl.message(
      'Total Pause Time',
      name: 'total_paused_time',
      desc: '',
      args: [],
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

  /// `Average Time`
  String get avg_time {
    return Intl.message(
      'Average Time',
      name: 'avg_time',
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

  /// `Failed Rate`
  String get failed_rate {
    return Intl.message(
      'Failed Rate',
      name: 'failed_rate',
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

  /// `Category Based Completion`
  String get category_based_completion_rate {
    return Intl.message(
      'Category Based Completion',
      name: 'category_based_completion_rate',
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

  /// `Progress: {count}/{total} {time}`
  String overall_progress(int count, int total, String time) {
    return Intl.message(
      'Progress: $count/$total $time',
      name: 'overall_progress',
      desc:
          'String displaying progress with a time unit. Defaults to \'day\' if \'time\' is not provided.',
      args: [count, total, time],
    );
  }

  /// `Show all figures`
  String get show_all_figure_button {
    return Intl.message(
      'Show all figures',
      name: 'show_all_figure_button',
      desc: '',
      args: [],
    );
  }

  /// `Most Reason`
  String get most_reason {
    return Intl.message(
      'Most Reason',
      name: 'most_reason',
      desc: '',
      args: [],
    );
  }

  /// `Best Time`
  String get best_time {
    return Intl.message(
      'Best Time',
      name: 'best_time',
      desc: '',
      args: [],
    );
  }

  /// `Daily Time Slots Map`
  String get time_slot_heatmap {
    return Intl.message(
      'Daily Time Slots Map',
      name: 'time_slot_heatmap',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Day Performance`
  String get habit_day_performance {
    return Intl.message(
      'Weekly Day Performance',
      name: 'habit_day_performance',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Mood`
  String get weekly_mood {
    return Intl.message(
      'Weekly Mood',
      name: 'weekly_mood',
      desc: '',
      args: [],
    );
  }

  /// `Most Mood`
  String get most_mood {
    return Intl.message(
      'Most Mood',
      name: 'most_mood',
      desc: '',
      args: [],
    );
  }

  /// `Mood Distribution`
  String get mood_distribution {
    return Intl.message(
      'Mood Distribution',
      name: 'mood_distribution',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder_section {
    return Intl.message(
      'Reminder',
      name: 'reminder_section',
      desc: '',
      args: [],
    );
  }

  /// `Add reminder`
  String get add_reminder {
    return Intl.message(
      'Add reminder',
      name: 'add_reminder',
      desc: '',
      args: [],
    );
  }

  /// `Keep your habits on track!`
  String get notification_screen_title {
    return Intl.message(
      'Keep your habits on track!',
      name: 'notification_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `Notify at:`
  String get notify_at {
    return Intl.message(
      'Notify at:',
      name: 'notify_at',
      desc: '',
      args: [],
    );
  }

  /// `Greetings`
  String get default_greeting {
    return Intl.message(
      'Greetings',
      name: 'default_greeting',
      desc: '',
      args: [],
    );
  }

  /// `Good morning`
  String get morning_greeting {
    return Intl.message(
      'Good morning',
      name: 'morning_greeting',
      desc: '',
      args: [],
    );
  }

  /// `Good Afternoon`
  String get afternoon_greeting {
    return Intl.message(
      'Good Afternoon',
      name: 'afternoon_greeting',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening`
  String get evening_greeting {
    return Intl.message(
      'Good Evening',
      name: 'evening_greeting',
      desc: '',
      args: [],
    );
  }

  /// `Good night`
  String get night_greeting {
    return Intl.message(
      'Good night',
      name: 'night_greeting',
      desc: '',
      args: [],
    );
  }

  /// `A habit cannot be tossed out the window; it must be coaxed down the stairs a step at a time`
  String get habit_quote_1 {
    return Intl.message(
      'A habit cannot be tossed out the window; it must be coaxed down the stairs a step at a time',
      name: 'habit_quote_1',
      desc: '',
      args: [],
    );
  }

  /// `And once you understand that habits can change, you have the freedom and the responsibility to remake them`
  String get habit_quote_2 {
    return Intl.message(
      'And once you understand that habits can change, you have the freedom and the responsibility to remake them',
      name: 'habit_quote_2',
      desc: '',
      args: [],
    );
  }

  /// `Discipline is choosing between what you want now and what you want most`
  String get habit_quote_3 {
    return Intl.message(
      'Discipline is choosing between what you want now and what you want most',
      name: 'habit_quote_3',
      desc: '',
      args: [],
    );
  }

  /// `Drop by drop is the water pot filled`
  String get habit_quote_4 {
    return Intl.message(
      'Drop by drop is the water pot filled',
      name: 'habit_quote_4',
      desc: '',
      args: [],
    );
  }

  /// `Success is the sum of small efforts repeated day in and day out`
  String get habit_quote_5 {
    return Intl.message(
      'Success is the sum of small efforts repeated day in and day out',
      name: 'habit_quote_5',
      desc: '',
      args: [],
    );
  }

  /// `Compound Effect`
  String get compound_effect {
    return Intl.message(
      'Compound Effect',
      name: 'compound_effect',
      desc: '',
      args: [],
    );
  }

  /// `Improving 1% each day will make you 37 times better after a year.`
  String get compound_effect_description {
    return Intl.message(
      'Improving 1% each day will make you 37 times better after a year.',
      name: 'compound_effect_description',
      desc: '',
      args: [],
    );
  }

  /// `Pareto Principle`
  String get pareto_principle {
    return Intl.message(
      'Pareto Principle',
      name: 'pareto_principle',
      desc: '',
      args: [],
    );
  }

  /// `20% of the right habits will bring 80% of the positive results.`
  String get pareto_principle_description {
    return Intl.message(
      '20% of the right habits will bring 80% of the positive results.',
      name: 'pareto_principle_description',
      desc: '',
      args: [],
    );
  }

  /// `Power of Timing`
  String get power_of_timing {
    return Intl.message(
      'Power of Timing',
      name: 'power_of_timing',
      desc: '',
      args: [],
    );
  }

  /// `Performing a habit at the same time each day increases the likelihood of maintaining it by 90%.`
  String get power_of_timing_description {
    return Intl.message(
      'Performing a habit at the same time each day increases the likelihood of maintaining it by 90%.',
      name: 'power_of_timing_description',
      desc: '',
      args: [],
    );
  }

  /// `We are what we repeatedly do. Excellence, then, is not an act, but a habit.`
  String get quote_aristotle {
    return Intl.message(
      'We are what we repeatedly do. Excellence, then, is not an act, but a habit.',
      name: 'quote_aristotle',
      desc: '',
      args: [],
    );
  }

  /// `Aristotle`
  String get author_aristotle {
    return Intl.message(
      'Aristotle',
      name: 'author_aristotle',
      desc: '',
      args: [],
    );
  }

  /// `Small habits make a big difference.`
  String get quote_james_clear {
    return Intl.message(
      'Small habits make a big difference.',
      name: 'quote_james_clear',
      desc: '',
      args: [],
    );
  }

  /// `James Clear`
  String get author_james_clear {
    return Intl.message(
      'James Clear',
      name: 'author_james_clear',
      desc: '',
      args: [],
    );
  }

  /// `Success is not about perfection. It's about consistency.`
  String get quote_dwayne_johnson {
    return Intl.message(
      'Success is not about perfection. It\'s about consistency.',
      name: 'quote_dwayne_johnson',
      desc: '',
      args: [],
    );
  }

  /// `Dwayne Johnson`
  String get author_dwayne_johnson {
    return Intl.message(
      'Dwayne Johnson',
      name: 'author_dwayne_johnson',
      desc: '',
      args: [],
    );
  }

  /// `Science`
  String get science_tab {
    return Intl.message(
      'Science',
      name: 'science_tab',
      desc: '',
      args: [],
    );
  }

  /// `Psychology`
  String get psy_tab {
    return Intl.message(
      'Psychology',
      name: 'psy_tab',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistic_info_tab {
    return Intl.message(
      'Statistics',
      name: 'statistic_info_tab',
      desc: '',
      args: [],
    );
  }

  /// `21-Day Rule`
  String get science_21_day_rule {
    return Intl.message(
      '21-Day Rule',
      name: 'science_21_day_rule',
      desc: '',
      args: [],
    );
  }

  /// `Research shows it actually takes 66 days to form an automatic habit, not 21 days as commonly believed.`
  String get science_21_day_rule_description {
    return Intl.message(
      'Research shows it actually takes 66 days to form an automatic habit, not 21 days as commonly believed.',
      name: 'science_21_day_rule_description',
      desc: '',
      args: [],
    );
  }

  /// `Neuroplasticity`
  String get science_neuroplasticity {
    return Intl.message(
      'Neuroplasticity',
      name: 'science_neuroplasticity',
      desc: '',
      args: [],
    );
  }

  /// `When you repeat a behavior, the brain creates new neural connections, making the behavior more natural over time.`
  String get science_neuroplasticity_description {
    return Intl.message(
      'When you repeat a behavior, the brain creates new neural connections, making the behavior more natural over time.',
      name: 'science_neuroplasticity_description',
      desc: '',
      args: [],
    );
  }

  /// `Dopamine and Habits`
  String get science_dopamine_habits {
    return Intl.message(
      'Dopamine and Habits',
      name: 'science_dopamine_habits',
      desc: '',
      args: [],
    );
  }

  /// `The brain releases dopamine not only when achieving a goal but also when recognizing cues leading to rewards.`
  String get science_dopamine_habits_description {
    return Intl.message(
      'The brain releases dopamine not only when achieving a goal but also when recognizing cues leading to rewards.',
      name: 'science_dopamine_habits_description',
      desc: '',
      args: [],
    );
  }

  /// `Cue-Routine-Reward`
  String get psychology_cue_routine_reward {
    return Intl.message(
      'Cue-Routine-Reward',
      name: 'psychology_cue_routine_reward',
      desc: '',
      args: [],
    );
  }

  /// `Habits are formed by three elements: Cue, Routine, and Reward.`
  String get psychology_cue_routine_reward_description {
    return Intl.message(
      'Habits are formed by three elements: Cue, Routine, and Reward.',
      name: 'psychology_cue_routine_reward_description',
      desc: '',
      args: [],
    );
  }

  /// `Implementation Intentions`
  String get psychology_implementation_intentions {
    return Intl.message(
      'Implementation Intentions',
      name: 'psychology_implementation_intentions',
      desc: '',
      args: [],
    );
  }

  /// `Specifying 'when' and 'where' you will perform a habit can increase success rates by 2-3 times.`
  String get psychology_implementation_intentions_description {
    return Intl.message(
      'Specifying \'when\' and \'where\' you will perform a habit can increase success rates by 2-3 times.',
      name: 'psychology_implementation_intentions_description',
      desc: '',
      args: [],
    );
  }

  /// `Success Rate`
  String get statistics_success_rate {
    return Intl.message(
      'Success Rate',
      name: 'statistics_success_rate',
      desc: '',
      args: [],
    );
  }

  /// `43% of our daily actions are performed unconsciously due to habits.`
  String get statistics_success_rate_description {
    return Intl.message(
      '43% of our daily actions are performed unconsciously due to habits.',
      name: 'statistics_success_rate_description',
      desc: '',
      args: [],
    );
  }

  /// `Habit Formation Time`
  String get statistics_habit_formation_time {
    return Intl.message(
      'Habit Formation Time',
      name: 'statistics_habit_formation_time',
      desc: '',
      args: [],
    );
  }

  /// `The time to form a habit can range from 18 to 254 days depending on complexity.`
  String get statistics_habit_formation_time_description {
    return Intl.message(
      'The time to form a habit can range from 18 to 254 days depending on complexity.',
      name: 'statistics_habit_formation_time_description',
      desc: '',
      args: [],
    );
  }

  /// `Discover`
  String get discover_tab {
    return Intl.message(
      'Discover',
      name: 'discover_tab',
      desc: '',
      args: [],
    );
  }

  /// `My Custom Challenges`
  String get my_custom_challenge_tab {
    return Intl.message(
      'My Custom Challenges',
      name: 'my_custom_challenge_tab',
      desc: '',
      args: [],
    );
  }

  /// `My Rewards`
  String get my_reward_tab {
    return Intl.message(
      'My Rewards',
      name: 'my_reward_tab',
      desc: '',
      args: [],
    );
  }

  /// `Search for community challenge...`
  String get search_community_challenge {
    return Intl.message(
      'Search for community challenge...',
      name: 'search_community_challenge',
      desc: '',
      args: [],
    );
  }

  /// `Search my challenges...`
  String get search_my_custom_challenge {
    return Intl.message(
      'Search my challenges...',
      name: 'search_my_custom_challenge',
      desc: '',
      args: [],
    );
  }

  /// `Start this Challenge`
  String get attendance_button {
    return Intl.message(
      'Start this Challenge',
      name: 'attendance_button',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0 {No participant} =1 {1 participant} other {{count} participants}}`
  String participant(int count) {
    return Intl.plural(
      count,
      zero: 'No participant',
      one: '1 participant',
      other: '$count participants',
      name: 'participant',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =0 {No completion} =1 {1 completion} other {{count} completions}}`
  String completion(int count) {
    return Intl.plural(
      count,
      zero: 'No completion',
      one: '1 completion',
      other: '$count completions',
      name: 'completion',
      desc: '',
      args: [count],
    );
  }

  /// `Create your own challenge`
  String get create_new_challenge {
    return Intl.message(
      'Create your own challenge',
      name: 'create_new_challenge',
      desc: '',
      args: [],
    );
  }

  /// `Search your achievements...`
  String get search_achievement {
    return Intl.message(
      'Search your achievements...',
      name: 'search_achievement',
      desc: '',
      args: [],
    );
  }

  /// `All Achievements`
  String get all_achievements_tab {
    return Intl.message(
      'All Achievements',
      name: 'all_achievements_tab',
      desc: '',
      args: [],
    );
  }

  /// `Collections`
  String get collection_tab {
    return Intl.message(
      'Collections',
      name: 'collection_tab',
      desc: '',
      args: [],
    );
  }

  /// `Personal Achievements`
  String get personal_achievements {
    return Intl.message(
      'Personal Achievements',
      name: 'personal_achievements',
      desc: '',
      args: [],
    );
  }

  /// `Community Challenges`
  String get community_challenges {
    return Intl.message(
      'Community Challenges',
      name: 'community_challenges',
      desc: '',
      args: [],
    );
  }

  /// `Get some useful pre-set habit`
  String get get_preset_habit_option {
    return Intl.message(
      'Get some useful pre-set habit',
      name: 'get_preset_habit_option',
      desc: '',
      args: [],
    );
  }

  /// `Create habit with few words`
  String get add_habit_with_few_words_option {
    return Intl.message(
      'Create habit with few words',
      name: 'add_habit_with_few_words_option',
      desc: '',
      args: [],
    );
  }

  /// `Customize your own habit`
  String get add_your_own_habit {
    return Intl.message(
      'Customize your own habit',
      name: 'add_your_own_habit',
      desc: '',
      args: [],
    );
  }

  /// `Habit Description (The purpose and benefits of the habit)`
  String get add_habit_desc {
    return Intl.message(
      'Habit Description (The purpose and benefits of the habit)',
      name: 'add_habit_desc',
      desc: '',
      args: [],
    );
  }

  /// `Habit Goal`
  String get habit_goal {
    return Intl.message(
      'Habit Goal',
      name: 'habit_goal',
      desc: '',
      args: [],
    );
  }

  /// `Specify`
  String get specify_title {
    return Intl.message(
      'Specify',
      name: 'specify_title',
      desc: '',
      args: [],
    );
  }

  /// `Measurable`
  String get measurable_title {
    return Intl.message(
      'Measurable',
      name: 'measurable_title',
      desc: '',
      args: [],
    );
  }

  /// `Achievable`
  String get achievable_title {
    return Intl.message(
      'Achievable',
      name: 'achievable_title',
      desc: '',
      args: [],
    );
  }

  /// `Relevant`
  String get relevant_title {
    return Intl.message(
      'Relevant',
      name: 'relevant_title',
      desc: '',
      args: [],
    );
  }

  /// `Time Bound`
  String get time_bound_title {
    return Intl.message(
      'Time Bound',
      name: 'time_bound_title',
      desc: '',
      args: [],
    );
  }

  /// `Clear and well-defined goal that answers who, what, where, when, and why.`
  String get specify_desc {
    return Intl.message(
      'Clear and well-defined goal that answers who, what, where, when, and why.',
      name: 'specify_desc',
      desc: '',
      args: [],
    );
  }

  /// `Include concrete numbers or actions that can be tracked and evaluated.`
  String get measurement_desc {
    return Intl.message(
      'Include concrete numbers or actions that can be tracked and evaluated.',
      name: 'measurement_desc',
      desc: '',
      args: [],
    );
  }

  /// `Realistic and attainable within your current resources and constraints.`
  String get achievable_desc {
    return Intl.message(
      'Realistic and attainable within your current resources and constraints.',
      name: 'achievable_desc',
      desc: '',
      args: [],
    );
  }

  /// `Aligned with your broader goals and current life situation.`
  String get relevant_desc {
    return Intl.message(
      'Aligned with your broader goals and current life situation.',
      name: 'relevant_desc',
      desc: '',
      args: [],
    );
  }

  /// `Has a clear deadline or timeframe for completion.`
  String get time_bound_desc {
    return Intl.message(
      'Has a clear deadline or timeframe for completion.',
      name: 'time_bound_desc',
      desc: '',
      args: [],
    );
  }

  /// `Select a category`
  String get habit_category_field_hint {
    return Intl.message(
      'Select a category',
      name: 'habit_category_field_hint',
      desc: '',
      args: [],
    );
  }

  /// `Frequency`
  String get habit_frequency {
    return Intl.message(
      'Frequency',
      name: 'habit_frequency',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get freq_daily {
    return Intl.message(
      'Daily',
      name: 'freq_daily',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get freq_monthly {
    return Intl.message(
      'Monthly',
      name: 'freq_monthly',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get freq_yearly {
    return Intl.message(
      'Yearly',
      name: 'freq_yearly',
      desc: '',
      args: [],
    );
  }

  /// `Value`
  String get freq_value {
    return Intl.message(
      'Value',
      name: 'freq_value',
      desc: '',
      args: [],
    );
  }

  /// `Weekdays`
  String get weekday_title {
    return Intl.message(
      'Weekdays',
      name: 'weekday_title',
      desc: '',
      args: [],
    );
  }

  /// `Time Interval`
  String get time_interval {
    return Intl.message(
      'Time Interval',
      name: 'time_interval',
      desc: '',
      args: [],
    );
  }

  /// `{n, plural, one {Every {n} month} other {Every {n} months}}`
  String every_n_month(num n) {
    return Intl.plural(
      n,
      one: 'Every $n month',
      other: 'Every $n months',
      name: 'every_n_month',
      desc: '',
      args: [n],
    );
  }

  /// `{n, plural, one {Every {n} day} other {Every {n} days}}`
  String every_n_day(num n) {
    return Intl.plural(
      n,
      one: 'Every $n day',
      other: 'Every $n days',
      name: 'every_n_day',
      desc: '',
      args: [n],
    );
  }

  /// `{n, plural, one {Every {n} minute} other {Every {n} minutes}}`
  String every_n_minute(num n) {
    return Intl.plural(
      n,
      one: 'Every $n minute',
      other: 'Every $n minutes',
      name: 'every_n_minute',
      desc: '',
      args: [n],
    );
  }

  /// `{n, plural, one {Every {n} hour} other {Every {n} hours}}`
  String every_n_hour(num n) {
    return Intl.plural(
      n,
      one: 'Every $n hour',
      other: 'Every $n hours',
      name: 'every_n_hour',
      desc: '',
      args: [n],
    );
  }

  /// `Generate Habit`
  String get generate_habit_button {
    return Intl.message(
      'Generate Habit',
      name: 'generate_habit_button',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get summary_title {
    return Intl.message(
      'Summary',
      name: 'summary_title',
      desc: '',
      args: [],
    );
  }

  /// `Please provide at least one in habit name, description or brief goal to generate accurate SMART goal`
  String get add_habit_not_enough_info {
    return Intl.message(
      'Please provide at least one in habit name, description or brief goal to generate accurate SMART goal',
      name: 'add_habit_not_enough_info',
      desc: '',
      args: [],
    );
  }

  /// `Please enter number that greater than 0`
  String get invalid_num {
    return Intl.message(
      'Please enter number that greater than 0',
      name: 'invalid_num',
      desc: '',
      args: [],
    );
  }

  /// `Start date cannot be after end date`
  String get invalid_start_date {
    return Intl.message(
      'Start date cannot be after end date',
      name: 'invalid_start_date',
      desc: '',
      args: [],
    );
  }

  /// `End date cannot be after start date`
  String get invalid_end_date {
    return Intl.message(
      'End date cannot be after start date',
      name: 'invalid_end_date',
      desc: '',
      args: [],
    );
  }

  /// `Please provides more information to generate a better goal`
  String get invalid_habit_prompt {
    return Intl.message(
      'Please provides more information to generate a better goal',
      name: 'invalid_habit_prompt',
      desc: '',
      args: [],
    );
  }

  /// `Cannot generate habit`
  String get cannot_generate_habit {
    return Intl.message(
      'Cannot generate habit',
      name: 'cannot_generate_habit',
      desc: '',
      args: [],
    );
  }

  /// `Cannot update habit`
  String get cannot_update_habit {
    return Intl.message(
      'Cannot update habit',
      name: 'cannot_update_habit',
      desc: '',
      args: [],
    );
  }

  /// `No habit found`
  String get no_habit_found {
    return Intl.message(
      'No habit found',
      name: 'no_habit_found',
      desc: '',
      args: [],
    );
  }

  /// `Start value must be less than end value`
  String get start_value_must_be_less_than_end {
    return Intl.message(
      'Start value must be less than end value',
      name: 'start_value_must_be_less_than_end',
      desc: '',
      args: [],
    );
  }

  /// `End value must be greater than start value`
  String get end_value_must_be_greater_than_start {
    return Intl.message(
      'End value must be greater than start value',
      name: 'end_value_must_be_greater_than_start',
      desc: '',
      args: [],
    );
  }

  /// `SMART Achieved`
  String get smart_criteria_achieved {
    return Intl.message(
      'SMART Achieved',
      name: 'smart_criteria_achieved',
      desc: '',
      args: [],
    );
  }

  /// `Your goal is very clear and well_defined with specific details`
  String get specific_excellent {
    return Intl.message(
      'Your goal is very clear and well_defined with specific details',
      name: 'specific_excellent',
      desc: 'Feedback for excellent specific criteria',
      args: [],
    );
  }

  /// `Your goal has good specificity but could use more detail`
  String get specific_good {
    return Intl.message(
      'Your goal has good specificity but could use more detail',
      name: 'specific_good',
      desc: 'Feedback for good specific criteria',
      args: [],
    );
  }

  /// `Your goal needs more specific details about what you want to achieve`
  String get specific_needs_work {
    return Intl.message(
      'Your goal needs more specific details about what you want to achieve',
      name: 'specific_needs_work',
      desc: 'Feedback for needs work specific criteria',
      args: [],
    );
  }

  /// `Your goal is too vague and needs specific actions`
  String get specific_poor {
    return Intl.message(
      'Your goal is too vague and needs specific actions',
      name: 'specific_poor',
      desc: 'Feedback for poor specific criteria',
      args: [],
    );
  }

  /// `Add specific numbers or quantities to measure success`
  String get specific_suggestion_1 {
    return Intl.message(
      'Add specific numbers or quantities to measure success',
      name: 'specific_suggestion_1',
      desc: 'First suggestion for improving specificity',
      args: [],
    );
  }

  /// `Include clear action verbs describing what you'll do`
  String get specific_suggestion_2 {
    return Intl.message(
      'Include clear action verbs describing what you\'ll do',
      name: 'specific_suggestion_2',
      desc: 'Second suggestion for improving specificity',
      args: [],
    );
  }

  /// `Specify exactly what you want to achieve`
  String get specific_suggestion_3 {
    return Intl.message(
      'Specify exactly what you want to achieve',
      name: 'specific_suggestion_3',
      desc: 'Third suggestion for improving specificity',
      args: [],
    );
  }

  /// `Your goal has clear metrics and tracking methods`
  String get measurable_excellent {
    return Intl.message(
      'Your goal has clear metrics and tracking methods',
      name: 'measurable_excellent',
      desc: 'Feedback for excellent measurable criteria',
      args: [],
    );
  }

  /// `Your goal is measurable but could use clearer metrics`
  String get measurable_good {
    return Intl.message(
      'Your goal is measurable but could use clearer metrics',
      name: 'measurable_good',
      desc: 'Feedback for good measurable criteria',
      args: [],
    );
  }

  /// `Your goal needs clearer ways to measure progress`
  String get measurable_needs_work {
    return Intl.message(
      'Your goal needs clearer ways to measure progress',
      name: 'measurable_needs_work',
      desc: 'Feedback for needs work measurable criteria',
      args: [],
    );
  }

  /// `Your goal lacks any measurable criteria`
  String get measurable_poor {
    return Intl.message(
      'Your goal lacks any measurable criteria',
      name: 'measurable_poor',
      desc: 'Feedback for poor measurable criteria',
      args: [],
    );
  }

  /// `Add specific numbers to track progress`
  String get measurable_suggestion_1 {
    return Intl.message(
      'Add specific numbers to track progress',
      name: 'measurable_suggestion_1',
      desc: 'First suggestion for improving measurable habit',
      args: [],
    );
  }

  /// `Include how you'll measure success`
  String get measurable_suggestion_2 {
    return Intl.message(
      'Include how you\'ll measure success',
      name: 'measurable_suggestion_2',
      desc: 'Second suggestion for improving measurable habit',
      args: [],
    );
  }

  /// `Consider making the goal more achievable by avoiding absolute terms`
  String get achievable_suggestion_1 {
    return Intl.message(
      'Consider making the goal more achievable by avoiding absolute terms',
      name: 'achievable_suggestion_1',
      desc: '',
      args: [],
    );
  }

  /// `Avoid unclear goal that cannot measure or achieve`
  String get achievable_suggestion_2 {
    return Intl.message(
      'Avoid unclear goal that cannot measure or achieve',
      name: 'achievable_suggestion_2',
      desc: '',
      args: [],
    );
  }

  /// `Consider explaining why this goal is important to you`
  String get relevant_suggestion_1 {
    return Intl.message(
      'Consider explaining why this goal is important to you',
      name: 'relevant_suggestion_1',
      desc: '',
      args: [],
    );
  }

  /// `Consider adding a clear time limit or deadline for your goal.`
  String get time_bound_suggestion_1 {
    return Intl.message(
      'Consider adding a clear time limit or deadline for your goal.',
      name: 'time_bound_suggestion_1',
      desc: '',
      args: [],
    );
  }

  /// `Please specify the timeframe or duration for achieving your goal.`
  String get time_bound_suggestion_2 {
    return Intl.message(
      'Please specify the timeframe or duration for achieving your goal.',
      name: 'time_bound_suggestion_2',
      desc: '',
      args: [],
    );
  }

  /// `Excellent SMART goal! All criteria are well_defined and balanced.`
  String get summary_excellent {
    return Intl.message(
      'Excellent SMART goal! All criteria are well_defined and balanced.',
      name: 'summary_excellent',
      desc: 'Summary for excellent overall score',
      args: [],
    );
  }

  /// `Good SMART goal with minor areas for improvement. Score: {score}%`
  String summary_good(double score) {
    return Intl.message(
      'Good SMART goal with minor areas for improvement. Score: $score%',
      name: 'summary_good',
      desc: 'Summary for good overall score',
      args: [score],
    );
  }

  /// `Goal needs work in several areas to be truly SMART. Score: {score}%`
  String summary_needs_work(double score) {
    return Intl.message(
      'Goal needs work in several areas to be truly SMART. Score: $score%',
      name: 'summary_needs_work',
      desc: 'Summary for needs work overall score',
      args: [score],
    );
  }

  /// `Goal needs significant improvement to meet SMART criteria. Score: {score}%`
  String summary_poor(double score) {
    return Intl.message(
      'Goal needs significant improvement to meet SMART criteria. Score: $score%',
      name: 'summary_poor',
      desc: 'Summary for poor overall score',
      args: [score],
    );
  }

  /// `run`
  String get action_exercise_run {
    return Intl.message(
      'run',
      name: 'action_exercise_run',
      desc: '',
      args: [],
    );
  }

  /// `walk`
  String get action_exercise_walk {
    return Intl.message(
      'walk',
      name: 'action_exercise_walk',
      desc: '',
      args: [],
    );
  }

  /// `swim`
  String get action_exercise_swim {
    return Intl.message(
      'swim',
      name: 'action_exercise_swim',
      desc: '',
      args: [],
    );
  }

  /// `workout`
  String get action_exercise_workout {
    return Intl.message(
      'workout',
      name: 'action_exercise_workout',
      desc: '',
      args: [],
    );
  }

  /// `jog`
  String get action_exercise_jog {
    return Intl.message(
      'jog',
      name: 'action_exercise_jog',
      desc: '',
      args: [],
    );
  }

  /// `practice yoga`
  String get action_exercise_yoga {
    return Intl.message(
      'practice yoga',
      name: 'action_exercise_yoga',
      desc: '',
      args: [],
    );
  }

  /// `stretch`
  String get action_exercise_stretch {
    return Intl.message(
      'stretch',
      name: 'action_exercise_stretch',
      desc: '',
      args: [],
    );
  }

  /// `go to gym`
  String get action_exercise_gym {
    return Intl.message(
      'go to gym',
      name: 'action_exercise_gym',
      desc: '',
      args: [],
    );
  }

  /// `read`
  String get action_learning_read {
    return Intl.message(
      'read',
      name: 'action_learning_read',
      desc: '',
      args: [],
    );
  }

  /// `study`
  String get action_learning_study {
    return Intl.message(
      'study',
      name: 'action_learning_study',
      desc: '',
      args: [],
    );
  }

  /// `practice`
  String get action_learning_practice {
    return Intl.message(
      'practice',
      name: 'action_learning_practice',
      desc: '',
      args: [],
    );
  }

  /// `write`
  String get action_learning_write {
    return Intl.message(
      'write',
      name: 'action_learning_write',
      desc: '',
      args: [],
    );
  }

  /// `revise`
  String get action_learning_revise {
    return Intl.message(
      'revise',
      name: 'action_learning_revise',
      desc: '',
      args: [],
    );
  }

  /// `research`
  String get action_learning_research {
    return Intl.message(
      'research',
      name: 'action_learning_research',
      desc: '',
      args: [],
    );
  }

  /// `learn`
  String get action_learning_learn {
    return Intl.message(
      'learn',
      name: 'action_learning_learn',
      desc: '',
      args: [],
    );
  }

  /// `master`
  String get action_learning_master {
    return Intl.message(
      'master',
      name: 'action_learning_master',
      desc: '',
      args: [],
    );
  }

  /// `meditate`
  String get action_health_meditate {
    return Intl.message(
      'meditate',
      name: 'action_health_meditate',
      desc: '',
      args: [],
    );
  }

  /// `drink`
  String get action_health_drink {
    return Intl.message(
      'drink',
      name: 'action_health_drink',
      desc: '',
      args: [],
    );
  }

  /// `eat`
  String get action_health_eat {
    return Intl.message(
      'eat',
      name: 'action_health_eat',
      desc: '',
      args: [],
    );
  }

  /// `sleep`
  String get action_health_sleep {
    return Intl.message(
      'sleep',
      name: 'action_health_sleep',
      desc: '',
      args: [],
    );
  }

  /// `breathe`
  String get action_health_breathe {
    return Intl.message(
      'breathe',
      name: 'action_health_breathe',
      desc: '',
      args: [],
    );
  }

  /// `relax`
  String get action_health_relax {
    return Intl.message(
      'relax',
      name: 'action_health_relax',
      desc: '',
      args: [],
    );
  }

  /// `rest`
  String get action_health_rest {
    return Intl.message(
      'rest',
      name: 'action_health_rest',
      desc: '',
      args: [],
    );
  }

  /// `complete`
  String get action_productivity_complete {
    return Intl.message(
      'complete',
      name: 'action_productivity_complete',
      desc: '',
      args: [],
    );
  }

  /// `finish`
  String get action_productivity_finish {
    return Intl.message(
      'finish',
      name: 'action_productivity_finish',
      desc: '',
      args: [],
    );
  }

  /// `achieve`
  String get action_productivity_achieve {
    return Intl.message(
      'achieve',
      name: 'action_productivity_achieve',
      desc: '',
      args: [],
    );
  }

  /// `accomplish`
  String get action_productivity_accomplish {
    return Intl.message(
      'accomplish',
      name: 'action_productivity_accomplish',
      desc: '',
      args: [],
    );
  }

  /// `do`
  String get action_productivity_do {
    return Intl.message(
      'do',
      name: 'action_productivity_do',
      desc: '',
      args: [],
    );
  }

  /// `work on`
  String get action_productivity_work {
    return Intl.message(
      'work on',
      name: 'action_productivity_work',
      desc: '',
      args: [],
    );
  }

  /// `start`
  String get action_productivity_start {
    return Intl.message(
      'start',
      name: 'action_productivity_start',
      desc: '',
      args: [],
    );
  }

  /// `continue`
  String get action_productivity_continue {
    return Intl.message(
      'continue',
      name: 'action_productivity_continue',
      desc: '',
      args: [],
    );
  }

  /// `build`
  String get action_creative_build {
    return Intl.message(
      'build',
      name: 'action_creative_build',
      desc: '',
      args: [],
    );
  }

  /// `create`
  String get action_creative_create {
    return Intl.message(
      'create',
      name: 'action_creative_create',
      desc: '',
      args: [],
    );
  }

  /// `develop`
  String get action_creative_develop {
    return Intl.message(
      'develop',
      name: 'action_creative_develop',
      desc: '',
      args: [],
    );
  }

  /// `design`
  String get action_creative_design {
    return Intl.message(
      'design',
      name: 'action_creative_design',
      desc: '',
      args: [],
    );
  }

  /// `write`
  String get action_creative_write {
    return Intl.message(
      'write',
      name: 'action_creative_write',
      desc: '',
      args: [],
    );
  }

  /// `draw`
  String get action_creative_draw {
    return Intl.message(
      'draw',
      name: 'action_creative_draw',
      desc: '',
      args: [],
    );
  }

  /// `paint`
  String get action_creative_paint {
    return Intl.message(
      'paint',
      name: 'action_creative_paint',
      desc: '',
      args: [],
    );
  }

  /// `compose`
  String get action_creative_compose {
    return Intl.message(
      'compose',
      name: 'action_creative_compose',
      desc: '',
      args: [],
    );
  }

  /// `connect with`
  String get action_social_connect {
    return Intl.message(
      'connect with',
      name: 'action_social_connect',
      desc: '',
      args: [],
    );
  }

  /// `meet`
  String get action_social_meet {
    return Intl.message(
      'meet',
      name: 'action_social_meet',
      desc: '',
      args: [],
    );
  }

  /// `call`
  String get action_social_call {
    return Intl.message(
      'call',
      name: 'action_social_call',
      desc: '',
      args: [],
    );
  }

  /// `text`
  String get action_social_text {
    return Intl.message(
      'text',
      name: 'action_social_text',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get action_social_email {
    return Intl.message(
      'email',
      name: 'action_social_email',
      desc: '',
      args: [],
    );
  }

  /// `visit`
  String get action_social_visit {
    return Intl.message(
      'visit',
      name: 'action_social_visit',
      desc: '',
      args: [],
    );
  }

  /// `spend time with`
  String get action_social_spend {
    return Intl.message(
      'spend time with',
      name: 'action_social_spend',
      desc: '',
      args: [],
    );
  }

  /// `help`
  String get action_social_help {
    return Intl.message(
      'help',
      name: 'action_social_help',
      desc: '',
      args: [],
    );
  }

  /// `reduce`
  String get action_improvement_reduce {
    return Intl.message(
      'reduce',
      name: 'action_improvement_reduce',
      desc: '',
      args: [],
    );
  }

  /// `increase`
  String get action_improvement_increase {
    return Intl.message(
      'increase',
      name: 'action_improvement_increase',
      desc: '',
      args: [],
    );
  }

  /// `decrease`
  String get action_improvement_decrease {
    return Intl.message(
      'decrease',
      name: 'action_improvement_decrease',
      desc: '',
      args: [],
    );
  }

  /// `improve`
  String get action_improvement_improve {
    return Intl.message(
      'improve',
      name: 'action_improvement_improve',
      desc: '',
      args: [],
    );
  }

  /// `enhance`
  String get action_improvement_enhance {
    return Intl.message(
      'enhance',
      name: 'action_improvement_enhance',
      desc: '',
      args: [],
    );
  }

  /// `optimize`
  String get action_improvement_optimize {
    return Intl.message(
      'optimize',
      name: 'action_improvement_optimize',
      desc: '',
      args: [],
    );
  }

  /// `upgrade`
  String get action_improvement_upgrade {
    return Intl.message(
      'upgrade',
      name: 'action_improvement_upgrade',
      desc: '',
      args: [],
    );
  }

  /// `track`
  String get action_tracking_track {
    return Intl.message(
      'track',
      name: 'action_tracking_track',
      desc: '',
      args: [],
    );
  }

  /// `measure`
  String get action_tracking_measure {
    return Intl.message(
      'measure',
      name: 'action_tracking_measure',
      desc: '',
      args: [],
    );
  }

  /// `monitor`
  String get action_tracking_monitor {
    return Intl.message(
      'monitor',
      name: 'action_tracking_monitor',
      desc: '',
      args: [],
    );
  }

  /// `record`
  String get action_tracking_record {
    return Intl.message(
      'record',
      name: 'action_tracking_record',
      desc: '',
      args: [],
    );
  }

  /// `log`
  String get action_tracking_log {
    return Intl.message(
      'log',
      name: 'action_tracking_log',
      desc: '',
      args: [],
    );
  }

  /// `count`
  String get action_tracking_count {
    return Intl.message(
      'count',
      name: 'action_tracking_count',
      desc: '',
      args: [],
    );
  }

  /// `analyze`
  String get action_tracking_analyze {
    return Intl.message(
      'analyze',
      name: 'action_tracking_analyze',
      desc: '',
      args: [],
    );
  }

  /// `spend`
  String get action_time_spend {
    return Intl.message(
      'spend',
      name: 'action_time_spend',
      desc: '',
      args: [],
    );
  }

  /// `allocate`
  String get action_time_allocate {
    return Intl.message(
      'allocate',
      name: 'action_time_allocate',
      desc: '',
      args: [],
    );
  }

  /// `limit`
  String get action_time_limit {
    return Intl.message(
      'limit',
      name: 'action_time_limit',
      desc: '',
      args: [],
    );
  }

  /// `schedule`
  String get action_time_schedule {
    return Intl.message(
      'schedule',
      name: 'action_time_schedule',
      desc: '',
      args: [],
    );
  }

  /// `plan`
  String get action_time_plan {
    return Intl.message(
      'plan',
      name: 'action_time_plan',
      desc: '',
      args: [],
    );
  }

  /// `organize`
  String get action_time_organize {
    return Intl.message(
      'organize',
      name: 'action_time_organize',
      desc: '',
      args: [],
    );
  }

  /// `manage`
  String get action_time_manage {
    return Intl.message(
      'manage',
      name: 'action_time_manage',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get measurable_meter {
    return Intl.message(
      'm',
      name: 'measurable_meter',
      desc: 'Unit of measurement: meter',
      args: [],
    );
  }

  /// `km`
  String get measurable_kilometer {
    return Intl.message(
      'km',
      name: 'measurable_kilometer',
      desc: 'Unit of measurement: kilometer',
      args: [],
    );
  }

  /// `mile`
  String get measurable_mile {
    return Intl.message(
      'mile',
      name: 'measurable_mile',
      desc: 'Unit of measurement: kilometer',
      args: [],
    );
  }

  /// `g`
  String get measurable_gram {
    return Intl.message(
      'g',
      name: 'measurable_gram',
      desc: 'Unit of measurement: gram',
      args: [],
    );
  }

  /// `kg`
  String get measurable_kilogram {
    return Intl.message(
      'kg',
      name: 'measurable_kilogram',
      desc: 'Unit of measurement: kilogram',
      args: [],
    );
  }

  /// `l`
  String get measurable_liter {
    return Intl.message(
      'l',
      name: 'measurable_liter',
      desc: 'Unit of measurement: liter',
      args: [],
    );
  }

  /// `ml`
  String get measurable_milliliter {
    return Intl.message(
      'ml',
      name: 'measurable_milliliter',
      desc: 'Unit of measurement: milliliter',
      args: [],
    );
  }

  /// `h`
  String get measurable_hour {
    return Intl.message(
      'h',
      name: 'measurable_hour',
      desc: 'Unit of time: hour',
      args: [],
    );
  }

  /// `min`
  String get measurable_minute {
    return Intl.message(
      'min',
      name: 'measurable_minute',
      desc: 'Unit of time: minute',
      args: [],
    );
  }

  /// `s`
  String get measurable_second {
    return Intl.message(
      's',
      name: 'measurable_second',
      desc: 'Unit of time: second',
      args: [],
    );
  }

  /// `page`
  String get measurable_page {
    return Intl.message(
      'page',
      name: 'measurable_page',
      desc: 'Unit of book: page',
      args: [],
    );
  }

  /// `step`
  String get measurable_step {
    return Intl.message(
      'step',
      name: 'measurable_step',
      desc: 'Unit of walking: step',
      args: [],
    );
  }

  /// `rep`
  String get measurable_rep {
    return Intl.message(
      'rep',
      name: 'measurable_rep',
      desc: 'Unit of walking: rep',
      args: [],
    );
  }

  /// `set`
  String get measurable_set {
    return Intl.message(
      'set',
      name: 'measurable_set',
      desc: 'Unit of walking: set',
      args: [],
    );
  }

  /// `increase`
  String get measurable_positive_increase {
    return Intl.message(
      'increase',
      name: 'measurable_positive_increase',
      desc:
          'Indicates an increase, often associated with growth or improvement.',
      args: [],
    );
  }

  /// `improve`
  String get measurable_positive_improve {
    return Intl.message(
      'improve',
      name: 'measurable_positive_improve',
      desc:
          'Indicates improvement, typically suggesting progress toward a goal.',
      args: [],
    );
  }

  /// `optimize`
  String get measurable_positive_optimize {
    return Intl.message(
      'optimize',
      name: 'measurable_positive_optimize',
      desc:
          'Refers to making something as effective or functional as possible.',
      args: [],
    );
  }

  /// `boost`
  String get measurable_positive_boost {
    return Intl.message(
      'boost',
      name: 'measurable_positive_boost',
      desc:
          'Refers to enhancing or improving something, usually in terms of performance.',
      args: [],
    );
  }

  /// `grow`
  String get measurable_positive_growth {
    return Intl.message(
      'grow',
      name: 'measurable_positive_growth',
      desc:
          'Refers to the process of increasing or expanding in size or capacity.',
      args: [],
    );
  }

  /// `expand`
  String get measurable_positive_expand {
    return Intl.message(
      'expand',
      name: 'measurable_positive_expand',
      desc: 'Refers to making something larger or more extensive.',
      args: [],
    );
  }

  /// `enhance`
  String get measurable_positive_enhance {
    return Intl.message(
      'enhance',
      name: 'measurable_positive_enhance',
      desc: 'Refers to improving something, especially in terms of quality.',
      args: [],
    );
  }

  /// `raise`
  String get measurable_positive_raise {
    return Intl.message(
      'raise',
      name: 'measurable_positive_raise',
      desc: 'Indicates lifting or increasing something to a higher level.',
      args: [],
    );
  }

  /// `develop`
  String get measurable_positive_develop {
    return Intl.message(
      'develop',
      name: 'measurable_positive_develop',
      desc: 'Indicates the process of growth or improvement over time.',
      args: [],
    );
  }

  /// `build`
  String get measurable_positive_build {
    return Intl.message(
      'build',
      name: 'measurable_positive_build',
      desc:
          'Refers to constructing or creating something, often associated with progress.',
      args: [],
    );
  }

  /// `complete`
  String get measurable_positive_complete {
    return Intl.message(
      'complete',
      name: 'measurable_positive_complete',
      desc: 'Refers to finishing or concluding a task or project.',
      args: [],
    );
  }

  /// `accomplish`
  String get measurable_positive_accomplish {
    return Intl.message(
      'accomplish',
      name: 'measurable_positive_accomplish',
      desc: 'Refers to achieving or completing something successfully.',
      args: [],
    );
  }

  /// `achieve`
  String get measurable_positive_achieve {
    return Intl.message(
      'achieve',
      name: 'measurable_positive_achieve',
      desc: 'Indicates the completion or attainment of a goal.',
      args: [],
    );
  }

  /// `attain`
  String get measurable_positive_attain {
    return Intl.message(
      'attain',
      name: 'measurable_positive_attain',
      desc: 'Refers to reaching or achieving a desired goal or level.',
      args: [],
    );
  }

  /// `reach`
  String get measurable_positive_reach {
    return Intl.message(
      'reach',
      name: 'measurable_positive_reach',
      desc: 'Indicates achieving or arriving at a goal or target.',
      args: [],
    );
  }

  /// `succeed`
  String get measurable_positive_succeed {
    return Intl.message(
      'succeed',
      name: 'measurable_positive_succeed',
      desc: 'Refers to achieving success or fulfilling a goal.',
      args: [],
    );
  }

  /// `master`
  String get measurable_positive_master {
    return Intl.message(
      'master',
      name: 'measurable_positive_master',
      desc: 'Refers to gaining full control or proficiency over something.',
      args: [],
    );
  }

  /// `finalize`
  String get measurable_positive_finalize {
    return Intl.message(
      'finalize',
      name: 'measurable_positive_finalize',
      desc: 'Indicates bringing a task or project to a conclusion.',
      args: [],
    );
  }

  /// `realize`
  String get measurable_positive_realize {
    return Intl.message(
      'realize',
      name: 'measurable_positive_realize',
      desc: 'Refers to achieving or making something a reality.',
      args: [],
    );
  }

  /// `deliver`
  String get measurable_positive_deliver {
    return Intl.message(
      'deliver',
      name: 'measurable_positive_deliver',
      desc: 'Refers to completing a task or fulfilling a commitment.',
      args: [],
    );
  }

  /// `finish`
  String get measurable_positive_finish {
    return Intl.message(
      'finish',
      name: 'measurable_positive_finish',
      desc: 'Indicates the completion of a task or project.',
      args: [],
    );
  }

  /// `progress`
  String get measurable_positive_progress {
    return Intl.message(
      'progress',
      name: 'measurable_positive_progress',
      desc: 'Refers to moving forward or making advancements.',
      args: [],
    );
  }

  /// `advance`
  String get measurable_positive_advance {
    return Intl.message(
      'advance',
      name: 'measurable_positive_advance',
      desc: 'Indicates moving forward or making progress toward a goal.',
      args: [],
    );
  }

  /// `strengthen`
  String get measurable_positive_strengthen {
    return Intl.message(
      'strengthen',
      name: 'measurable_positive_strengthen',
      desc: 'Refers to making something stronger or more effective.',
      args: [],
    );
  }

  /// `cultivate`
  String get measurable_positive_cultivate {
    return Intl.message(
      'cultivate',
      name: 'measurable_positive_cultivate',
      desc: 'Refers to developing or improving something over time.',
      args: [],
    );
  }

  /// `refine`
  String get measurable_positive_refine {
    return Intl.message(
      'refine',
      name: 'measurable_positive_refine',
      desc:
          'Indicates improving something through small adjustments or corrections.',
      args: [],
    );
  }

  /// `perfect`
  String get measurable_positive_perfect {
    return Intl.message(
      'perfect',
      name: 'measurable_positive_perfect',
      desc: 'Refers to making something flawless or as good as possible.',
      args: [],
    );
  }

  /// `lose`
  String get measurable_negative_lose {
    return Intl.message(
      'lose',
      name: 'measurable_negative_lose',
      desc: 'Indicates reduction or failure to maintain something.',
      args: [],
    );
  }

  /// `decline`
  String get measurable_negative_decline {
    return Intl.message(
      'decline',
      name: 'measurable_negative_decline',
      desc: 'Refers to a decrease or worsening over time.',
      args: [],
    );
  }

  /// `diminish`
  String get measurable_negative_diminish {
    return Intl.message(
      'diminish',
      name: 'measurable_negative_diminish',
      desc: 'Refers to making something smaller or less effective.',
      args: [],
    );
  }

  /// `decrease`
  String get measurable_negative_decrease {
    return Intl.message(
      'decrease',
      name: 'measurable_negative_decrease',
      desc: 'Refers to a reduction in size, amount, or quality.',
      args: [],
    );
  }

  /// `weaken`
  String get measurable_negative_weaken {
    return Intl.message(
      'weaken',
      name: 'measurable_negative_weaken',
      desc: 'Refers to making something weaker or less effective.',
      args: [],
    );
  }

  /// `fail`
  String get measurable_negative_fail {
    return Intl.message(
      'fail',
      name: 'measurable_negative_fail',
      desc: 'Indicates an inability to achieve or complete a goal.',
      args: [],
    );
  }

  /// `revert`
  String get measurable_negative_revert {
    return Intl.message(
      'revert',
      name: 'measurable_negative_revert',
      desc: 'Refers to returning to a previous state or condition.',
      args: [],
    );
  }

  /// `increase`
  String get relevant_increase {
    return Intl.message(
      'increase',
      name: 'relevant_increase',
      desc:
          'Indicates a positive change or growth in value, often related to progress.',
      args: [],
    );
  }

  /// `improve`
  String get relevant_improve {
    return Intl.message(
      'improve',
      name: 'relevant_improve',
      desc:
          'Indicates the process of becoming better or more effective in a given area.',
      args: [],
    );
  }

  /// `optimize`
  String get relevant_optimize {
    return Intl.message(
      'optimize',
      name: 'relevant_optimize',
      desc:
          'Refers to making something as efficient or functional as possible.',
      args: [],
    );
  }

  /// `boost`
  String get relevant_boost {
    return Intl.message(
      'boost',
      name: 'relevant_boost',
      desc:
          'Refers to enhancing or improving something, usually in terms of performance.',
      args: [],
    );
  }

  /// `enhance`
  String get relevant_enhance {
    return Intl.message(
      'enhance',
      name: 'relevant_enhance',
      desc: 'Refers to improving the quality or effectiveness of something.',
      args: [],
    );
  }

  /// `expand`
  String get relevant_expand {
    return Intl.message(
      'expand',
      name: 'relevant_expand',
      desc: 'Refers to increasing the scope, size, or influence of something.',
      args: [],
    );
  }

  /// `strengthen`
  String get relevant_strengthen {
    return Intl.message(
      'strengthen',
      name: 'relevant_strengthen',
      desc:
          'Refers to making something stronger, more effective, or more resilient.',
      args: [],
    );
  }

  /// `develop`
  String get relevant_develop {
    return Intl.message(
      'develop',
      name: 'relevant_develop',
      desc:
          'Refers to the gradual improvement or progression of something over time.',
      args: [],
    );
  }

  /// `raise`
  String get relevant_raise {
    return Intl.message(
      'raise',
      name: 'relevant_raise',
      desc:
          'Indicates lifting something to a higher level, often in terms of quality or achievement.',
      args: [],
    );
  }

  /// `accomplish`
  String get relevant_accomplish {
    return Intl.message(
      'accomplish',
      name: 'relevant_accomplish',
      desc: 'Refers to successfully completing a task or goal.',
      args: [],
    );
  }

  /// `deadline`
  String get time_bound_deadline {
    return Intl.message(
      'deadline',
      name: 'time_bound_deadline',
      desc: '',
      args: [],
    );
  }

  /// `complete`
  String get time_bound_complete {
    return Intl.message(
      'complete',
      name: 'time_bound_complete',
      desc: '',
      args: [],
    );
  }

  /// `finish`
  String get time_bound_finish {
    return Intl.message(
      'finish',
      name: 'time_bound_finish',
      desc: '',
      args: [],
    );
  }

  /// `finalize`
  String get time_bound_finalize {
    return Intl.message(
      'finalize',
      name: 'time_bound_finalize',
      desc: '',
      args: [],
    );
  }

  /// `achieve`
  String get time_bound_achieve {
    return Intl.message(
      'achieve',
      name: 'time_bound_achieve',
      desc: '',
      args: [],
    );
  }

  /// `reach`
  String get time_bound_reach {
    return Intl.message(
      'reach',
      name: 'time_bound_reach',
      desc: '',
      args: [],
    );
  }

  /// `complete by`
  String get time_bound_complete_by {
    return Intl.message(
      'complete by',
      name: 'time_bound_complete_by',
      desc: '',
      args: [],
    );
  }

  /// `due`
  String get time_bound_due {
    return Intl.message(
      'due',
      name: 'time_bound_due',
      desc: '',
      args: [],
    );
  }

  /// `end`
  String get time_bound_end {
    return Intl.message(
      'end',
      name: 'time_bound_end',
      desc: '',
      args: [],
    );
  }

  /// `within`
  String get time_bound_within {
    return Intl.message(
      'within',
      name: 'time_bound_within',
      desc: '',
      args: [],
    );
  }

  /// `before`
  String get time_bound_before {
    return Intl.message(
      'before',
      name: 'time_bound_before',
      desc: '',
      args: [],
    );
  }

  /// `on`
  String get time_bound_on {
    return Intl.message(
      'on',
      name: 'time_bound_on',
      desc: '',
      args: [],
    );
  }

  /// `by`
  String get time_bound_by {
    return Intl.message(
      'by',
      name: 'time_bound_by',
      desc: '',
      args: [],
    );
  }

  /// `duration`
  String get time_bound_duration {
    return Intl.message(
      'duration',
      name: 'time_bound_duration',
      desc: '',
      args: [],
    );
  }

  /// `until`
  String get time_bound_until {
    return Intl.message(
      'until',
      name: 'time_bound_until',
      desc: '',
      args: [],
    );
  }

  /// `start`
  String get time_bound_start {
    return Intl.message(
      'start',
      name: 'time_bound_start',
      desc: '',
      args: [],
    );
  }

  /// `start from`
  String get time_bound_start_from {
    return Intl.message(
      'start from',
      name: 'time_bound_start_from',
      desc: '',
      args: [],
    );
  }

  /// `start by`
  String get time_bound_start_by {
    return Intl.message(
      'start by',
      name: 'time_bound_start_by',
      desc: '',
      args: [],
    );
  }

  /// `timeframe`
  String get time_bound_timeframe {
    return Intl.message(
      'timeframe',
      name: 'time_bound_timeframe',
      desc: '',
      args: [],
    );
  }

  /// `end by`
  String get time_bound_end_by {
    return Intl.message(
      'end by',
      name: 'time_bound_end_by',
      desc: '',
      args: [],
    );
  }

  /// `goal`
  String get time_bound_goal {
    return Intl.message(
      'goal',
      name: 'time_bound_goal',
      desc: '',
      args: [],
    );
  }

  /// `end date`
  String get time_bound_end_date {
    return Intl.message(
      'end date',
      name: 'time_bound_end_date',
      desc: '',
      args: [],
    );
  }

  /// `in time`
  String get time_bound_in_time {
    return Intl.message(
      'in time',
      name: 'time_bound_in_time',
      desc: '',
      args: [],
    );
  }

  /// `time limit`
  String get time_bound_time_limit {
    return Intl.message(
      'time limit',
      name: 'time_bound_time_limit',
      desc: '',
      args: [],
    );
  }

  /// `timely`
  String get time_bound_timely {
    return Intl.message(
      'timely',
      name: 'time_bound_timely',
      desc: '',
      args: [],
    );
  }

  /// `immediate`
  String get time_bound_immediate {
    return Intl.message(
      'immediate',
      name: 'time_bound_immediate',
      desc: '',
      args: [],
    );
  }

  /// `promptly`
  String get time_bound_promptly {
    return Intl.message(
      'promptly',
      name: 'time_bound_promptly',
      desc: '',
      args: [],
    );
  }

  /// `soon`
  String get time_bound_soon {
    return Intl.message(
      'soon',
      name: 'time_bound_soon',
      desc: '',
      args: [],
    );
  }

  /// `quickly`
  String get time_bound_quickly {
    return Intl.message(
      'quickly',
      name: 'time_bound_quickly',
      desc: '',
      args: [],
    );
  }

  /// `urgent`
  String get time_bound_urgent {
    return Intl.message(
      'urgent',
      name: 'time_bound_urgent',
      desc: '',
      args: [],
    );
  }

  /// `scheduled`
  String get time_bound_scheduled {
    return Intl.message(
      'scheduled',
      name: 'time_bound_scheduled',
      desc: '',
      args: [],
    );
  }

  /// `set date`
  String get time_bound_set_date {
    return Intl.message(
      'set date',
      name: 'time_bound_set_date',
      desc: '',
      args: [],
    );
  }

  /// `after`
  String get time_bound_after {
    return Intl.message(
      'after',
      name: 'time_bound_after',
      desc: '',
      args: [],
    );
  }

  /// `soon after`
  String get time_bound_soon_after {
    return Intl.message(
      'soon after',
      name: 'time_bound_soon_after',
      desc: '',
      args: [],
    );
  }

  /// `next`
  String get time_bound_next {
    return Intl.message(
      'next',
      name: 'time_bound_next',
      desc: '',
      args: [],
    );
  }

  /// `in the next`
  String get time_bound_in_the_next {
    return Intl.message(
      'in the next',
      name: 'time_bound_in_the_next',
      desc: '',
      args: [],
    );
  }

  /// `within the next`
  String get time_bound_within_the_next {
    return Intl.message(
      'within the next',
      name: 'time_bound_within_the_next',
      desc: '',
      args: [],
    );
  }

  /// `upon completion`
  String get time_bound_upon_completion {
    return Intl.message(
      'upon completion',
      name: 'time_bound_upon_completion',
      desc: '',
      args: [],
    );
  }

  /// `post`
  String get time_bound_post {
    return Intl.message(
      'post',
      name: 'time_bound_post',
      desc: '',
      args: [],
    );
  }

  /// `Internet connection failure`
  String get internet_failure_title {
    return Intl.message(
      'Internet connection failure',
      name: 'internet_failure_title',
      desc: '',
      args: [],
    );
  }

  /// `Please note, the accuracy of your goal may be affected if there is no internet connection. Kindly check your connection and try again`
  String get goal_recommend_with_no_internet_alert {
    return Intl.message(
      'Please note, the accuracy of your goal may be affected if there is no internet connection. Kindly check your connection and try again',
      name: 'goal_recommend_with_no_internet_alert',
      desc: '',
      args: [],
    );
  }

  /// `Goal Description`
  String get goal_desc {
    return Intl.message(
      'Goal Description',
      name: 'goal_desc',
      desc: '',
      args: [],
    );
  }

  /// `Goal Description (Provides details about the specific goal related to that habit)`
  String get add_goal_desc {
    return Intl.message(
      'Goal Description (Provides details about the specific goal related to that habit)',
      name: 'add_goal_desc',
      desc: '',
      args: [],
    );
  }

  /// `Goal Type`
  String get goal_type {
    return Intl.message(
      'Goal Type',
      name: 'goal_type',
      desc: '',
      args: [],
    );
  }

  /// `Value`
  String get goal_unit_value {
    return Intl.message(
      'Value',
      name: 'goal_unit_value',
      desc: '',
      args: [],
    );
  }

  /// `Goal Unit`
  String get goal_unit {
    return Intl.message(
      'Goal Unit',
      name: 'goal_unit',
      desc: '',
      args: [],
    );
  }

  /// `reps`
  String get reps_unit {
    return Intl.message(
      'reps',
      name: 'reps_unit',
      desc: '',
      args: [],
    );
  }

  /// `sets`
  String get sets_unit {
    return Intl.message(
      'sets',
      name: 'sets_unit',
      desc: '',
      args: [],
    );
  }

  /// `liters`
  String get l_unit {
    return Intl.message(
      'liters',
      name: 'l_unit',
      desc: '',
      args: [],
    );
  }

  /// `milliliters`
  String get ml_unit {
    return Intl.message(
      'milliliters',
      name: 'ml_unit',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get day_unit {
    return Intl.message(
      'day',
      name: 'day_unit',
      desc: '',
      args: [],
    );
  }

  /// `second`
  String get second_unit {
    return Intl.message(
      'second',
      name: 'second_unit',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get minute_unit {
    return Intl.message(
      'minute',
      name: 'minute_unit',
      desc: '',
      args: [],
    );
  }

  /// `hour`
  String get hour_unit {
    return Intl.message(
      'hour',
      name: 'hour_unit',
      desc: '',
      args: [],
    );
  }

  /// `page`
  String get page_unit {
    return Intl.message(
      'page',
      name: 'page_unit',
      desc: '',
      args: [],
    );
  }

  /// `centimeters`
  String get cm_unit {
    return Intl.message(
      'centimeters',
      name: 'cm_unit',
      desc: '',
      args: [],
    );
  }

  /// `kilometers`
  String get km_unit {
    return Intl.message(
      'kilometers',
      name: 'km_unit',
      desc: '',
      args: [],
    );
  }

  /// `meters`
  String get m_unit {
    return Intl.message(
      'meters',
      name: 'm_unit',
      desc: '',
      args: [],
    );
  }

  /// `steps`
  String get steps_unit {
    return Intl.message(
      'steps',
      name: 'steps_unit',
      desc: '',
      args: [],
    );
  }

  /// `miles`
  String get miles_unit {
    return Intl.message(
      'miles',
      name: 'miles_unit',
      desc: '',
      args: [],
    );
  }

  /// `times`
  String get times_unit {
    return Intl.message(
      'times',
      name: 'times_unit',
      desc: '',
      args: [],
    );
  }

  /// `custom`
  String get custom_unit {
    return Intl.message(
      'custom',
      name: 'custom_unit',
      desc: '',
      args: [],
    );
  }

  /// `Completion`
  String get goal_completion {
    return Intl.message(
      'Completion',
      name: 'goal_completion',
      desc: 'Completion goal type',
      args: [],
    );
  }

  /// `Count`
  String get goal_count {
    return Intl.message(
      'Count',
      name: 'goal_count',
      desc: 'Count goal type',
      args: [],
    );
  }

  /// `Distance`
  String get goal_distance {
    return Intl.message(
      'Distance',
      name: 'goal_distance',
      desc: 'Distance goal type',
      args: [],
    );
  }

  /// `Duration`
  String get goal_duration {
    return Intl.message(
      'Duration',
      name: 'goal_duration',
      desc: 'Duration goal type',
      args: [],
    );
  }

  /// `Custom`
  String get goal_custom {
    return Intl.message(
      'Custom',
      name: 'goal_custom',
      desc: 'Custom goal type',
      args: [],
    );
  }

  /// `Get SMART Goal Recommendation`
  String get ask_ai_button {
    return Intl.message(
      'Get SMART Goal Recommendation',
      name: 'ask_ai_button',
      desc: '',
      args: [],
    );
  }

  /// `Tell me what you want to do...`
  String get ask_ai_field {
    return Intl.message(
      'Tell me what you want to do...',
      name: 'ask_ai_field',
      desc: '',
      args: [],
    );
  }

  /// `Get SMART habit with few word`
  String get ai_habit_generate_page_title {
    return Intl.message(
      'Get SMART habit with few word',
      name: 'ai_habit_generate_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Generated SMART Habit`
  String get habit_generated_title {
    return Intl.message(
      'Generated SMART Habit',
      name: 'habit_generated_title',
      desc: '',
      args: [],
    );
  }

  /// `Create habit yourself`
  String get add_habit_manually {
    return Intl.message(
      'Create habit yourself',
      name: 'add_habit_manually',
      desc: '',
      args: [],
    );
  }

  /// `Generate another habit`
  String get regenerate_button {
    return Intl.message(
      'Generate another habit',
      name: 'regenerate_button',
      desc: '',
      args: [],
    );
  }

  /// `Add successfully`
  String get add_success {
    return Intl.message(
      'Add successfully',
      name: 'add_success',
      desc: '',
      args: [],
    );
  }

  /// `Drink enough 2L water a day`
  String get water_habit_title {
    return Intl.message(
      'Drink enough 2L water a day',
      name: 'water_habit_title',
      desc: '',
      args: [],
    );
  }

  /// `Stay hydrated and improve your overall health by drinking 2 liters of water every day`
  String get water_habit_desc {
    return Intl.message(
      'Stay hydrated and improve your overall health by drinking 2 liters of water every day',
      name: 'water_habit_desc',
      desc: '',
      args: [],
    );
  }

  /// `Drink 2L of water daily for the next 30 days to stay hydrated and maintain good health`
  String get water_habit_goal_desc {
    return Intl.message(
      'Drink 2L of water daily for the next 30 days to stay hydrated and maintain good health',
      name: 'water_habit_goal_desc',
      desc: '',
      args: [],
    );
  }

  /// `Walk/Run 2km`
  String get run_habit_title {
    return Intl.message(
      'Walk/Run 2km',
      name: 'run_habit_title',
      desc: '',
      args: [],
    );
  }

  /// `Improve your health and energy by walking or running 2km every morning.`
  String get run_habit_desc {
    return Intl.message(
      'Improve your health and energy by walking or running 2km every morning.',
      name: 'run_habit_desc',
      desc: '',
      args: [],
    );
  }

  /// `Walk or run 2km every morning to enhance fitness and health.`
  String get run_habit_goal_desc {
    return Intl.message(
      'Walk or run 2km every morning to enhance fitness and health.',
      name: 'run_habit_goal_desc',
      desc: '',
      args: [],
    );
  }

  /// `Do exercise every morning`
  String get exercise_habit_title {
    return Intl.message(
      'Do exercise every morning',
      name: 'exercise_habit_title',
      desc: '',
      args: [],
    );
  }

  /// `Improve health and energy by doing exercise every morning`
  String get exercise_habit_desc {
    return Intl.message(
      'Improve health and energy by doing exercise every morning',
      name: 'exercise_habit_desc',
      desc: '',
      args: [],
    );
  }

  /// `Do exercise 30 minutes every morning to enhance health and fitness`
  String get exercise_habit_goal_desc {
    return Intl.message(
      'Do exercise 30 minutes every morning to enhance health and fitness',
      name: 'exercise_habit_goal_desc',
      desc: '',
      args: [],
    );
  }

  /// `5-Minute Meditation`
  String get meditation_habit_title {
    return Intl.message(
      '5-Minute Meditation',
      name: 'meditation_habit_title',
      desc: '',
      args: [],
    );
  }

  /// `Relax and reduce stress by meditating for 5 minutes each morning.`
  String get meditation_habit_desc {
    return Intl.message(
      'Relax and reduce stress by meditating for 5 minutes each morning.',
      name: 'meditation_habit_desc',
      desc: '',
      args: [],
    );
  }

  /// `Spend 5 minutes each morning meditating to improve focus and clarity.`
  String get meditation_habit_goal_desc {
    return Intl.message(
      'Spend 5 minutes each morning meditating to improve focus and clarity.',
      name: 'meditation_habit_goal_desc',
      desc: '',
      args: [],
    );
  }

  /// `Read 10 Pages`
  String get reading_habit_title {
    return Intl.message(
      'Read 10 Pages',
      name: 'reading_habit_title',
      desc: '',
      args: [],
    );
  }

  /// `Enhance your knowledge and skills by reading 10 pages daily.`
  String get reading_habit_desc {
    return Intl.message(
      'Enhance your knowledge and skills by reading 10 pages daily.',
      name: 'reading_habit_desc',
      desc: '',
      args: [],
    );
  }

  /// `Read 10 pages daily to develop a habit of continuous learning.`
  String get reading_habit_goal_desc {
    return Intl.message(
      'Read 10 pages daily to develop a habit of continuous learning.',
      name: 'reading_habit_goal_desc',
      desc: '',
      args: [],
    );
  }

  /// `2-Hour Focused Study`
  String get study_habit_title {
    return Intl.message(
      '2-Hour Focused Study',
      name: 'study_habit_title',
      desc: '',
      args: [],
    );
  }

  /// `Improve learning efficiency by studying for 2 focused hours every evening.`
  String get study_habit_desc {
    return Intl.message(
      'Improve learning efficiency by studying for 2 focused hours every evening.',
      name: 'study_habit_desc',
      desc: '',
      args: [],
    );
  }

  /// `Focus on studying for 2 hours every evening at 7 PM to boost knowledge.`
  String get study_habit_goal_desc {
    return Intl.message(
      'Focus on studying for 2 hours every evening at 7 PM to boost knowledge.',
      name: 'study_habit_goal_desc',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least one to add`
  String get no_habit_item_selected {
    return Intl.message(
      'Please select at least one to add',
      name: 'no_habit_item_selected',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get habits`
  String get cannot_get_any_habit {
    return Intl.message(
      'Failed to get habits',
      name: 'cannot_get_any_habit',
      desc: '',
      args: [],
    );
  }

  /// `Cannot get the habit with name: {name}`
  String cannot_get_habit_with_name(Object name) {
    return Intl.message(
      'Cannot get the habit with name: $name',
      name: 'cannot_get_habit_with_name',
      desc: '',
      args: [name],
    );
  }

  /// `All`
  String get all_selection {
    return Intl.message(
      'All',
      name: 'all_selection',
      desc: '',
      args: [],
    );
  }

  /// `Awesome! You've maintained a {count} day streak`
  String default_short_streak(Object count) {
    return Intl.message(
      'Awesome! You\'ve maintained a $count day streak',
      name: 'default_short_streak',
      desc: '',
      args: [count],
    );
  }

  /// `Getting started! Complete your first day without missing!`
  String get streak_short_0 {
    return Intl.message(
      'Getting started! Complete your first day without missing!',
      name: 'streak_short_0',
      desc: '',
      args: [],
    );
  }

  /// `Great start! You've completed 1 day without missing!`
  String get streak_short_1 {
    return Intl.message(
      'Great start! You\'ve completed 1 day without missing!',
      name: 'streak_short_1',
      desc: '',
      args: [],
    );
  }

  /// `Keep it up! You've maintained 3 consecutive days!`
  String get streak_short_3 {
    return Intl.message(
      'Keep it up! You\'ve maintained 3 consecutive days!',
      name: 'streak_short_3',
      desc: '',
      args: [],
    );
  }

  /// `Excellent! You've reached 7 days in a row!`
  String get streak_short_7 {
    return Intl.message(
      'Excellent! You\'ve reached 7 days in a row!',
      name: 'streak_short_7',
      desc: '',
      args: [],
    );
  }

  /// `Awesome! You've maintained a {count} day streak`
  String default_medium_streak(Object count) {
    return Intl.message(
      'Awesome! You\'ve maintained a $count day streak',
      name: 'default_medium_streak',
      desc: '',
      args: [count],
    );
  }

  /// `Amazing! You've kept a 10-day streak going!`
  String get streak_medium_10 {
    return Intl.message(
      'Amazing! You\'ve kept a 10-day streak going!',
      name: 'streak_medium_10',
      desc: '',
      args: [],
    );
  }

  /// `Keep pushing! You've achieved 15 days continuously!`
  String get streak_medium_15 {
    return Intl.message(
      'Keep pushing! You\'ve achieved 15 days continuously!',
      name: 'streak_medium_15',
      desc: '',
      args: [],
    );
  }

  /// `You're awesome! Maintained 30 days straight!`
  String get streak_medium_30 {
    return Intl.message(
      'You\'re awesome! Maintained 30 days straight!',
      name: 'streak_medium_30',
      desc: '',
      args: [],
    );
  }

  /// `Awesome! You've maintained a {count} day streak`
  String default_long_streak(Object count) {
    return Intl.message(
      'Awesome! You\'ve maintained a $count day streak',
      name: 'default_long_streak',
      desc: '',
      args: [count],
    );
  }

  /// `Incredible! You're on a 40-day streak!`
  String get streak_long_40 {
    return Intl.message(
      'Incredible! You\'re on a 40-day streak!',
      name: 'streak_long_40',
      desc: '',
      args: [],
    );
  }

  /// `Unbelievable! You've hit a 60-day streak!`
  String get streak_long_60 {
    return Intl.message(
      'Unbelievable! You\'ve hit a 60-day streak!',
      name: 'streak_long_60',
      desc: '',
      args: [],
    );
  }

  /// `Fantastic! You've kept a 100-day streak!`
  String get streak_long_100 {
    return Intl.message(
      'Fantastic! You\'ve kept a 100-day streak!',
      name: 'streak_long_100',
      desc: '',
      args: [],
    );
  }

  /// `Unbelievable! You've kept a 150-day streak!`
  String get streak_very_long_150 {
    return Intl.message(
      'Unbelievable! You\'ve kept a 150-day streak!',
      name: 'streak_very_long_150',
      desc: '',
      args: [],
    );
  }

  /// `Admirable! You've maintained a 200-day streak!`
  String get streak_very_long_200 {
    return Intl.message(
      'Admirable! You\'ve maintained a 200-day streak!',
      name: 'streak_very_long_200',
      desc: '',
      args: [],
    );
  }

  /// `You're a hero! Achieved a 365-day streak!`
  String get streak_very_long_365 {
    return Intl.message(
      'You\'re a hero! Achieved a 365-day streak!',
      name: 'streak_very_long_365',
      desc: '',
      args: [],
    );
  }

  /// `Drinking Time`
  String get water_reminder_title {
    return Intl.message(
      'Drinking Time',
      name: 'water_reminder_title',
      desc: '',
      args: [],
    );
  }

  /// `Running Time`
  String get run_reminder_title {
    return Intl.message(
      'Running Time',
      name: 'run_reminder_title',
      desc: '',
      args: [],
    );
  }

  /// `Exercise Time`
  String get exercise_reminder_title {
    return Intl.message(
      'Exercise Time',
      name: 'exercise_reminder_title',
      desc: '',
      args: [],
    );
  }

  /// `Mediation Time`
  String get meditation_reminder_title {
    return Intl.message(
      'Mediation Time',
      name: 'meditation_reminder_title',
      desc: '',
      args: [],
    );
  }

  /// `Reading Time`
  String get reading_reminder_title {
    return Intl.message(
      'Reading Time',
      name: 'reading_reminder_title',
      desc: '',
      args: [],
    );
  }

  /// `Study Time`
  String get study_reminder_title {
    return Intl.message(
      'Study Time',
      name: 'study_reminder_title',
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
