import 'package:fitness_tracker_frontend/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            const Text(
              'Profile',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Center(
              child: Image.asset(
                'assets/images/person.png',
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'a.chegaev@innopolis.university',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            RichText(
              text: const TextSpan(
                text: 'Total workouts\n',
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: '15',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 64),
            const Text(
              'AI assistant insight',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "You're making great progress! Upper body strength is improving steadily. Try adding one more leg session this week for better balance. Don't forget to increase weights slightly on your main lifts.",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Log out',
                style: TextStyle(
                  color: AppColors.primaryBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
