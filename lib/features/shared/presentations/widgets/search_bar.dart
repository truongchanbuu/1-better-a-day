import 'package:flutter/material.dart';

class AppSearchBar extends StatefulWidget {
  final String hintText;
  final TextEditingController? searchController;
  final ValueChanged<String>? onChanged;

  const AppSearchBar({
    super.key,
    required this.hintText,
    this.searchController,
    this.onChanged,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late final FocusNode _focusNode;

  bool isSearching = false;

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
    return TextField(
      controller: widget.searchController,
      focusNode: _focusNode,
      onTapOutside: (event) {
        _toggleSearch(false);
        _focusNode.unfocus();
      },
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
        suffixIcon: GestureDetector(
          onTap: () {
            _toggleSearch();

            if (!isSearching) {
              widget.searchController?.clear();
              _focusNode.unfocus();
            } else {
              _focusNode.requestFocus();
            }
          },
          child:
              !isSearching ? const Icon(Icons.search) : const Icon(Icons.close),
        ),
      ),
      onTap: () => _toggleSearch(true),
    );
  }

  void _toggleSearch([bool? value]) {
    setState(() {
      isSearching = value ?? !isSearching;
    });
  }
}
