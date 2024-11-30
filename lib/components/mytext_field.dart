import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final Function()? onFocus;
  final Function()? onBlur;

  const MyTextField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
    this.controller,
    this.onFocus,
    this.onBlur,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // Listen for focus changes
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Call the onFocus callback if provided
        if (widget.onFocus != null) {
          widget.onFocus!();
        }
      } else {
        // Call the onBlur callback if provided
        if (widget.onBlur != null) {
          widget.onBlur!();
        }
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: TextField(
          focusNode: _focusNode,
          style: TextStyle(color: Colors.grey[400]),
          obscureText: widget.obscureText,
          controller: widget.controller,
          // Input decoration
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[700]),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            contentPadding: const EdgeInsets.all(8),
            filled: true,
            fillColor: Colors.grey[850],

            // Disabled border
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade600,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6)),

            // Enabled border
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade600,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6)),

            // Focused border
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueAccent.shade400,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ),
    );
  }
}
