import 'package:flutter/material.dart';

class SettingSelectionBottomSheet<T> extends StatelessWidget {
  final T? selected;
  final List<T> choices;
  final void Function(T choice)? onSelected;

  const SettingSelectionBottomSheet({
    super.key,
    required this.choices,
    this.onSelected,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: choices
            .map((selection) => _buildChoice(context, selection))
            .toList(),
      ),
    );
  }

  Widget _buildChoice(BuildContext context, T data) {
    return ListTile(
      onTap: () {
        if (selected != data) {
          onSelected?.call(data);
        }

        Navigator.pop(context);
      },
      title: Text(data.toString()),
      trailing: data == selected
          ? const Icon(Icons.check, color: Colors.green)
          : null,
    );
  }
}
