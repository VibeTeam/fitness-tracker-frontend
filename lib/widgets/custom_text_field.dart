import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final double borderRadius;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.borderRadius = 16.0,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xff7F7F7F)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
