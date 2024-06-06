import 'package:flutter/material.dart';

class SearchFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefix;
  final Function? onSubmit;
  final void Function(String)? onChanged;
  final Function? filterAction;
  final bool isFilter;
  const SearchFieldWidget({
    super.key,
    required this.controller,
    required this.hint,
    required this.prefix,
    this.onSubmit,
    this.onChanged,
    this.filterAction,
    this.isFilter = false,
  });

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE7E7E7), width: 1.0),
          borderRadius: BorderRadius.circular(30),
        ),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        prefixIcon: Icon(widget.prefix, color: Theme.of(context).hintColor),
      ),
    );
  }
}
