import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_font_size.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/icon_with_text.dart';
import '../widgets/add_habit/add_habit_field.dart';

class AddHabitWithAIPage extends StatefulWidget {
  const AddHabitWithAIPage({super.key});

  @override
  State<AddHabitWithAIPage> createState() => _AddHabitWithAIPageState();
}

class _AddHabitWithAIPageState extends State<AddHabitWithAIPage> {
  late final TextEditingController _habitNameController;

  @override
  void initState() {
    super.initState();
    _habitNameController = TextEditingController();
  }

  @override
  void dispose() {
    _habitNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.paddingM),
            child: Column(
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
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    labelText: S.current.goal_desc,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: AppSpacing.marginL),
                ElevatedButton(
                  onPressed: () {},
                  child: IconWithText(
                    icon: FontAwesomeIcons.headset,
                    text: S.current.ask_ai_button,
                    fontColor: AppColors.lightText,
                    iconColor: AppColors.lightText,
                    fontSize: AppFontSize.h3,
                  ),
                ),
                _buildGeneratedHabit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGeneratedHabit() {
    return Column(
      children: [
        ListTile(
          title: AddHabitField(
            controller: _habitNameController,
            label: S.current.habit_name,
          ),
        )
      ],
    );
  }
}
