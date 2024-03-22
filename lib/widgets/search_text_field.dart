import 'package:flutter/material.dart';

import '../utils/utils.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.onTap,
    this.autofocus,
    this.readOnly,
    this.focusNode,
  }) : super(key: key);

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final VoidCallback? onTap;
  final bool? autofocus;
  final bool? readOnly;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        cursorColor: primaryColor,
        focusNode: focusNode,
        readOnly: readOnly ?? false,
        autofocus: autofocus ?? false,
        onTap: onTap,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: "Search",
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
          prefixIcon: IconButton(
              onPressed: onClear, icon: Image.asset("assets/png/search.png")),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFE4E4E4), width: 1.0),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        textInputAction: TextInputAction.search,
        controller: controller,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted);
  }
}
