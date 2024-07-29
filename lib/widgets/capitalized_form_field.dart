import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixel6/app_theme.dart';

class CapitalizedTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final void Function(String)? onChanged;

  const CapitalizedTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.onChanged,
  });

  @override
  State<CapitalizedTextFormField> createState() =>
      _CapitalizedTextFormFieldState();
}

class _CapitalizedTextFormFieldState extends State<CapitalizedTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      maxLength: widget.maxLength,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      decoration: InputDecoration(
        counterText: "",
        labelStyle: TextStyle(
          color: Colors.blueGrey.withOpacity(0.8),
          fontSize: 16,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        labelText: widget.labelText,
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
      ),
      onChanged: widget.onChanged,
    );
  }
}
