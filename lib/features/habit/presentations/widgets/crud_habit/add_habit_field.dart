import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/constants/app_color.dart';

class AddHabitField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initValue;
  final String label;
  final int? maxLines;
  final Widget? suffix;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final EdgeInsets? contentPadding;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidateMode;

  const AddHabitField({
    super.key,
    required this.label,
    this.maxLines,
    this.suffix,
    this.onChanged,
    this.onTap,
    this.inputFormatters = const [],
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.contentPadding,
    this.controller,
    this.initValue,
    this.validator,
    this.autoValidateMode,
  });

  @override
  State<AddHabitField> createState() => AddHabitFieldState();
}

class AddHabitFieldState extends State<AddHabitField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: widget.autoValidateMode,
      validator: widget.validator,
      controller: widget.controller,
      initialValue: widget.initValue,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      focusNode: _focusNode,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        labelText: widget.label,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        errorStyle: const TextStyle(overflow: TextOverflow.visible),
        suffix: widget.suffix,
      ),
      maxLines: widget.maxLines,
    );
  }
}
