import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_tracker_frontend/theme/app_colors.dart';

void main() {
  test('AppColors constants remain unchanged', () {
    expect(AppColors.primaryBlue, const Color(0xff3981E0));
    expect(AppColors.grey,        const Color(0xffF5F5F5));
    expect(AppColors.black,       Colors.black);
    expect(AppColors.white,       Colors.white);
  });
}
