// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormInput extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool? obscureText;
  final int? maxLines;

  final void Function(String?)? onSaved;
  final TextEditingController controller;
  final Widget? icon;
  Widget? suffixIcon;
  final String? Function(String?)? validator;
  int? maxLength;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;
  TextFormInput({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.obscureText,
    this.maxLines = 1,
    this.onSaved,
    required this.controller,
    this.icon,
    this.validator,
    this.suffixIcon,
    this.maxLength,
    this.inputFormatters,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      maxLength: maxLength,
      onSaved: onSaved,
      obscureText: obscureText!,
      controller: controller,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: const TextStyle(
        fontSize: 15.3,
        color: Color.fromARGB(255, 125, 116, 116),
        fontWeight: FontWeight.w600,
      ),
      onChanged: (value) {},
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFD9D9D9),
        hoverColor: Colors.green,
        prefixIcon: icon,
        suffixIcon: suffixIcon,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 26, 10, 7), width: 1.1),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 219, 35, 35), width: 1.1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 65, 56, 56), width: 1.1),
          borderRadius: BorderRadius.circular(7.0),
        ),
        focusColor: const Color.fromARGB(255, 221, 197, 197),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 1.0, horizontal: 15.0),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 0.1),
          borderRadius: BorderRadius.circular(7.0),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        labelText: labelText,
      ),
    );
  }
}
