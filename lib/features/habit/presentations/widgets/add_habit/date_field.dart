import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/helpers/date_time_helper.dart';
import '../../../../../core/helpers/setting_helper.dart';

class DateField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final DateTime selectedDate;
  final void Function(DateTime selected)? onSelected;
  final FormFieldValidator<String>? validator;

  const DateField({
    super.key,
    required this.selectedDate,
    this.hintText,
    this.labelText,
    this.onSelected,
    this.validator,
  });

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  late final TextEditingController _textEditingController;

  static const vietnameseDateFormat = 'dd/MM/yyyy';
  static const englishDateFormat = 'yyyy/MM/dd';

  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: _format(widget.selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    final langCode = context.locale.languageCode;

    return TextFormField(
      validator: widget.validator,
      controller: _textEditingController,
      onTap: () => _openDatePicker(langCode),
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText ??
            (context.locale.languageCode == LanguageCode.vi.name
                ? vietnameseDateFormat
                : englishDateFormat),
        prefixIcon: const Icon(
          FontAwesomeIcons.clock,
          color: AppColors.grayText,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  Future<void> _openDatePicker(String langCode) async {
    final selected = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      widget.onSelected?.call(selected);
      _textEditingController.text = _format(selected, langCode);
    }
  }

  String _format(DateTime date, [String langCode = 'en']) {
    return DateTimeHelper.formatFullDate(
      date,
      pattern: langCode == LanguageCode.vi.name
          ? vietnameseDateFormat
          : englishDateFormat,
    );
  }
}
