import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum HabitIcon {
  water('water'),
  exercise('fitness'),
  waking('wake_up'),
  reading('book');

  final String iconName;
  const HabitIcon(this.iconName);

  static IconData getIconData(String? iconName) {
    switch (iconName) {
      case 'fitness':
        return Icons.fitness_center;
      case 'book':
        return FontAwesomeIcons.book;
      case 'water':
        return FontAwesomeIcons.droplet;
      case 'wake_up':
        return FontAwesomeIcons.sunPlantWilt;
      default:
        return Icons.event_repeat;
    }
  }
}
