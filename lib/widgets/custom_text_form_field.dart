import 'package:flutter/material.dart';
import 'package:pixel6/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      required this.controller,
      required this.keyboardType,
      this.validator,
      this.maxLength,
      this.prefix,
      this.onChanged,
      this.initialValue});

  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final Widget? prefix;
  final void Function(String)? onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      maxLength: maxLength,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        counterText: "",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.black,
            )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: onSurfaceColor),
        ),
        labelText: labelText,
        prefixIcon: prefixIcon,
        prefix: prefix,
        prefixStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        suffixIcon: suffixIcon,
        labelStyle: TextStyle(
          color: Colors.blueGrey.withOpacity(0.8),
          fontSize: 16,
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    );
  }
}
