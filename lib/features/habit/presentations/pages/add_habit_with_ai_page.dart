import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';
import '../blocs/ai_habit_generate/ai_habit_generate_bloc.dart';
import '../blocs/validate_habit/validate_habit_bloc.dart';
import '../widgets/generated_habit.dart';
import 'add_habit_page.dart';

class AddHabitWithAIPage extends StatefulWidget {
  const AddHabitWithAIPage({super.key});

  @override
  State<AddHabitWithAIPage> createState() => _AddHabitWithAIPageState();
}

class _AddHabitWithAIPageState extends State<AddHabitWithAIPage> {
  late final TextEditingController habitGenerationSentenceController;

  @override
  void initState() {
    super.initState();
    habitGenerationSentenceController = TextEditingController();
  }

  @override
  void dispose() {
    habitGenerationSentenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.locale.languageCode;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: BlocListener<AIHabitGenerateBloc, AIHabitGenerateState>(
              listener: (context, state) {
                SmartDialog.dismiss();
                if (state is AIGenerationFailed || state is AddHabitFailed) {
                  final errorMessage = state is AIGenerationFailed
                      ? state.errorMessage
                      : (state is AddHabitFailed)
                          ? state.errorMessage
                          : S.current.failure_title;

                  AwesomeDialog(
                    dialogType: DialogType.error,
                    context: context,
                    title: S.current.failure_title,
                    desc: errorMessage,
                    descTextStyle:
                        const TextStyle(overflow: TextOverflow.visible),
                    btnOkText: S.current.add_habit_manually,
                    btnOkColor: AppColors.primary,
                    btnOkOnPress: _onAddHabit,
                    btnCancelText: S.current.cancel_button,
                    btnCancelOnPress: () {},
                  ).show();
                } else if (state is AIGenerating) {
                  SmartDialog.show(
                    builder: (context) => const SizedBox(
                      width: 200,
                      height: 200,
                      child: LoadingIndicator(indicatorType: Indicator.pacman),
                    ),
                  );
                } else if (state is AddHabitSucceed) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    title: S.current.success_title,
                    desc: S.current.add_success,
                    btnOkText: S.current.go_home_button,
                    btnOkOnPress: () {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                  ).show();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.paddingM),
                child: Column(
                  children: [
                    BlocBuilder<AIHabitGenerateBloc, AIHabitGenerateState>(
                      builder: (context, state) {
                        return AnimatedSwitcherPlus.translationTop(
                          duration: const Duration(milliseconds: 500),
                          child: state is AIGenerationSucceed
                              ? const SizedBox.shrink()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconWithText(
                                      icon: Icons.support_agent,
                                      text: S.current.ask_ai_field,
                                      fontSize: AppFontSize.h2,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: AppSpacing.marginL),
                                    TextFormField(
                                      controller:
                                          habitGenerationSentenceController,
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.primary),
                                        ),
                                        hintText: S.current.add_goal_desc,
                                        labelText: S.current.habit_desc,
                                      ),
                                      maxLines: 5,
                                    ),
                                    const SizedBox(height: AppSpacing.marginL),
                                    ElevatedButton(
                                      onPressed: () => _onGenerate(langCode),
                                      child: IconWithText(
                                        icon: FontAwesomeIcons.headset,
                                        text: S.current.ask_ai_button,
                                        fontColor: AppColors.lightText,
                                        iconColor: AppColors.lightText,
                                        fontSize: AppFontSize.h3,
                                      ),
                                    ),
                                  ],
                                ),
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.marginL),
                    BlocBuilder<AIHabitGenerateBloc, AIHabitGenerateState>(
                      builder: (context, state) {
                        if (state is! AIGenerating) {
                          SmartDialog.dismiss();
                        }

                        return AnimatedSwitcherPlus.translationBottom(
                          duration: const Duration(milliseconds: 500),
                          child: state is! AIGenerationSucceed
                              ? const SizedBox.shrink()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => context
                                          .read<AIHabitGenerateBloc>()
                                          .add(Regenerate()),
                                      child: IconWithText(
                                        icon: FontAwesomeIcons.arrowLeft,
                                        text: S.current.regenerate_button,
                                        iconColor: AppColors.lightText,
                                        fontColor: AppColors.lightText,
                                        fontSize: AppFontSize.h4,
                                        iconSize: 20,
                                      ),
                                    ),
                                    GeneratedHabit(
                                      habit: state.habit,
                                      onEdit: (habit) {
                                        context
                                            .read<AIHabitGenerateBloc>()
                                            .add(AddHabitEvent(habit));
                                      },
                                    ),
                                  ],
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onGenerate(String langCode) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (habitGenerationSentenceController.text.split(' ').length < 2) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        title: S.current.invalid_form,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible,
        ),
        desc: S.current.invalid_habit_prompt,
        descTextStyle: const TextStyle(overflow: TextOverflow.visible),
        btnOkOnPress: () {},
        btnOkText: 'OK',
        btnOkColor: AppColors.warning,
      ).show();
      return;
    }

    context.read<AIHabitGenerateBloc>().add(GenerateSMARTHabitGoal(
        habitGenerationSentenceController.text, langCode));
    habitGenerationSentenceController.clear();
  }

  void _onAddHabit() {
    habitGenerationSentenceController.clear();
    Navigator.push(
      context,
      PageTransition(
        child: BlocProvider(
          create: (context) => getIt.get<ValidateHabitBloc>(),
          child: const AddHabitPage(),
        ),
        type: PageTransitionType.leftToRight,
      ),
    );
  }
}
