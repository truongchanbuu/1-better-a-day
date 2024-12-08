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

  static String m0(completedTasks, totalTasks) =>
      "${completedTasks}/${totalTasks}";

  static String m1(count) =>
      "${Intl.plural(count, zero: 'No habits', one: '1 habit', other: '${count} habits')}";

  static String m2(value) => "You are ${value}% on your way";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accept_button": MessageLookupByLibrary.simpleMessage("Accept"),
        "account_exists_with_different_credential":
            MessageLookupByLibrary.simpleMessage(
                "Account exists with different credentials."),
        "account_section": MessageLookupByLibrary.simpleMessage("Account"),
        "achievement_done": MessageLookupByLibrary.simpleMessage("Achievement"),
        "add_habit": MessageLookupByLibrary.simpleMessage("Add Habit"),
        "add_water_button": MessageLookupByLibrary.simpleMessage("Add 250ML"),
        "afternoon_tile": MessageLookupByLibrary.simpleMessage("Afternoon"),
        "age_field": MessageLookupByLibrary.simpleMessage("Age"),
        "all_detail_history":
            MessageLookupByLibrary.simpleMessage("All Detail History"),
        "all_habits": MessageLookupByLibrary.simpleMessage("All Habits"),
        "app_info_section":
            MessageLookupByLibrary.simpleMessage("Additional Information"),
        "authentication_choice":
            MessageLookupByLibrary.simpleMessage("Sign in/Sign up"),
        "birth_date": MessageLookupByLibrary.simpleMessage("Birthdate"),
        "cancel_button": MessageLookupByLibrary.simpleMessage("Cancel"),
        "confirm_password_field":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "current_distance":
            MessageLookupByLibrary.simpleMessage("Current Distance"),
        "current_streak": MessageLookupByLibrary.simpleMessage("Streak"),
        "dark_theme": MessageLookupByLibrary.simpleMessage("Dark Theme"),
        "date_title": MessageLookupByLibrary.simpleMessage("Date"),
        "dawn_tile": MessageLookupByLibrary.simpleMessage("Dawn"),
        "delete_button": MessageLookupByLibrary.simpleMessage("Delete"),
        "detail_section": MessageLookupByLibrary.simpleMessage("Detail"),
        "display_name": MessageLookupByLibrary.simpleMessage("Display Name"),
        "done_tasks": m0,
        "duration_title": MessageLookupByLibrary.simpleMessage("Duration"),
        "dusk_tile": MessageLookupByLibrary.simpleMessage("Dusk"),
        "edit_button": MessageLookupByLibrary.simpleMessage("Edit"),
        "email_already_in_use": MessageLookupByLibrary.simpleMessage(
            "An account already exists for that email."),
        "empty_field": MessageLookupByLibrary.simpleMessage(
            "Please do not empty the field"),
        "end_date": MessageLookupByLibrary.simpleMessage("End Date"),
        "english_choice": MessageLookupByLibrary.simpleMessage("English"),
        "failure_title": MessageLookupByLibrary.simpleMessage("Failure"),
        "find_button": MessageLookupByLibrary.simpleMessage("Find"),
        "gender_field": MessageLookupByLibrary.simpleMessage("Gender"),
        "general_section": MessageLookupByLibrary.simpleMessage("General"),
        "habit_detail": MessageLookupByLibrary.simpleMessage("Habit Details"),
        "habits": m1,
        "help_tile": MessageLookupByLibrary.simpleMessage("Help"),
        "history_section": MessageLookupByLibrary.simpleMessage("History"),
        "imperial_unit": MessageLookupByLibrary.simpleMessage("Imperial Unit"),
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
        "light_theme": MessageLookupByLibrary.simpleMessage("Light Theme"),
        "loading_title": MessageLookupByLibrary.simpleMessage("Loading..."),
        "login_failure_title":
            MessageLookupByLibrary.simpleMessage("Login Failure"),
        "login_success_title":
            MessageLookupByLibrary.simpleMessage("Login Success"),
        "logout_button": MessageLookupByLibrary.simpleMessage("Log out"),
        "manage_account_choice":
            MessageLookupByLibrary.simpleMessage("Manage Account"),
        "mark_as_done": MessageLookupByLibrary.simpleMessage("Mark as done"),
        "mark_as_pause": MessageLookupByLibrary.simpleMessage("Mark as pause"),
        "measurement_unit_title":
            MessageLookupByLibrary.simpleMessage("Measurement Unit"),
        "metric_unit": MessageLookupByLibrary.simpleMessage("Metric Unit"),
        "mood_title": MessageLookupByLibrary.simpleMessage("Mood"),
        "no_date_selected":
            MessageLookupByLibrary.simpleMessage("No Date Selected"),
        "not_allow_track": MessageLookupByLibrary.simpleMessage(
            "We don\'t have permission to track your distance"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "on_your_way": m2,
        "operation_not_allowed": MessageLookupByLibrary.simpleMessage(
            "Operation is not allowed. Please contact support."),
        "out_of_range":
            MessageLookupByLibrary.simpleMessage("The number is out of range"),
        "password_field": MessageLookupByLibrary.simpleMessage("Password"),
        "passwords_do_not_match":
            MessageLookupByLibrary.simpleMessage("Password does not match"),
        "pause_tracking":
            MessageLookupByLibrary.simpleMessage("Pause Tracking"),
        "personal_info_section":
            MessageLookupByLibrary.simpleMessage("Personal Information"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Phone"),
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
        "time_of_day_section":
            MessageLookupByLibrary.simpleMessage("Time of day"),
        "today_tasks": MessageLookupByLibrary.simpleMessage("Today Tasks"),
        "total_distance":
            MessageLookupByLibrary.simpleMessage("Total Distance"),
        "tracker_section": MessageLookupByLibrary.simpleMessage("Tracker"),
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
        "wrong_password": MessageLookupByLibrary.simpleMessage(
            "Incorrect password, please try again.")
      };
}
