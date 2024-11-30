import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final Icon? suffixIcon;
  final String? hintText;
  final bool obscureText;
  final controller;
  final Icon? prefixIcon;

  MyTextField(
      {super.key, this.suffixIcon, this.hintText, required this.obscureText, required this.controller, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            labelText: hintText,
            labelStyle: TextStyle(color: Colors.grey[600]),
            suffixIcon: suffixIcon,
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.only(top: 10, left: 10),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.black)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.black)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.blue)),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.black))),
      ),
    );
  }
}
