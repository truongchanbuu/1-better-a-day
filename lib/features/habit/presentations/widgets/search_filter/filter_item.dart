import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../../core/constants/app_font_size.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/extensions/context_extension.dart';
import 'habit_progressing_status_slider.dart';

enum FilterType { selection, range }

class FilterItem extends StatefulWidget {
  final FilterType type;
  final String? selected;
  final List<String> items;
  final String title;
  final double width;
  final VoidCallback? onTap;
  final ValueChanged<String?>? onChanged;
  final IconStyleData? iconStyleData;

  const FilterItem({
    super.key,
    required this.title,
    required this.items,
    required this.width,
    this.type = FilterType.selection,
    this.selected,
    this.onTap,
    this.iconStyleData,
    this.onChanged,
  });

  @override
  State<FilterItem> createState() => FilterItemState();
}

class FilterItemState extends State<FilterItem> {
  String? selected;
  String? title;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  static const _textStyle = TextStyle(
    fontSize: AppFontSize.bodyLarge,
  );
  static const _borderRadius =
      BorderRadius.all(Radius.circular(AppSpacing.circleRadius));
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.type == FilterType.range ? _openRangeSlider : widget.onTap,
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          color: context.isDarkMode
              ? AppColors.primaryDark
              : AppColors.grayBackgroundColor,
        ),
        margin: const EdgeInsets.only(right: AppSpacing.marginS),
        child: DropdownButtonFormField2<String>(
          hint: Text(
            title != null && widget.type == FilterType.range
                ? title!
                : widget.title,
            style: _textStyle,
          ),
          iconStyleData: widget.iconStyleData ?? const IconStyleData(),
          value: selected,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppSpacing.circleRadius)),
            ),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            contentPadding: EdgeInsets.zero,
          ),
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.paddingM),
          ),
          dropdownStyleData: DropdownStyleData(width: max(widget.width, 150)),
          isExpanded: true,
          onChanged: (value) {
            setState(() {
              selected = value;
            });

            widget.onChanged?.call(selected);
          },
          selectedItemBuilder: (context) =>
              widget.items.map((item) => Text(item.toString())).toList(),
          items: _convertItem(),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _convertItem() {
    switch (widget.type) {
      case FilterType.selection:
        return widget.items
            .map((item) => DropdownMenuItem(
                  value: item,
                  enabled: selected != item,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.toString()),
                      if (selected == item)
                        const Icon(
                          FontAwesomeIcons.check,
                          color: AppColors.success,
                        ),
                    ],
                  ),
                ))
            .toList();
      case FilterType.range:
        return [];
    }
  }

  void _openRangeSlider() async {
    final String? paramProgressing = selected?.replaceAll('%', '');
    final String? selectedProgressing = await SmartDialog.show<String>(
      builder: (context) => HabitProgressingStatusSlider(
        singleValue: (paramProgressing?.isNotEmpty ?? false) &&
                !paramProgressing!.contains('-')
            ? double.parse(paramProgressing)
            : 0,
        rangeValues: (paramProgressing?.isNotEmpty ?? false) &&
                paramProgressing!.contains('-')
            ? paramProgressing
            : '',
      ),
    );

    if (selectedProgressing != null) {
      setState(() {
        selected = '$selectedProgressing%';
        title = selected;
      });

      widget.onChanged?.call(selected);
    }
  }
}
