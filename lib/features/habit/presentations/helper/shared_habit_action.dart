import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/enums/habit/day_status.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/habit_history.dart';
import '../../domain/entities/habit_icon.dart';
import '../blocs/ai_habit_generate/ai_habit_generate_bloc.dart';
import '../blocs/crud/habit_crud_bloc.dart';
import '../blocs/habit_history_crud/habit_history_crud_bloc.dart';
import '../blocs/review_habit_action/review_habit_action_bloc.dart';
import '../blocs/validate_habit/validate_habit_bloc.dart';
import '../pages/add_habit_page.dart';
import '../pages/add_habit_with_ai_page.dart';
import '../pages/preset_habit_page.dart';
import '../pages/review_action_page.dart';
import '../widgets/crud_habit/habit_icon_color_picker.dart';

class SharedHabitAction {
  static void showAddHabitOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () =>
                navigateToAddPage(context, S.current.get_preset_habit_option),
            title: Text(S.current.get_preset_habit_option),
          ),
          ListTile(
            onTap: () => navigateToAddPage(
                context, S.current.add_habit_with_few_words_option),
            title: Text(S.current.add_habit_with_few_words_option),
          ),
          ListTile(
            onTap: () =>
                navigateToAddPage(context, S.current.add_your_own_habit),
            title: Text(S.current.add_your_own_habit),
          ),
        ],
      ),
    );
  }

  static void navigateToAddPage(BuildContext context, String selection) {
    Navigator.pop(context);
    final Widget page;

    if (selection == S.current.get_preset_habit_option) {
      page = MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt.get<HabitCrudBloc>()),
          BlocProvider(create: (context) => getIt.get<AIHabitGenerateBloc>()),
        ],
        child: const PresetHabitPage(),
      );
    } else if (selection == S.current.add_habit_with_few_words_option) {
      page = BlocProvider(
        create: (context) => getIt.get<AIHabitGenerateBloc>(),
        child: const AddHabitWithAIPage(),
      );
    } else {
      page = BlocProvider(
        create: (context) => getIt.get<ValidateHabitBloc>(),
        child: const AddHabitPage(),
      );
    }

    Navigator.push(
      context,
      PageTransition(
        child: page,
        type: PageTransitionType.leftToRight,
      ),
    );
  }

  static void showDailyCompletionDialog({
    required BuildContext context,
    required HabitHistory history,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: history.executionStatus == DayStatus.completed
          ? DialogType.success
          : DialogType.warning,
      title: history.executionStatus == DayStatus.completed
          ? S.current.success_title
          : S.current.warning_title,
      desc: history.executionStatus == DayStatus.completed
          ? S.current.daily_completed
          : S.current.daily_paused,
      btnOkText: S.current.rate_and_note_completed_habit,
      btnOkOnPress: () => onRateAndNote(context, history),
      btnCancelText: S.current.cancel_button,
      btnCancelOnPress: () {},
    ).show();
  }

  static void onRateAndNote(BuildContext context, HabitHistory history) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.leftToRight,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    getIt.get<ReviewHabitActionBloc>(param1: history)),
            BlocProvider.value(value: context.read<HabitHistoryCrudBloc>()),
          ],
          child: ReviewActionPage(history: history),
        ),
      ),
    );
  }

  static void onPickIcon({
    HabitIcon? selected,
    required void Function(HabitIcon habitIcon) onSelect,
  }) {
    SmartDialog.show(
      builder: (ctx) => Container(
        height: MediaQuery.of(ctx).size.height * 0.8,
        width: MediaQuery.of(ctx).size.width * 0.9,
        color: ctx.isDarkMode ? AppColors.darkText : AppColors.lightText,
        child: HabitIconPicker(
          selected: selected,
          onSelect: onSelect,
        ),
      ),
    );
  }
}
