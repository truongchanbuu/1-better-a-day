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

  static String m1(count) => "Add ${count}ML";

  static String m2(name) => "Cannot get the habit with name: ${name}";

  static String m3(selection, percentageValue) => "${Intl.select(selection, {
            'positive': '+${percentageValue}% compared to last week',
            'negative': '-${percentageValue}% compared to last week',
            'neutral': 'No change from last week',
            'other': 'No change from last week',
          })}";

  static String m4(count) => "${count}% Completed";

  static String m5(count) =>
      "${Intl.plural(count, zero: 'No completion', one: '1 completion', other: '${count} completions')}";

  static String m6(count) =>
      "Awesome! You\'ve maintained a ${count} day streak";

  static String m7(count) =>
      "Awesome! You\'ve maintained a ${count} day streak";

  static String m8(count) =>
      "Awesome! You\'ve maintained a ${count} day streak";

  static String m9(completedTasks, totalTasks) =>
      "${completedTasks}/${totalTasks}";

  static String m10(count) =>
      "${Intl.plural(count, zero: 'Failed: 0', one: 'Failed: 1', other: 'Failed: ${count}')}";

  static String m11(count) =>
      "${Intl.plural(count, zero: 'No habits', one: '1 habit', other: '${count} habits')}";

  static String m12(count) =>
      "${Intl.plural(count, zero: 'In Progress: 0', one: 'In Progress: 1', other: 'In Progress: ${count}')}";

  static String m13(count) =>
      "${Intl.plural(count, zero: ' \"Today\" ', one: 'A day ago', other: 'Last ${count} days')}";

  static String m14(value) => "You are ${value}% on your way";

  static String m15(count, total, time) =>
      "Progress: ${count}/${total} ${time}";

  static String m16(count) =>
      "${Intl.plural(count, zero: 'No participant', one: '1 participant', other: '${count} participants')}";

  static String m17(count) =>
      "${Intl.plural(count, zero: 'Paused: 0', one: 'Paused: 1', other: 'Paused: ${count}')}";

  static String m18(count) => "Remove ${count}ssucML";

  static String m19(score) =>
      "Good SMART goal with minor areas for improvement. Score: ${score}%";

  static String m20(score) =>
      "Goal needs work in several areas to be truly SMART. Score: ${score}%";

  static String m21(score) =>
      "Goal needs significant improvement to meet SMART criteria. Score: ${score}%";

  static String m22(count) => "Total: ${count}";

  static String m23(count) =>
      "${Intl.plural(count, zero: 'No Achievements', one: '1 Achievement', other: '${count} Achievements')}";

  static String m24(count) =>
      "${Intl.plural(count, zero: 'No Streak', one: '1 Streak', other: '${count} Streaks')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accept_button": MessageLookupByLibrary.simpleMessage("Accept"),
        "account_exists_with_different_credential":
            MessageLookupByLibrary.simpleMessage(
                "Account exists with different credentials."),
        "account_section": MessageLookupByLibrary.simpleMessage("Account"),
        "achievable_desc": MessageLookupByLibrary.simpleMessage(
            "Realistic and attainable within your current resources and constraints."),
        "achievable_suggestion_1": MessageLookupByLibrary.simpleMessage(
            "Consider making the goal more achievable by avoiding absolute terms"),
        "achievable_suggestion_2": MessageLookupByLibrary.simpleMessage(
            "Avoid unclear goal that cannot measure or achieve"),
        "achievable_title": MessageLookupByLibrary.simpleMessage("Achievable"),
        "achieved": m0,
        "achieved_habit":
            MessageLookupByLibrary.simpleMessage("Achieved Habit"),
        "achieved_statistic_page":
            MessageLookupByLibrary.simpleMessage("Achieved"),
        "achievement_done": MessageLookupByLibrary.simpleMessage("Achievement"),
        "action_creative_build": MessageLookupByLibrary.simpleMessage("build"),
        "action_creative_compose":
            MessageLookupByLibrary.simpleMessage("compose"),
        "action_creative_create":
            MessageLookupByLibrary.simpleMessage("create"),
        "action_creative_design":
            MessageLookupByLibrary.simpleMessage("design"),
        "action_creative_develop":
            MessageLookupByLibrary.simpleMessage("develop"),
        "action_creative_draw": MessageLookupByLibrary.simpleMessage("draw"),
        "action_creative_paint": MessageLookupByLibrary.simpleMessage("paint"),
        "action_creative_write": MessageLookupByLibrary.simpleMessage("write"),
        "action_exercise_gym":
            MessageLookupByLibrary.simpleMessage("go to gym"),
        "action_exercise_jog": MessageLookupByLibrary.simpleMessage("jog"),
        "action_exercise_run": MessageLookupByLibrary.simpleMessage("run"),
        "action_exercise_stretch":
            MessageLookupByLibrary.simpleMessage("stretch"),
        "action_exercise_swim": MessageLookupByLibrary.simpleMessage("swim"),
        "action_exercise_walk": MessageLookupByLibrary.simpleMessage("walk"),
        "action_exercise_workout":
            MessageLookupByLibrary.simpleMessage("workout"),
        "action_exercise_yoga":
            MessageLookupByLibrary.simpleMessage("practice yoga"),
        "action_health_breathe":
            MessageLookupByLibrary.simpleMessage("breathe"),
        "action_health_drink": MessageLookupByLibrary.simpleMessage("drink"),
        "action_health_eat": MessageLookupByLibrary.simpleMessage("eat"),
        "action_health_meditate":
            MessageLookupByLibrary.simpleMessage("meditate"),
        "action_health_relax": MessageLookupByLibrary.simpleMessage("relax"),
        "action_health_rest": MessageLookupByLibrary.simpleMessage("rest"),
        "action_health_sleep": MessageLookupByLibrary.simpleMessage("sleep"),
        "action_improvement_decrease":
            MessageLookupByLibrary.simpleMessage("decrease"),
        "action_improvement_enhance":
            MessageLookupByLibrary.simpleMessage("enhance"),
        "action_improvement_improve":
            MessageLookupByLibrary.simpleMessage("improve"),
        "action_improvement_increase":
            MessageLookupByLibrary.simpleMessage("increase"),
        "action_improvement_optimize":
            MessageLookupByLibrary.simpleMessage("optimize"),
        "action_improvement_reduce":
            MessageLookupByLibrary.simpleMessage("reduce"),
        "action_improvement_upgrade":
            MessageLookupByLibrary.simpleMessage("upgrade"),
        "action_learning_learn": MessageLookupByLibrary.simpleMessage("learn"),
        "action_learning_master":
            MessageLookupByLibrary.simpleMessage("master"),
        "action_learning_practice":
            MessageLookupByLibrary.simpleMessage("practice"),
        "action_learning_read": MessageLookupByLibrary.simpleMessage("read"),
        "action_learning_research":
            MessageLookupByLibrary.simpleMessage("research"),
        "action_learning_revise":
            MessageLookupByLibrary.simpleMessage("revise"),
        "action_learning_study": MessageLookupByLibrary.simpleMessage("study"),
        "action_learning_write": MessageLookupByLibrary.simpleMessage("write"),
        "action_productivity_accomplish":
            MessageLookupByLibrary.simpleMessage("accomplish"),
        "action_productivity_achieve":
            MessageLookupByLibrary.simpleMessage("achieve"),
        "action_productivity_complete":
            MessageLookupByLibrary.simpleMessage("complete"),
        "action_productivity_continue":
            MessageLookupByLibrary.simpleMessage("continue"),
        "action_productivity_do": MessageLookupByLibrary.simpleMessage("do"),
        "action_productivity_finish":
            MessageLookupByLibrary.simpleMessage("finish"),
        "action_productivity_start":
            MessageLookupByLibrary.simpleMessage("start"),
        "action_productivity_work":
            MessageLookupByLibrary.simpleMessage("work on"),
        "action_social_call": MessageLookupByLibrary.simpleMessage("call"),
        "action_social_connect":
            MessageLookupByLibrary.simpleMessage("connect with"),
        "action_social_email": MessageLookupByLibrary.simpleMessage("email"),
        "action_social_help": MessageLookupByLibrary.simpleMessage("help"),
        "action_social_meet": MessageLookupByLibrary.simpleMessage("meet"),
        "action_social_spend":
            MessageLookupByLibrary.simpleMessage("spend time with"),
        "action_social_text": MessageLookupByLibrary.simpleMessage("text"),
        "action_social_visit": MessageLookupByLibrary.simpleMessage("visit"),
        "action_time_allocate":
            MessageLookupByLibrary.simpleMessage("allocate"),
        "action_time_limit": MessageLookupByLibrary.simpleMessage("limit"),
        "action_time_manage": MessageLookupByLibrary.simpleMessage("manage"),
        "action_time_organize":
            MessageLookupByLibrary.simpleMessage("organize"),
        "action_time_plan": MessageLookupByLibrary.simpleMessage("plan"),
        "action_time_schedule":
            MessageLookupByLibrary.simpleMessage("schedule"),
        "action_time_spend": MessageLookupByLibrary.simpleMessage("spend"),
        "action_tracking_analyze":
            MessageLookupByLibrary.simpleMessage("analyze"),
        "action_tracking_count": MessageLookupByLibrary.simpleMessage("count"),
        "action_tracking_log": MessageLookupByLibrary.simpleMessage("log"),
        "action_tracking_measure":
            MessageLookupByLibrary.simpleMessage("measure"),
        "action_tracking_monitor":
            MessageLookupByLibrary.simpleMessage("monitor"),
        "action_tracking_record":
            MessageLookupByLibrary.simpleMessage("record"),
        "action_tracking_track": MessageLookupByLibrary.simpleMessage("track"),
        "active_button": MessageLookupByLibrary.simpleMessage("Active"),
        "active_habit": MessageLookupByLibrary.simpleMessage("Active Habit"),
        "active_statistic_page": MessageLookupByLibrary.simpleMessage("Active"),
        "add_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Goal Description (Provides details about the specific goal related to that habit)"),
        "add_habit": MessageLookupByLibrary.simpleMessage("Add Habit"),
        "add_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Habit Description (The purpose and benefits of the habit)"),
        "add_habit_manually":
            MessageLookupByLibrary.simpleMessage("Create habit yourself"),
        "add_habit_not_enough_info": MessageLookupByLibrary.simpleMessage(
            "Please provide at least one in habit name, description or brief goal to generate accurate SMART goal"),
        "add_habit_with_few_words_option":
            MessageLookupByLibrary.simpleMessage("Create habit with few words"),
        "add_reminder": MessageLookupByLibrary.simpleMessage("Add reminder"),
        "add_success": MessageLookupByLibrary.simpleMessage("Add successfully"),
        "add_water_button": m1,
        "add_your_own_habit":
            MessageLookupByLibrary.simpleMessage("Customize your own habit"),
        "additional_information":
            MessageLookupByLibrary.simpleMessage("Additional Information"),
        "afternoon_greeting":
            MessageLookupByLibrary.simpleMessage("Good Afternoon"),
        "afternoon_tile": MessageLookupByLibrary.simpleMessage("Afternoon"),
        "age_field": MessageLookupByLibrary.simpleMessage("Age"),
        "ai_habit_generate_page_title": MessageLookupByLibrary.simpleMessage(
            "Get SMART habit with few word"),
        "all_achievements_tab":
            MessageLookupByLibrary.simpleMessage("All Achievements"),
        "all_detail_history":
            MessageLookupByLibrary.simpleMessage("All Detail History"),
        "all_habits": MessageLookupByLibrary.simpleMessage("All Habits"),
        "all_selection": MessageLookupByLibrary.simpleMessage("All"),
        "all_statistic_page": MessageLookupByLibrary.simpleMessage("All"),
        "ask_ai_button": MessageLookupByLibrary.simpleMessage(
            "Get SMART Goal Recommendation"),
        "ask_ai_field": MessageLookupByLibrary.simpleMessage(
            "Tell me what you want to do..."),
        "attendance_button":
            MessageLookupByLibrary.simpleMessage("Start this Challenge"),
        "authentication_choice":
            MessageLookupByLibrary.simpleMessage("Sign in/Sign up"),
        "author_aristotle": MessageLookupByLibrary.simpleMessage("Aristotle"),
        "author_dwayne_johnson":
            MessageLookupByLibrary.simpleMessage("Dwayne Johnson"),
        "author_james_clear":
            MessageLookupByLibrary.simpleMessage("James Clear"),
        "avg_time": MessageLookupByLibrary.simpleMessage("Average Time"),
        "best_time": MessageLookupByLibrary.simpleMessage("Best Time"),
        "birth_date": MessageLookupByLibrary.simpleMessage("Birthdate"),
        "cancel_button": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cannot_generate_habit":
            MessageLookupByLibrary.simpleMessage("Cannot generate habit"),
        "cannot_get_any_habit":
            MessageLookupByLibrary.simpleMessage("Failed to get habits"),
        "cannot_get_any_history":
            MessageLookupByLibrary.simpleMessage("Cannot get any history"),
        "cannot_get_habit_with_name": m2,
        "cannot_store_history":
            MessageLookupByLibrary.simpleMessage("Cannot store history"),
        "cannot_update_habit":
            MessageLookupByLibrary.simpleMessage("Cannot update habit"),
        "category_based_completion_rate":
            MessageLookupByLibrary.simpleMessage("Category Based Completion"),
        "category_distribution":
            MessageLookupByLibrary.simpleMessage("Category Distribution"),
        "challenges_screen": MessageLookupByLibrary.simpleMessage("Challenges"),
        "change_from_last_week": m3,
        "cm_unit": MessageLookupByLibrary.simpleMessage("centimeters"),
        "collection_tab": MessageLookupByLibrary.simpleMessage("Collections"),
        "community_challenges":
            MessageLookupByLibrary.simpleMessage("Community Challenges"),
        "completed_progress": m4,
        "completion": m5,
        "completion_rate":
            MessageLookupByLibrary.simpleMessage("Completion Rate"),
        "compound_effect":
            MessageLookupByLibrary.simpleMessage("Compound Effect"),
        "compound_effect_description": MessageLookupByLibrary.simpleMessage(
            "Improving 1% each day will make you 37 times better after a year."),
        "confirm_password_field":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "create_new_challenge":
            MessageLookupByLibrary.simpleMessage("Create your own challenge"),
        "current_distance":
            MessageLookupByLibrary.simpleMessage("Current Distance"),
        "current_progress":
            MessageLookupByLibrary.simpleMessage("Current Progress"),
        "custom_unit": MessageLookupByLibrary.simpleMessage("custom"),
        "daily_completed": MessageLookupByLibrary.simpleMessage(
            "You completed this habit today"),
        "daily_paused": MessageLookupByLibrary.simpleMessage(
            "You delayed this habit today"),
        "dark_theme": MessageLookupByLibrary.simpleMessage("Dark Theme"),
        "date_title": MessageLookupByLibrary.simpleMessage("Date"),
        "dawn_tile": MessageLookupByLibrary.simpleMessage("Dawn"),
        "day_title": MessageLookupByLibrary.simpleMessage("Day"),
        "default_greeting": MessageLookupByLibrary.simpleMessage("Greetings"),
        "default_long_streak": m6,
        "default_medium_streak": m7,
        "default_short_streak": m8,
        "delete_button": MessageLookupByLibrary.simpleMessage("Delete"),
        "delete_title": MessageLookupByLibrary.simpleMessage(
            "Are you sure to delete this?"),
        "delete_warning":
            MessageLookupByLibrary.simpleMessage("This cannot be undone"),
        "detail_section": MessageLookupByLibrary.simpleMessage("Detail"),
        "discover_tab": MessageLookupByLibrary.simpleMessage("Discover"),
        "display_name": MessageLookupByLibrary.simpleMessage("Display Name"),
        "done_tasks": m9,
        "duration_title": MessageLookupByLibrary.simpleMessage("Duration"),
        "dusk_tile": MessageLookupByLibrary.simpleMessage("Dusk"),
        "edit_button": MessageLookupByLibrary.simpleMessage("Edit"),
        "email_already_in_use": MessageLookupByLibrary.simpleMessage(
            "An account already exists for that email."),
        "empty_field": MessageLookupByLibrary.simpleMessage(
            "Please do not empty the field"),
        "end_date": MessageLookupByLibrary.simpleMessage("End Date"),
        "end_value_must_be_greater_than_start":
            MessageLookupByLibrary.simpleMessage(
                "End value must be greater than start value"),
        "english_choice": MessageLookupByLibrary.simpleMessage("English"),
        "evening_greeting":
            MessageLookupByLibrary.simpleMessage("Good Evening"),
        "exercise_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Improve health and energy by doing exercise every morning"),
        "exercise_habit_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Do exercise 30 minutes every morning to enhance health and fitness"),
        "exercise_habit_title":
            MessageLookupByLibrary.simpleMessage("Do exercise every morning"),
        "failed": m10,
        "failed_habit": MessageLookupByLibrary.simpleMessage("Failed Habit"),
        "failed_rate": MessageLookupByLibrary.simpleMessage("Failed Rate"),
        "failed_statistic_page": MessageLookupByLibrary.simpleMessage("Failed"),
        "failure_title": MessageLookupByLibrary.simpleMessage("Failure"),
        "find_button": MessageLookupByLibrary.simpleMessage("Find"),
        "freq_daily": MessageLookupByLibrary.simpleMessage("Daily"),
        "freq_monthly": MessageLookupByLibrary.simpleMessage("Monthly"),
        "freq_yearly": MessageLookupByLibrary.simpleMessage("Yearly"),
        "friend_title": MessageLookupByLibrary.simpleMessage("friend"),
        "gender_field": MessageLookupByLibrary.simpleMessage("Gender"),
        "general_section": MessageLookupByLibrary.simpleMessage("General"),
        "generate_habit_button":
            MessageLookupByLibrary.simpleMessage("Generate Habit"),
        "get_preset_habit_option": MessageLookupByLibrary.simpleMessage(
            "Get some useful pre-set habit"),
        "go_home_button": MessageLookupByLibrary.simpleMessage("Go Home"),
        "goal_completion": MessageLookupByLibrary.simpleMessage("Completion"),
        "goal_count": MessageLookupByLibrary.simpleMessage("Count"),
        "goal_custom": MessageLookupByLibrary.simpleMessage("Custom"),
        "goal_distance": MessageLookupByLibrary.simpleMessage("Distance"),
        "goal_duration": MessageLookupByLibrary.simpleMessage("Duration"),
        "goal_recommend_with_no_internet_alert":
            MessageLookupByLibrary.simpleMessage(
                "Please note, the accuracy of your goal may be affected if there is no internet connection. Kindly check your connection and try again"),
        "goal_type": MessageLookupByLibrary.simpleMessage("Goal Type"),
        "goal_unit": MessageLookupByLibrary.simpleMessage("Goal Unit"),
        "goal_unit_value": MessageLookupByLibrary.simpleMessage("Value"),
        "habit_category":
            MessageLookupByLibrary.simpleMessage("Habit Category"),
        "habit_category_creativity":
            MessageLookupByLibrary.simpleMessage("Creativity"),
        "habit_category_education":
            MessageLookupByLibrary.simpleMessage("Education"),
        "habit_category_environmental":
            MessageLookupByLibrary.simpleMessage("Environmental"),
        "habit_category_field_hint":
            MessageLookupByLibrary.simpleMessage("Select a category"),
        "habit_category_finance":
            MessageLookupByLibrary.simpleMessage("Finance"),
        "habit_category_health": MessageLookupByLibrary.simpleMessage("Health"),
        "habit_category_lifestyle":
            MessageLookupByLibrary.simpleMessage("Lifestyle"),
        "habit_category_mindfulness":
            MessageLookupByLibrary.simpleMessage("Mindfulness"),
        "habit_category_nutrition":
            MessageLookupByLibrary.simpleMessage("Nutrition"),
        "habit_category_productivity":
            MessageLookupByLibrary.simpleMessage("Productivity"),
        "habit_category_social": MessageLookupByLibrary.simpleMessage("Social"),
        "habit_category_unknown":
            MessageLookupByLibrary.simpleMessage("Unknown"),
        "habit_day_performance":
            MessageLookupByLibrary.simpleMessage("Weekly Day Performance"),
        "habit_desc": MessageLookupByLibrary.simpleMessage("Habit Description"),
        "habit_detail": MessageLookupByLibrary.simpleMessage("Habit Details"),
        "habit_failure_reason_external_distractions":
            MessageLookupByLibrary.simpleMessage("External Distractions"),
        "habit_failure_reason_forgetfulness":
            MessageLookupByLibrary.simpleMessage("Forgetfulness"),
        "habit_failure_reason_health_issues":
            MessageLookupByLibrary.simpleMessage("Health Issues"),
        "habit_failure_reason_lack_of_motivation":
            MessageLookupByLibrary.simpleMessage("Lack of Motivation"),
        "habit_failure_reason_lack_of_resources":
            MessageLookupByLibrary.simpleMessage("Lack of Resources"),
        "habit_failure_reason_lack_of_time":
            MessageLookupByLibrary.simpleMessage("Lack of Time"),
        "habit_failure_reason_other":
            MessageLookupByLibrary.simpleMessage("Other"),
        "habit_failure_reason_procrastination":
            MessageLookupByLibrary.simpleMessage("Procrastination"),
        "habit_failure_reason_too_difficult":
            MessageLookupByLibrary.simpleMessage("Too Difficult"),
        "habit_failure_reason_unexpected_events":
            MessageLookupByLibrary.simpleMessage("Unexpected Events"),
        "habit_failure_reason_unknown":
            MessageLookupByLibrary.simpleMessage("Unknown"),
        "habit_frequency": MessageLookupByLibrary.simpleMessage("Frequency"),
        "habit_generated_title":
            MessageLookupByLibrary.simpleMessage("Generated SMART Habit"),
        "habit_goal": MessageLookupByLibrary.simpleMessage("Habit Goal"),
        "habit_name": MessageLookupByLibrary.simpleMessage("Habit Name"),
        "habit_pause_reason_health_issues":
            MessageLookupByLibrary.simpleMessage("Health Issues"),
        "habit_pause_reason_lack_of_motivation":
            MessageLookupByLibrary.simpleMessage("Lack of Motivation"),
        "habit_pause_reason_lack_of_time":
            MessageLookupByLibrary.simpleMessage("Lack of Time"),
        "habit_pause_reason_need_for_rest":
            MessageLookupByLibrary.simpleMessage("Need for Rest"),
        "habit_pause_reason_other":
            MessageLookupByLibrary.simpleMessage("Other"),
        "habit_pause_reason_reassessment":
            MessageLookupByLibrary.simpleMessage("Reassessment"),
        "habit_pause_reason_unexpected_events":
            MessageLookupByLibrary.simpleMessage("Unexpected Events"),
        "habit_pause_reason_unknown":
            MessageLookupByLibrary.simpleMessage("Unknown"),
        "habit_quote_1": MessageLookupByLibrary.simpleMessage(
            "A habit cannot be tossed out the window; it must be coaxed down the stairs a step at a time"),
        "habit_quote_2": MessageLookupByLibrary.simpleMessage(
            "And once you understand that habits can change, you have the freedom and the responsibility to remake them"),
        "habit_quote_3": MessageLookupByLibrary.simpleMessage(
            "Discipline is choosing between what you want now and what you want most"),
        "habit_quote_4": MessageLookupByLibrary.simpleMessage(
            "Drop by drop is the water pot filled"),
        "habit_quote_5": MessageLookupByLibrary.simpleMessage(
            "Success is the sum of small efforts repeated day in and day out"),
        "habit_status_distribution":
            MessageLookupByLibrary.simpleMessage("Status Distribution"),
        "habits": m11,
        "help_tile": MessageLookupByLibrary.simpleMessage("Help"),
        "history_empty":
            MessageLookupByLibrary.simpleMessage("No history found"),
        "history_section": MessageLookupByLibrary.simpleMessage("History"),
        "hour_unit": MessageLookupByLibrary.simpleMessage("hour"),
        "imperial_unit": MessageLookupByLibrary.simpleMessage("Imperial Unit"),
        "in_progress": m12,
        "in_progress_habit":
            MessageLookupByLibrary.simpleMessage("In Progress Habit"),
        "inactive_button": MessageLookupByLibrary.simpleMessage("Inactive"),
        "internet_failure_title":
            MessageLookupByLibrary.simpleMessage("Internet connection failure"),
        "invalid_age":
            MessageLookupByLibrary.simpleMessage("Please select a valid age"),
        "invalid_credential":
            MessageLookupByLibrary.simpleMessage("Invalid email or password."),
        "invalid_email": MessageLookupByLibrary.simpleMessage(
            "Email is not valid or badly formatted."),
        "invalid_end_date": MessageLookupByLibrary.simpleMessage(
            "End date cannot be after start date"),
        "invalid_form": MessageLookupByLibrary.simpleMessage(
            "Please check your information again"),
        "invalid_habit_prompt": MessageLookupByLibrary.simpleMessage(
            "Please provides more information to generate a better goal"),
        "invalid_num": MessageLookupByLibrary.simpleMessage(
            "Please enter number that greater than 0"),
        "invalid_password": MessageLookupByLibrary.simpleMessage(
            "Password must have at least 6 characters"),
        "invalid_phone":
            MessageLookupByLibrary.simpleMessage("Phone number is not valid"),
        "invalid_start_date": MessageLookupByLibrary.simpleMessage(
            "Start date cannot be after end date"),
        "invalid_verification_code": MessageLookupByLibrary.simpleMessage(
            "The credential verification code received is invalid."),
        "invalid_verification_id": MessageLookupByLibrary.simpleMessage(
            "The credential verification ID received is invalid."),
        "km_unit": MessageLookupByLibrary.simpleMessage("kilometers"),
        "know_more_about_habit":
            MessageLookupByLibrary.simpleMessage("More Knowledge about habit"),
        "l_unit": MessageLookupByLibrary.simpleMessage("liters"),
        "language_tile": MessageLookupByLibrary.simpleMessage("Language"),
        "last_n_day": m13,
        "less_title": MessageLookupByLibrary.simpleMessage("Less"),
        "light_theme": MessageLookupByLibrary.simpleMessage("Light Theme"),
        "loading_title": MessageLookupByLibrary.simpleMessage("Loading..."),
        "login_failure_title":
            MessageLookupByLibrary.simpleMessage("Login Failure"),
        "login_success_title":
            MessageLookupByLibrary.simpleMessage("Login Success"),
        "logout_button": MessageLookupByLibrary.simpleMessage("Log out"),
        "longest_streak":
            MessageLookupByLibrary.simpleMessage("Longest Streak"),
        "m_unit": MessageLookupByLibrary.simpleMessage("meters"),
        "manage_account_choice":
            MessageLookupByLibrary.simpleMessage("Manage Account"),
        "mark_as_done": MessageLookupByLibrary.simpleMessage("Mark as done"),
        "mark_as_pause": MessageLookupByLibrary.simpleMessage("Mark as pause"),
        "measurable_excellent": MessageLookupByLibrary.simpleMessage(
            "Your goal has clear metrics and tracking methods"),
        "measurable_good": MessageLookupByLibrary.simpleMessage(
            "Your goal is measurable but could use clearer metrics"),
        "measurable_gram": MessageLookupByLibrary.simpleMessage("g"),
        "measurable_hour": MessageLookupByLibrary.simpleMessage("h"),
        "measurable_kilogram": MessageLookupByLibrary.simpleMessage("kg"),
        "measurable_kilometer": MessageLookupByLibrary.simpleMessage("km"),
        "measurable_liter": MessageLookupByLibrary.simpleMessage("l"),
        "measurable_meter": MessageLookupByLibrary.simpleMessage("m"),
        "measurable_mile": MessageLookupByLibrary.simpleMessage("mile"),
        "measurable_milliliter": MessageLookupByLibrary.simpleMessage("ml"),
        "measurable_minute": MessageLookupByLibrary.simpleMessage("min"),
        "measurable_needs_work": MessageLookupByLibrary.simpleMessage(
            "Your goal needs clearer ways to measure progress"),
        "measurable_negative_decline":
            MessageLookupByLibrary.simpleMessage("decline"),
        "measurable_negative_decrease":
            MessageLookupByLibrary.simpleMessage("decrease"),
        "measurable_negative_diminish":
            MessageLookupByLibrary.simpleMessage("diminish"),
        "measurable_negative_fail":
            MessageLookupByLibrary.simpleMessage("fail"),
        "measurable_negative_lose":
            MessageLookupByLibrary.simpleMessage("lose"),
        "measurable_negative_revert":
            MessageLookupByLibrary.simpleMessage("revert"),
        "measurable_negative_weaken":
            MessageLookupByLibrary.simpleMessage("weaken"),
        "measurable_page": MessageLookupByLibrary.simpleMessage("page"),
        "measurable_poor": MessageLookupByLibrary.simpleMessage(
            "Your goal lacks any measurable criteria"),
        "measurable_positive_accomplish":
            MessageLookupByLibrary.simpleMessage("accomplish"),
        "measurable_positive_achieve":
            MessageLookupByLibrary.simpleMessage("achieve"),
        "measurable_positive_advance":
            MessageLookupByLibrary.simpleMessage("advance"),
        "measurable_positive_attain":
            MessageLookupByLibrary.simpleMessage("attain"),
        "measurable_positive_boost":
            MessageLookupByLibrary.simpleMessage("boost"),
        "measurable_positive_build":
            MessageLookupByLibrary.simpleMessage("build"),
        "measurable_positive_complete":
            MessageLookupByLibrary.simpleMessage("complete"),
        "measurable_positive_cultivate":
            MessageLookupByLibrary.simpleMessage("cultivate"),
        "measurable_positive_deliver":
            MessageLookupByLibrary.simpleMessage("deliver"),
        "measurable_positive_develop":
            MessageLookupByLibrary.simpleMessage("develop"),
        "measurable_positive_enhance":
            MessageLookupByLibrary.simpleMessage("enhance"),
        "measurable_positive_expand":
            MessageLookupByLibrary.simpleMessage("expand"),
        "measurable_positive_finalize":
            MessageLookupByLibrary.simpleMessage("finalize"),
        "measurable_positive_finish":
            MessageLookupByLibrary.simpleMessage("finish"),
        "measurable_positive_growth":
            MessageLookupByLibrary.simpleMessage("grow"),
        "measurable_positive_improve":
            MessageLookupByLibrary.simpleMessage("improve"),
        "measurable_positive_increase":
            MessageLookupByLibrary.simpleMessage("increase"),
        "measurable_positive_master":
            MessageLookupByLibrary.simpleMessage("master"),
        "measurable_positive_optimize":
            MessageLookupByLibrary.simpleMessage("optimize"),
        "measurable_positive_perfect":
            MessageLookupByLibrary.simpleMessage("perfect"),
        "measurable_positive_progress":
            MessageLookupByLibrary.simpleMessage("progress"),
        "measurable_positive_raise":
            MessageLookupByLibrary.simpleMessage("raise"),
        "measurable_positive_reach":
            MessageLookupByLibrary.simpleMessage("reach"),
        "measurable_positive_realize":
            MessageLookupByLibrary.simpleMessage("realize"),
        "measurable_positive_refine":
            MessageLookupByLibrary.simpleMessage("refine"),
        "measurable_positive_strengthen":
            MessageLookupByLibrary.simpleMessage("strengthen"),
        "measurable_positive_succeed":
            MessageLookupByLibrary.simpleMessage("succeed"),
        "measurable_rep": MessageLookupByLibrary.simpleMessage("rep"),
        "measurable_second": MessageLookupByLibrary.simpleMessage("s"),
        "measurable_set": MessageLookupByLibrary.simpleMessage("set"),
        "measurable_step": MessageLookupByLibrary.simpleMessage("step"),
        "measurable_suggestion_1": MessageLookupByLibrary.simpleMessage(
            "Add specific numbers to track progress"),
        "measurable_suggestion_2": MessageLookupByLibrary.simpleMessage(
            "Include how you\'ll measure success"),
        "measurable_title": MessageLookupByLibrary.simpleMessage("Measurable"),
        "measurement_desc": MessageLookupByLibrary.simpleMessage(
            "Include concrete numbers or actions that can be tracked and evaluated."),
        "measurement_unit_title":
            MessageLookupByLibrary.simpleMessage("Measurement Unit"),
        "meditation_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Relax and reduce stress by meditating for 5 minutes each morning."),
        "meditation_habit_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Spend 5 minutes each morning meditating to improve focus and clarity."),
        "meditation_habit_title":
            MessageLookupByLibrary.simpleMessage("5-Minute Meditation"),
        "metric_unit": MessageLookupByLibrary.simpleMessage("Metric Unit"),
        "miles_unit": MessageLookupByLibrary.simpleMessage("miles"),
        "minute_unit": MessageLookupByLibrary.simpleMessage("minute"),
        "miss_title": MessageLookupByLibrary.simpleMessage("Miss"),
        "ml_unit": MessageLookupByLibrary.simpleMessage("milliliters"),
        "month_title": MessageLookupByLibrary.simpleMessage("Month"),
        "monthly_process_section":
            MessageLookupByLibrary.simpleMessage("Monthly"),
        "mood_distribution":
            MessageLookupByLibrary.simpleMessage("Mood Distribution"),
        "mood_title": MessageLookupByLibrary.simpleMessage("Mood"),
        "more_title": MessageLookupByLibrary.simpleMessage("More"),
        "morning_greeting":
            MessageLookupByLibrary.simpleMessage("Good morning"),
        "most_mood": MessageLookupByLibrary.simpleMessage("Most Mood"),
        "most_reason": MessageLookupByLibrary.simpleMessage("Most Reason"),
        "my_custom_challenge_tab":
            MessageLookupByLibrary.simpleMessage("My Custom Challenges"),
        "my_reward_tab": MessageLookupByLibrary.simpleMessage("My Rewards"),
        "next_habits_button": MessageLookupByLibrary.simpleMessage("Next Page"),
        "night_greeting": MessageLookupByLibrary.simpleMessage("Good night"),
        "no_data_title": MessageLookupByLibrary.simpleMessage("No Data"),
        "no_date_selected":
            MessageLookupByLibrary.simpleMessage("No Date Selected"),
        "no_habit_found":
            MessageLookupByLibrary.simpleMessage("No habit found"),
        "no_habit_item_selected": MessageLookupByLibrary.simpleMessage(
            "Please select at least one to add"),
        "not_allow_track": MessageLookupByLibrary.simpleMessage(
            "We don\'t have permission to track your distance"),
        "not_found": MessageLookupByLibrary.simpleMessage("Not Found"),
        "notification_screen_title":
            MessageLookupByLibrary.simpleMessage("Keep your habits on track!"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "notify_at": MessageLookupByLibrary.simpleMessage("Notify at:"),
        "on_your_way": m14,
        "operation_not_allowed": MessageLookupByLibrary.simpleMessage(
            "Operation is not allowed. Please contact support."),
        "out_of_range":
            MessageLookupByLibrary.simpleMessage("The number is out of range"),
        "overall_completion_rate":
            MessageLookupByLibrary.simpleMessage("Overall Completion Rate"),
        "overall_progress": m15,
        "page_unit": MessageLookupByLibrary.simpleMessage("page"),
        "pareto_principle":
            MessageLookupByLibrary.simpleMessage("Pareto Principle"),
        "pareto_principle_description": MessageLookupByLibrary.simpleMessage(
            "20% of the right habits will bring 80% of the positive results."),
        "participant": m16,
        "password_field": MessageLookupByLibrary.simpleMessage("Password"),
        "passwords_do_not_match":
            MessageLookupByLibrary.simpleMessage("Password does not match"),
        "pause_statistic_page": MessageLookupByLibrary.simpleMessage("Pause"),
        "pause_tracking":
            MessageLookupByLibrary.simpleMessage("Pause Tracking"),
        "paused": m17,
        "paused_habit": MessageLookupByLibrary.simpleMessage("Paused Habit"),
        "personal_achievements":
            MessageLookupByLibrary.simpleMessage("Personal Achievements"),
        "personal_info_section":
            MessageLookupByLibrary.simpleMessage("Personal Information"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Phone"),
        "power_of_timing":
            MessageLookupByLibrary.simpleMessage("Power of Timing"),
        "power_of_timing_description": MessageLookupByLibrary.simpleMessage(
            "Performing a habit at the same time each day increases the likelihood of maintaining it by 90%."),
        "previous_habits_button":
            MessageLookupByLibrary.simpleMessage("Previous Page"),
        "progress_section": MessageLookupByLibrary.simpleMessage("Progress"),
        "psy_tab": MessageLookupByLibrary.simpleMessage("Psychology"),
        "psychology_cue_routine_reward":
            MessageLookupByLibrary.simpleMessage("Cue-Routine-Reward"),
        "psychology_cue_routine_reward_description":
            MessageLookupByLibrary.simpleMessage(
                "Habits are formed by three elements: Cue, Routine, and Reward."),
        "psychology_implementation_intentions":
            MessageLookupByLibrary.simpleMessage("Implementation Intentions"),
        "psychology_implementation_intentions_description":
            MessageLookupByLibrary.simpleMessage(
                "Specifying \'when\' and \'where\' you will perform a habit can increase success rates by 2-3 times."),
        "quick_add_water_button":
            MessageLookupByLibrary.simpleMessage("Quick Add"),
        "quote_aristotle": MessageLookupByLibrary.simpleMessage(
            "We are what we repeatedly do. Excellence, then, is not an act, but a habit."),
        "quote_dwayne_johnson": MessageLookupByLibrary.simpleMessage(
            "Success is not about perfection. It\'s about consistency."),
        "quote_james_clear": MessageLookupByLibrary.simpleMessage(
            "Small habits make a big difference."),
        "rate_and_note_completed_habit":
            MessageLookupByLibrary.simpleMessage("Rate & Note"),
        "re_auth_with_email":
            MessageLookupByLibrary.simpleMessage("Re-authenticate with Email"),
        "re_auth_with_google":
            MessageLookupByLibrary.simpleMessage("Re-authenticate with Google"),
        "reading_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Enhance your knowledge and skills by reading 10 pages daily."),
        "reading_habit_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Read 10 pages daily to develop a habit of continuous learning."),
        "reading_habit_title":
            MessageLookupByLibrary.simpleMessage("Read 10 Pages"),
        "recovery_description": MessageLookupByLibrary.simpleMessage(
            "An reset-password mail will be sent to your email"),
        "regenerate_button":
            MessageLookupByLibrary.simpleMessage("Generate another habit"),
        "relevant_accomplish":
            MessageLookupByLibrary.simpleMessage("accomplish"),
        "relevant_boost": MessageLookupByLibrary.simpleMessage("boost"),
        "relevant_desc": MessageLookupByLibrary.simpleMessage(
            "Aligned with your broader goals and current life situation."),
        "relevant_develop": MessageLookupByLibrary.simpleMessage("develop"),
        "relevant_enhance": MessageLookupByLibrary.simpleMessage("enhance"),
        "relevant_expand": MessageLookupByLibrary.simpleMessage("expand"),
        "relevant_improve": MessageLookupByLibrary.simpleMessage("improve"),
        "relevant_increase": MessageLookupByLibrary.simpleMessage("increase"),
        "relevant_optimize": MessageLookupByLibrary.simpleMessage("optimize"),
        "relevant_raise": MessageLookupByLibrary.simpleMessage("raise"),
        "relevant_strengthen":
            MessageLookupByLibrary.simpleMessage("strengthen"),
        "relevant_suggestion_1": MessageLookupByLibrary.simpleMessage(
            "Consider explaining why this goal is important to you"),
        "relevant_title": MessageLookupByLibrary.simpleMessage("Relevant"),
        "reminder_section": MessageLookupByLibrary.simpleMessage("Reminder"),
        "remove_water_button": m18,
        "reps_unit": MessageLookupByLibrary.simpleMessage("reps"),
        "reset_password":
            MessageLookupByLibrary.simpleMessage("Reset Password"),
        "run_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Improve your health and energy by walking or running 2km every morning."),
        "run_habit_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Walk or run 2km every morning to enhance fitness and health."),
        "run_habit_title": MessageLookupByLibrary.simpleMessage("Walk/Run 2km"),
        "same_type_habit": MessageLookupByLibrary.simpleMessage("Same Habit"),
        "save_button": MessageLookupByLibrary.simpleMessage("Save"),
        "science_21_day_rule":
            MessageLookupByLibrary.simpleMessage("21-Day Rule"),
        "science_21_day_rule_description": MessageLookupByLibrary.simpleMessage(
            "Research shows it actually takes 66 days to form an automatic habit, not 21 days as commonly believed."),
        "science_dopamine_habits":
            MessageLookupByLibrary.simpleMessage("Dopamine and Habits"),
        "science_dopamine_habits_description": MessageLookupByLibrary.simpleMessage(
            "The brain releases dopamine not only when achieving a goal but also when recognizing cues leading to rewards."),
        "science_neuroplasticity":
            MessageLookupByLibrary.simpleMessage("Neuroplasticity"),
        "science_neuroplasticity_description": MessageLookupByLibrary.simpleMessage(
            "When you repeat a behavior, the brain creates new neural connections, making the behavior more natural over time."),
        "science_tab": MessageLookupByLibrary.simpleMessage("Science"),
        "search_achievement":
            MessageLookupByLibrary.simpleMessage("Search your achievements..."),
        "search_community_challenge": MessageLookupByLibrary.simpleMessage(
            "Search for community challenge..."),
        "search_my_custom_challenge":
            MessageLookupByLibrary.simpleMessage("Search my challenges..."),
        "searching_title": MessageLookupByLibrary.simpleMessage("Searching..."),
        "second_unit": MessageLookupByLibrary.simpleMessage("second"),
        "select_button": MessageLookupByLibrary.simpleMessage("Select"),
        "select_date_title":
            MessageLookupByLibrary.simpleMessage("Select Date"),
        "select_range_date_title":
            MessageLookupByLibrary.simpleMessage("Select Date Range"),
        "send_button": MessageLookupByLibrary.simpleMessage("Send"),
        "sets_unit": MessageLookupByLibrary.simpleMessage("sets"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "show_all_figure_button":
            MessageLookupByLibrary.simpleMessage("Show all figures"),
        "show_less": MessageLookupByLibrary.simpleMessage("Show less"),
        "show_more": MessageLookupByLibrary.simpleMessage("Show More"),
        "smart_criteria_achieved":
            MessageLookupByLibrary.simpleMessage("SMART Achieved"),
        "specific_excellent": MessageLookupByLibrary.simpleMessage(
            "Your goal is very clear and well_defined with specific details"),
        "specific_good": MessageLookupByLibrary.simpleMessage(
            "Your goal has good specificity but could use more detail"),
        "specific_needs_work": MessageLookupByLibrary.simpleMessage(
            "Your goal needs more specific details about what you want to achieve"),
        "specific_poor": MessageLookupByLibrary.simpleMessage(
            "Your goal is too vague and needs specific actions"),
        "specific_suggestion_1": MessageLookupByLibrary.simpleMessage(
            "Add specific numbers or quantities to measure success"),
        "specific_suggestion_2": MessageLookupByLibrary.simpleMessage(
            "Include clear action verbs describing what you\'ll do"),
        "specific_suggestion_3": MessageLookupByLibrary.simpleMessage(
            "Specify exactly what you want to achieve"),
        "specify_desc": MessageLookupByLibrary.simpleMessage(
            "Clear and well-defined goal that answers who, what, where, when, and why."),
        "specify_title": MessageLookupByLibrary.simpleMessage("Specify"),
        "start_date": MessageLookupByLibrary.simpleMessage("Start Date"),
        "start_tracking":
            MessageLookupByLibrary.simpleMessage("Start Tracking"),
        "start_value_must_be_less_than_end":
            MessageLookupByLibrary.simpleMessage(
                "Start value must be less than end value"),
        "statistic_info_tab":
            MessageLookupByLibrary.simpleMessage("Statistics"),
        "statistic_section": MessageLookupByLibrary.simpleMessage("Statistics"),
        "statistics_habit_formation_time":
            MessageLookupByLibrary.simpleMessage("Habit Formation Time"),
        "statistics_habit_formation_time_description":
            MessageLookupByLibrary.simpleMessage(
                "The time to form a habit can range from 18 to 254 days depending on complexity."),
        "statistics_success_rate":
            MessageLookupByLibrary.simpleMessage("Success Rate"),
        "statistics_success_rate_description": MessageLookupByLibrary.simpleMessage(
            "43% of our daily actions are performed unconsciously due to habits."),
        "status_achieved": MessageLookupByLibrary.simpleMessage("Achieved"),
        "status_failed": MessageLookupByLibrary.simpleMessage("Failed"),
        "status_in_progress":
            MessageLookupByLibrary.simpleMessage("In Progress"),
        "status_paused": MessageLookupByLibrary.simpleMessage("Paused"),
        "status_pending": MessageLookupByLibrary.simpleMessage("Pending"),
        "status_skipped": MessageLookupByLibrary.simpleMessage("Skipped"),
        "status_title": MessageLookupByLibrary.simpleMessage("Status"),
        "status_unkown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "steps_unit": MessageLookupByLibrary.simpleMessage("steps"),
        "streak_long_100": MessageLookupByLibrary.simpleMessage(
            "Fantastic! You\'ve kept a 100-day streak!"),
        "streak_long_40": MessageLookupByLibrary.simpleMessage(
            "Incredible! You\'re on a 40-day streak!"),
        "streak_long_60": MessageLookupByLibrary.simpleMessage(
            "Unbelievable! You\'ve hit a 60-day streak!"),
        "streak_medium_10": MessageLookupByLibrary.simpleMessage(
            "Amazing! You\'ve kept a 10-day streak going!"),
        "streak_medium_15": MessageLookupByLibrary.simpleMessage(
            "Keep pushing! You\'ve achieved 15 days continuously!"),
        "streak_medium_30": MessageLookupByLibrary.simpleMessage(
            "You\'re awesome! Maintained 30 days straight!"),
        "streak_short_0": MessageLookupByLibrary.simpleMessage(
            "Getting started! Complete your first day without missing!"),
        "streak_short_1": MessageLookupByLibrary.simpleMessage(
            "Great start! You\'ve completed 1 day without missing!"),
        "streak_short_3": MessageLookupByLibrary.simpleMessage(
            "Keep it up! You\'ve maintained 3 consecutive days!"),
        "streak_short_7": MessageLookupByLibrary.simpleMessage(
            "Excellent! You\'ve reached 7 days in a row!"),
        "streak_very_long_150": MessageLookupByLibrary.simpleMessage(
            "Unbelievable! You\'ve kept a 150-day streak!"),
        "streak_very_long_200": MessageLookupByLibrary.simpleMessage(
            "Admirable! You\'ve maintained a 200-day streak!"),
        "streak_very_long_365": MessageLookupByLibrary.simpleMessage(
            "You\'re a hero! Achieved a 365-day streak!"),
        "study_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Improve learning efficiency by studying for 2 focused hours every evening."),
        "study_habit_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Focus on studying for 2 hours every evening at 7 PM to boost knowledge."),
        "study_habit_title":
            MessageLookupByLibrary.simpleMessage("2-Hour Focused Study"),
        "success_title": MessageLookupByLibrary.simpleMessage("Success"),
        "summary_excellent": MessageLookupByLibrary.simpleMessage(
            "Excellent SMART goal! All criteria are well_defined and balanced."),
        "summary_good": m19,
        "summary_needs_work": m20,
        "summary_poor": m21,
        "summary_title": MessageLookupByLibrary.simpleMessage("Summary"),
        "target_title": MessageLookupByLibrary.simpleMessage("Target"),
        "term_and_condition_statement": MessageLookupByLibrary.simpleMessage(
            "By signing in/signing up, you accept our Terms and Conditions and consent to our Privacy Policy"),
        "terms_and_conditions":
            MessageLookupByLibrary.simpleMessage("Terms & Conditions"),
        "theme_tile": MessageLookupByLibrary.simpleMessage("Theme"),
        "time_based_progress":
            MessageLookupByLibrary.simpleMessage("Time-Based Progress"),
        "time_bound_achieve": MessageLookupByLibrary.simpleMessage("achieve"),
        "time_bound_after": MessageLookupByLibrary.simpleMessage("after"),
        "time_bound_before": MessageLookupByLibrary.simpleMessage("before"),
        "time_bound_by": MessageLookupByLibrary.simpleMessage("by"),
        "time_bound_complete": MessageLookupByLibrary.simpleMessage("complete"),
        "time_bound_complete_by":
            MessageLookupByLibrary.simpleMessage("complete by"),
        "time_bound_deadline": MessageLookupByLibrary.simpleMessage("deadline"),
        "time_bound_desc": MessageLookupByLibrary.simpleMessage(
            "Has a clear deadline or timeframe for completion."),
        "time_bound_due": MessageLookupByLibrary.simpleMessage("due"),
        "time_bound_duration": MessageLookupByLibrary.simpleMessage("duration"),
        "time_bound_end": MessageLookupByLibrary.simpleMessage("end"),
        "time_bound_end_by": MessageLookupByLibrary.simpleMessage("end by"),
        "time_bound_end_date": MessageLookupByLibrary.simpleMessage("end date"),
        "time_bound_finalize": MessageLookupByLibrary.simpleMessage("finalize"),
        "time_bound_finish": MessageLookupByLibrary.simpleMessage("finish"),
        "time_bound_goal": MessageLookupByLibrary.simpleMessage("goal"),
        "time_bound_immediate":
            MessageLookupByLibrary.simpleMessage("immediate"),
        "time_bound_in_the_next":
            MessageLookupByLibrary.simpleMessage("in the next"),
        "time_bound_in_time": MessageLookupByLibrary.simpleMessage("in time"),
        "time_bound_next": MessageLookupByLibrary.simpleMessage("next"),
        "time_bound_on": MessageLookupByLibrary.simpleMessage("on"),
        "time_bound_post": MessageLookupByLibrary.simpleMessage("post"),
        "time_bound_promptly": MessageLookupByLibrary.simpleMessage("promptly"),
        "time_bound_quickly": MessageLookupByLibrary.simpleMessage("quickly"),
        "time_bound_reach": MessageLookupByLibrary.simpleMessage("reach"),
        "time_bound_scheduled":
            MessageLookupByLibrary.simpleMessage("scheduled"),
        "time_bound_set_date": MessageLookupByLibrary.simpleMessage("set date"),
        "time_bound_soon": MessageLookupByLibrary.simpleMessage("soon"),
        "time_bound_soon_after":
            MessageLookupByLibrary.simpleMessage("soon after"),
        "time_bound_start": MessageLookupByLibrary.simpleMessage("start"),
        "time_bound_start_by": MessageLookupByLibrary.simpleMessage("start by"),
        "time_bound_start_from":
            MessageLookupByLibrary.simpleMessage("start from"),
        "time_bound_suggestion_1": MessageLookupByLibrary.simpleMessage(
            "Consider adding a clear time limit or deadline for your goal."),
        "time_bound_suggestion_2": MessageLookupByLibrary.simpleMessage(
            "Please specify the timeframe or duration for achieving your goal."),
        "time_bound_time_limit":
            MessageLookupByLibrary.simpleMessage("time limit"),
        "time_bound_timeframe":
            MessageLookupByLibrary.simpleMessage("timeframe"),
        "time_bound_timely": MessageLookupByLibrary.simpleMessage("timely"),
        "time_bound_title": MessageLookupByLibrary.simpleMessage("Time Bound"),
        "time_bound_until": MessageLookupByLibrary.simpleMessage("until"),
        "time_bound_upon_completion":
            MessageLookupByLibrary.simpleMessage("upon completion"),
        "time_bound_urgent": MessageLookupByLibrary.simpleMessage("urgent"),
        "time_bound_within": MessageLookupByLibrary.simpleMessage("within"),
        "time_bound_within_the_next":
            MessageLookupByLibrary.simpleMessage("within the next"),
        "time_of_day_section":
            MessageLookupByLibrary.simpleMessage("Time of day"),
        "time_slot_heatmap":
            MessageLookupByLibrary.simpleMessage("Daily Time Slots Map"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "today_tasks": MessageLookupByLibrary.simpleMessage("Today Tasks"),
        "total": m22,
        "total_achievement": m23,
        "total_distance":
            MessageLookupByLibrary.simpleMessage("Total Distance"),
        "total_habit": MessageLookupByLibrary.simpleMessage("Total Habit"),
        "total_paused_time":
            MessageLookupByLibrary.simpleMessage("Total Pause Time"),
        "total_streak": m24,
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
        "water_habit_desc": MessageLookupByLibrary.simpleMessage(
            "Stay hydrated and improve your overall health by drinking 2 liters of water every day"),
        "water_habit_goal_desc": MessageLookupByLibrary.simpleMessage(
            "Drink 2L of water daily for the next 30 days to stay hydrated and maintain good health"),
        "water_habit_title":
            MessageLookupByLibrary.simpleMessage("Drink enough 2L water a day"),
        "weak_password": MessageLookupByLibrary.simpleMessage(
            "Please enter a stronger password."),
        "weekly_mood": MessageLookupByLibrary.simpleMessage("Weekly Mood"),
        "weekly_process_section":
            MessageLookupByLibrary.simpleMessage("Weekly"),
        "wrong_password": MessageLookupByLibrary.simpleMessage(
            "Incorrect password, please try again."),
        "year_title": MessageLookupByLibrary.simpleMessage("Year")
      };
}
