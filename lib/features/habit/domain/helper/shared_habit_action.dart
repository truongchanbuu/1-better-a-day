import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../presentations/blocs/ai_habit_generate/ai_habit_generate_bloc.dart';
import '../../presentations/blocs/crud/habit_crud_bloc.dart';
import '../../presentations/blocs/validate_habit/validate_habit_bloc.dart';
import '../../presentations/pages/add_habit_page.dart';
import '../../presentations/pages/add_habit_with_ai_page.dart';
import '../../presentations/pages/preset_habit_page.dart';

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
}
