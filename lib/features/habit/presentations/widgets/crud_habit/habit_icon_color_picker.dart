import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/healthicons.dart';
import 'package:iconify_flutter_plus/icons/mdi.dart';
import 'package:iconify_flutter_plus/icons/ph.dart';
import 'package:iconify_flutter_plus/icons/quill.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../generated/l10n.dart';
import '../../../domain/entities/habit_icon.dart';

class HabitIconPicker extends StatefulWidget {
  final HabitIcon? selected;
  final Function(HabitIcon habitIcon) onSelect;
  final double defaultSize;

  const HabitIconPicker({
    super.key,
    this.selected,
    required this.onSelect,
    this.defaultSize = 24.0,
  });

  @override
  State<HabitIconPicker> createState() => _HabitIconPickerState();
}

class _HabitIconPickerState extends State<HabitIconPicker> {
  late HabitIcon selectedHabitIcon;

  final Map<String, List<String>> categorizedIcons = {
    S.current.health_and_sport: [
      Mdi.run,
      Healthicons.exercise,
      Mdi.dumbbell,
      Mdi.yoga,
      Mdi.bike,
      Mdi.swim,
      Mdi.meditation,
      Healthicons.sleepy,
    ],
    S.current.education_and_improvement: [
      Mdi.book_open,
      Mdi.brain,
      Mdi.school,
      Mdi.pencil,
      Mdi.code_string,
      Mdi.translate,
      Mdi.music_note,
      Mdi.palette,
    ],
    S.current.mental_health: [
      Mdi.brain,
      Mdi.emoji,
      Mdi.heart_plus,
      Mdi.meditation,
      Mdi.peace,
      Mdi.nature_people,
      Quill.breather,
    ],
    S.current.daily_routine: [
      Mdi.water_drop,
      Mdi.food_apple,
      Mdi.bed,
      Mdi.toothbrush,
      Healthicons.nutrition,
      Mdi.clock,
      Mdi.sun_wireless,
      Mdi.moon_waxing_crescent,
    ],
    S.current.productivity: [
      Mdi.check_circle,
      Mdi.target,
      Mdi.timer_sand,
      Mdi.chart_line,
      Ph.list_checks,
      Mdi.calendar_check,
      Mdi.flash,
    ],
    S.current.society_and_family: [
      Mdi.account_group,
      Mdi.home,
      Mdi.phone_message,
      Mdi.handshake,
      Mdi.account_heart,
      Mdi.family_tree,
      Mdi.money,
    ],
  };

  final List<List<Color>> colorPalette = [
    [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
    ],
    [
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
    ],
    const [
      Color(0xFFFFB3BA), // Pastel Pink
      Color(0xFFBAE1FF), // Pastel Blue
      Color(0xFFBAFFB3), // Pastel Green
      Color(0xFFFFB3F7), // Pastel Purple
      Color(0xFFFFE4B3), // Pastel Orange
      Color(0xFFB3FFE4), // Pastel Mint
      Color(0xFFE4B3FF), // Pastel Lavender
      Color(0xFFFFDAB3), // Pastel Peach
    ],
    const [
      Color(0xFF1A237E), // Deep Indigo
      Color(0xFF004D40), // Deep Teal
      Color(0xFF3E2723), // Deep Brown
      Color(0xFF880E4F), // Deep Pink
      Color(0xFF311B92), // Deep Purple
      Color(0xFF01579B), // Deep Blue
      Color(0xFF33691E), // Deep Green
      Color(0xFF263238), // Deep Grey
    ]
  ];

  @override
  void initState() {
    super.initState();
    selectedHabitIcon = widget.selected ??
        HabitIcon(
          key: 'default',
          icon: categorizedIcons.values.first.first,
          color: Colors.blue,
          size: widget.defaultSize,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.paddingL),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Icon:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.marginS),
                Iconify(
                  selectedHabitIcon.icon,
                  size: 48,
                  color: selectedHabitIcon.color,
                ),
              ],
            ),
          ),

          ...categorizedIcons.entries.map((category) => Card(
                margin: const EdgeInsets.all(AppSpacing.marginS),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.paddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.key,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppFontSize.h4,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.marginM),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: category.value.length,
                        itemBuilder: (context, index) {
                          final icon = category.value[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedHabitIcon = HabitIcon(
                                  key: '${category.key}_$index',
                                  icon: icon,
                                  color: selectedHabitIcon.color,
                                  size: widget.defaultSize,
                                );
                              });
                              widget.onSelect(selectedHabitIcon);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedHabitIcon.icon == icon
                                      ? selectedHabitIcon.color!
                                      : Colors.grey,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Iconify(
                                  icon,
                                  size: widget.defaultSize,
                                  color: selectedHabitIcon.icon == icon
                                      ? selectedHabitIcon.color
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )),

          // Bảng màu
          Card(
            margin: const EdgeInsets.all(AppSpacing.marginS),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.pick_color,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.marginM),
                  ...colorPalette.map((colorRow) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: AppSpacing.paddingS),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: colorRow
                              .map((color) => InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedHabitIcon = HabitIcon(
                                          key: selectedHabitIcon.key,
                                          icon: selectedHabitIcon.icon,
                                          color: color,
                                          size: widget.defaultSize,
                                        );
                                      });
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: color,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              selectedHabitIcon.color == color
                                                  ? AppColors.primary
                                                  : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      )),
                ],
              ),
            ),
          ),

          // Button
          Padding(
            padding: const EdgeInsets.all(AppSpacing.paddingS),
            child: ElevatedButton(
              onPressed: () {
                widget.onSelect(selectedHabitIcon);
                SmartDialog.dismiss();
              },
              child: Text(
                S.current.accept_button,
                style: const TextStyle(
                  fontSize: AppFontSize.h3,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
