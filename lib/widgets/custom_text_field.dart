import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final double borderRadius;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.borderRadius = 16.0, // значение по умолчанию
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}
