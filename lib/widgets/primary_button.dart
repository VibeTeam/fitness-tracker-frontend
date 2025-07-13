import 'package:fitness_tracker_frontend/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final double borderRadius;
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.borderRadius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.6,
      child: GestureDetector(
        onTap: enabled ? onPressed : null,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: AppColors.primaryGradient,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
