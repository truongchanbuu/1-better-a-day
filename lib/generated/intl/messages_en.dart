// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) =>
      "${Intl.plural(count, zero: 'Achieved: 0', one: 'Achieved: 1', other: 'Achieved: ${count}')}";

  static String m1(selection, percentageValue) => "${Intl.select(selection, {
            'positive': '+${percentageValue}% compared to last week',
            'negative': '-${percentageValue}% compared to last week',
            'neutral': 'No change from last week',
            'other': 'No change from last week',
          })}";

  static String m2(completedTasks, totalTasks) =>
      "${completedTasks}/${totalTasks}";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'Failed: 0', one: 'Failed: 1', other: 'Failed: ${count}')}";

  static String m4(count) =>
      "${Intl.plural(count, zero: 'No habits', one: '1 habit', other: '${count} habits')}";

  static String m5(count) =>
      "${Intl.plural(count, zero: 'In Progress: 0', one: 'In Progress: 1', other: 'In Progress: ${count}')}";

  static String m6(count) =>
      "${Intl.plural(count, zero: ' \"Today\" ', one: 'A day ago', other: 'Last ${count} days')}";

  static String m7(value) => "You are ${value}% on your way";

  static String m8(count) =>
      "${Intl.plural(count, zero: 'Paused: 0', one: 'Paused: 1', other: 'Paused: ${count}')}";

  static String m9(count) =>
      "${Intl.plural(count, zero: 'No achievements', one: '1 achievement', other: '${count} achievements')}";

  static String m10(count) =>
      "${Intl.plural(count, zero: 'No Streak', one: '1 Streak', other: '${count} Streaks')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accept_button": MessageLookupByLibrary.simpleMessage("Accept"),
        "account_exists_with_different_credential":
            MessageLookupByLibrary.simpleMessage(
                "Account exists with different credentials."),
        "account_section": MessageLookupByLibrary.simpleMessage("Account"),
        "achieved": m0,
        "achieved_habit":
            MessageLookupByLibrary.simpleMessage("Achieved Habit"),
        "achieved_statistic_page":
            MessageLookupByLibrary.simpleMessage("Achieved"),
        "achievement_done": MessageLookupByLibrary.simpleMessage("Achievement"),
        "active_habit": MessageLookupByLibrary.simpleMessage("Active Habit"),
        "active_statistic_page": MessageLookupByLibrary.simpleMessage("Active"),
        "add_habit": MessageLookupByLibrary.simpleMessage("Add Habit"),
        "add_water_button": MessageLookupByLibrary.simpleMessage("Add 250ML"),
        "afternoon_tile": MessageLookupByLibrary.simpleMessage("Afternoon"),
        "age_field": MessageLookupByLibrary.simpleMessage("Age"),
        "all_detail_history":
            MessageLookupByLibrary.simpleMessage("All Detail History"),
        "all_habits": MessageLookupByLibrary.simpleMessage("All Habits"),
        "all_statistic_page": MessageLookupByLibrary.simpleMessage("All"),
        "app_info_section":
            MessageLookupByLibrary.simpleMessage("Additional Information"),
        "authentication_choice":
            MessageLookupByLibrary.simpleMessage("Sign in/Sign up"),
        "birth_date": MessageLookupByLibrary.simpleMessage("Birthdate"),
        "cancel_button": MessageLookupByLibrary.simpleMessage("Cancel"),
        "category_distribution":
            MessageLookupByLibrary.simpleMessage("Category Distribution"),
        "change_from_last_week": m1,
        "completion_rate":
            MessageLookupByLibrary.simpleMessage("Completion Rate"),
        "confirm_password_field":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "current_distance":
            MessageLookupByLibrary.simpleMessage("Current Distance"),
        "dark_theme": MessageLookupByLibrary.simpleMessage("Dark Theme"),
        "date_title": MessageLookupByLibrary.simpleMessage("Date"),
        "dawn_tile": MessageLookupByLibrary.simpleMessage("Dawn"),
        "delete_button": MessageLookupByLibrary.simpleMessage("Delete"),
        "detail_section": MessageLookupByLibrary.simpleMessage("Detail"),
        "display_name": MessageLookupByLibrary.simpleMessage("Display Name"),
        "done_tasks": m2,
        "duration_title": MessageLookupByLibrary.simpleMessage("Duration"),
        "dusk_tile": MessageLookupByLibrary.simpleMessage("Dusk"),
        "edit_button": MessageLookupByLibrary.simpleMessage("Edit"),
        "email_already_in_use": MessageLookupByLibrary.simpleMessage(
            "An account already exists for that email."),
        "empty_field": MessageLookupByLibrary.simpleMessage(
            "Please do not empty the field"),
        "end_date": MessageLookupByLibrary.simpleMessage("End Date"),
        "english_choice": MessageLookupByLibrary.simpleMessage("English"),
        "failed": m3,
        "failed_habit": MessageLookupByLibrary.simpleMessage("Failed Habit"),
        "failed_statistic_page": MessageLookupByLibrary.simpleMessage("Failed"),
        "failure_title": MessageLookupByLibrary.simpleMessage("Failure"),
        "find_button": MessageLookupByLibrary.simpleMessage("Find"),
        "gender_field": MessageLookupByLibrary.simpleMessage("Gender"),
        "general_section": MessageLookupByLibrary.simpleMessage("General"),
        "habit_detail": MessageLookupByLibrary.simpleMessage("Habit Details"),
        "habit_name": MessageLookupByLibrary.simpleMessage("Habit Name"),
        "habit_status_distribution":
            MessageLookupByLibrary.simpleMessage("Status Distribution"),
        "habits": m4,
        "help_tile": MessageLookupByLibrary.simpleMessage("Help"),
        "history_section": MessageLookupByLibrary.simpleMessage("History"),
        "imperial_unit": MessageLookupByLibrary.simpleMessage("Imperial Unit"),
        "in_progress": m5,
        "in_progress_habit":
            MessageLookupByLibrary.simpleMessage("In Progress Habit"),
        "invalid_age":
            MessageLookupByLibrary.simpleMessage("Please select a valid age"),
        "invalid_credential":
            MessageLookupByLibrary.simpleMessage("Invalid email or password."),
        "invalid_email": MessageLookupByLibrary.simpleMessage(
            "Email is not valid or badly formatted."),
        "invalid_form": MessageLookupByLibrary.simpleMessage(
            "Please check your information again"),
        "invalid_password": MessageLookupByLibrary.simpleMessage(
            "Password must have at least 6 characters"),
        "invalid_phone":
            MessageLookupByLibrary.simpleMessage("Phone number is not valid"),
        "invalid_verification_code": MessageLookupByLibrary.simpleMessage(
            "The credential verification code received is invalid."),
        "invalid_verification_id": MessageLookupByLibrary.simpleMessage(
            "The credential verification ID received is invalid."),
        "language_tile": MessageLookupByLibrary.simpleMessage("Language"),
        "last_n_day": m6,
        "light_theme": MessageLookupByLibrary.simpleMessage("Light Theme"),
        "loading_title": MessageLookupByLibrary.simpleMessage("Loading..."),
        "login_failure_title":
            MessageLookupByLibrary.simpleMessage("Login Failure"),
        "login_success_title":
            MessageLookupByLibrary.simpleMessage("Login Success"),
        "logout_button": MessageLookupByLibrary.simpleMessage("Log out"),
        "longest_streak":
            MessageLookupByLibrary.simpleMessage("Longest Streak"),
        "manage_account_choice":
            MessageLookupByLibrary.simpleMessage("Manage Account"),
        "mark_as_done": MessageLookupByLibrary.simpleMessage("Mark as done"),
        "mark_as_pause": MessageLookupByLibrary.simpleMessage("Mark as pause"),
        "measurement_unit_title":
            MessageLookupByLibrary.simpleMessage("Measurement Unit"),
        "metric_unit": MessageLookupByLibrary.simpleMessage("Metric Unit"),
        "monthly_process_section":
            MessageLookupByLibrary.simpleMessage("Monthly"),
        "mood_title": MessageLookupByLibrary.simpleMessage("Mood"),
        "next_habits_button": MessageLookupByLibrary.simpleMessage("Next Page"),
        "no_date_selected":
            MessageLookupByLibrary.simpleMessage("No Date Selected"),
        "not_allow_track": MessageLookupByLibrary.simpleMessage(
            "We don\'t have permission to track your distance"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "on_your_way": m7,
        "operation_not_allowed": MessageLookupByLibrary.simpleMessage(
            "Operation is not allowed. Please contact support."),
        "out_of_range":
            MessageLookupByLibrary.simpleMessage("The number is out of range"),
        "overall_completion_rate":
            MessageLookupByLibrary.simpleMessage("Overall Completion Rate"),
        "password_field": MessageLookupByLibrary.simpleMessage("Password"),
        "passwords_do_not_match":
            MessageLookupByLibrary.simpleMessage("Password does not match"),
        "pause_statistic_page": MessageLookupByLibrary.simpleMessage("Pause"),
        "pause_tracking":
            MessageLookupByLibrary.simpleMessage("Pause Tracking"),
        "paused": m8,
        "paused_habit": MessageLookupByLibrary.simpleMessage("Paused Habit"),
        "personal_info_section":
            MessageLookupByLibrary.simpleMessage("Personal Information"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Phone"),
        "previous_habits_button":
            MessageLookupByLibrary.simpleMessage("Previous Page"),
        "progress_section": MessageLookupByLibrary.simpleMessage("Progress"),
        "re_auth_with_email":
            MessageLookupByLibrary.simpleMessage("Re-authenticate with Email"),
        "re_auth_with_google":
            MessageLookupByLibrary.simpleMessage("Re-authenticate with Google"),
        "recovery_description": MessageLookupByLibrary.simpleMessage(
            "An reset-password mail will be sent to your email"),
        "remove_water_button":
            MessageLookupByLibrary.simpleMessage("Remove 250ML"),
        "reset_password":
            MessageLookupByLibrary.simpleMessage("Reset Password"),
        "searching_title": MessageLookupByLibrary.simpleMessage("Searching..."),
        "select_button": MessageLookupByLibrary.simpleMessage("Select"),
        "select_date_title":
            MessageLookupByLibrary.simpleMessage("Select Date"),
        "select_range_date_title":
            MessageLookupByLibrary.simpleMessage("Select Date Range"),
        "send_button": MessageLookupByLibrary.simpleMessage("Send"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "show_less": MessageLookupByLibrary.simpleMessage("Show less"),
        "show_more": MessageLookupByLibrary.simpleMessage("Show More"),
        "start_date": MessageLookupByLibrary.simpleMessage("Start Date"),
        "start_tracking":
            MessageLookupByLibrary.simpleMessage("Start Tracking"),
        "statistic_section": MessageLookupByLibrary.simpleMessage("Statistics"),
        "status_title": MessageLookupByLibrary.simpleMessage("Status"),
        "success_title": MessageLookupByLibrary.simpleMessage("Success"),
        "target_title": MessageLookupByLibrary.simpleMessage("Target"),
        "term_and_condition_statement": MessageLookupByLibrary.simpleMessage(
            "By signing in/signing up, you accept our Terms and Conditions and consent to our Privacy Policy"),
        "terms_and_conditions":
            MessageLookupByLibrary.simpleMessage("Terms & Conditions"),
        "theme_tile": MessageLookupByLibrary.simpleMessage("Theme"),
        "time_based_progress":
            MessageLookupByLibrary.simpleMessage("Time-Based Progress"),
        "time_of_day_section":
            MessageLookupByLibrary.simpleMessage("Time of day"),
        "today_tasks": MessageLookupByLibrary.simpleMessage("Today Tasks"),
        "total_achievement": m9,
        "total_distance":
            MessageLookupByLibrary.simpleMessage("Total Distance"),
        "total_habit": MessageLookupByLibrary.simpleMessage("Total Habit"),
        "total_streak": m10,
        "tracker_section": MessageLookupByLibrary.simpleMessage("Tracker"),
        "trend_section": MessageLookupByLibrary.simpleMessage("Trend"),
        "try_again":
            MessageLookupByLibrary.simpleMessage("Please try again later"),
        "unknown_exception": MessageLookupByLibrary.simpleMessage(
            "An unknown exception occurred."),
        "update_failure_title":
            MessageLookupByLibrary.simpleMessage("Update Failure"),
        "update_success_title":
            MessageLookupByLibrary.simpleMessage("Update Success"),
        "user_disabled": MessageLookupByLibrary.simpleMessage(
            "This user has been disabled. Please contact support for help."),
        "user_not_found": MessageLookupByLibrary.simpleMessage(
            "Email is not found, please create an account."),
        "verify_email_sent": MessageLookupByLibrary.simpleMessage(
            "A mail has been sent to your new email"),
        "vietnamese_choice": MessageLookupByLibrary.simpleMessage("Vietnamese"),
        "warning_title": MessageLookupByLibrary.simpleMessage("Warning"),
        "weak_password": MessageLookupByLibrary.simpleMessage(
            "Please enter a stronger password."),
        "weekly_process_section":
            MessageLookupByLibrary.simpleMessage("Weekly"),
        "wrong_password": MessageLookupByLibrary.simpleMessage(
            "Incorrect password, please try again.")
      };
}
