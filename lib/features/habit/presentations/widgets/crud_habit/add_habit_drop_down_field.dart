import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_spacing.dart';

class AddHabitDropdownField extends StatefulWidget {
  final String? selected;
  final String? title;
  final List<String> items;
  final ValueChanged<String?>? onSelected;
  final FormFieldValidator<String>? validator;

  const AddHabitDropdownField({
    super.key,
    required this.items,
    this.title,
    this.onSelected,
    this.selected,
    this.validator,
  });

  @override
  State<AddHabitDropdownField> createState() => _AddHabitDropdownFieldState();
}

class _AddHabitDropdownFieldState extends State<AddHabitDropdownField> {
  String? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<String>(
        validator: widget.validator,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: AppSpacing.paddingM),
          errorMaxLines: 3,
        ),
        value: _selected,
        hint: widget.title != null ? Text(widget.title!) : null,
        isExpanded: true,
        iconStyleData: IconStyleData(
          icon: _selected == null
              ? const Icon(Icons.arrow_drop_down)
              : const SizedBox.shrink(),
        ),
        onChanged: (value) {
          setState(() {
            _selected = value;
          });
          widget.onSelected?.call(_selected);
        },
        menuItemStyleData: MenuItemStyleData(
          selectedMenuItemBuilder: (context, child) => Container(
            color: AppColors.primary.withValues(alpha: .2),
            child: child,
          ),
        ),
        items: widget.items.map(
          (item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          },
        ).toList(),
      ),
    );
  }
}
