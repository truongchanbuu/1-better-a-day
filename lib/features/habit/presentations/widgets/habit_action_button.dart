import 'package:flutter/material.dart';

class HabitActionButton extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final Color backgroundColor;

  const HabitActionButton({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    required this.backgroundColor,
  });

  @override
  State<HabitActionButton> createState() => _HabitActionButtonState();
}

class _HabitActionButtonState extends State<HabitActionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.backgroundColor,
        ),
        child: Icon(
          widget.icon,
          color: widget.iconColor,
          size: 50,
        ),
      ),
    );
  }
}
