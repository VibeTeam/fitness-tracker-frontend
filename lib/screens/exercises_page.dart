import 'package:fitness_tracker_frontend/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'package:fitness_tracker_frontend/screens/exercises.dart';

class ExercisesGroupPage extends StatelessWidget {
  const ExercisesGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: const CustomAppBar(title: 'Exercises', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Muscle groups',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: const [
                  _MuscleGroupCard(
                    title: 'Chest',
                    asset: 'assets/images/chest.png',
                  ),
                  _MuscleGroupCard(
                    title: 'Abs',
                    asset: 'assets/images/abs.png',
                  ),
                  _MuscleGroupCard(
                    title: 'Back',
                    asset: 'assets/images/back.png',
                  ),
                  _MuscleGroupCard(
                    title: 'Arms',
                    asset: 'assets/images/arms.png',
                  ),
                  _MuscleGroupCard(
                    title: 'Legs',
                    asset: 'assets/images/legs.png',
                  ),
                  _MuscleGroupCard(
                    title: 'Shoulders',
                    asset: 'assets/images/shoulders.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MuscleGroupCard extends StatelessWidget {
  final String title;
  final String asset;

  const _MuscleGroupCard({required this.title, required this.asset});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ExercisesPage()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset, width: 80, height: 80),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
