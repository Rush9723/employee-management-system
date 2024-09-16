// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController textController;
  final ValueChanged<String> onSubmitted;

  const CustomSearchBar({
    Key? key,
    required this.textController,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        controller: widget.textController,
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              widget.textController.clear();
              widget.onSubmitted('');
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
