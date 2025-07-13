import 'package:fitness_tracker_frontend/theme/app_colors.dart';
import 'package:fitness_tracker_frontend/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: const CustomAppBar(title: 'Chest', showBackButton: true),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: const [
          _ExerciseCard(
            title: 'Bench press',
            description:
                'Classic barbell exercise to build overall chest strength and mass',
          ),
          _ExerciseCard(
            title: 'Incline bench press',
            description:
                'Targets the upper chest and shoulders using an inclined bench',
          ),
          _ExerciseCard(
            title: 'Decline bench press',
            description:
                'Emphasizes the lower chest using a declined bench position',
          ),
          _ExerciseCard(
            title: 'Dumbbell press',
            description:
                'Increases chest activation and improves muscle balance using dumbbells',
          ),
          _ExerciseCard(
            title: 'Chest fly',
            description: 'Isolates the chest muscles with a wide arc motion',
          ),
          _ExerciseCard(
            title: 'Cable crossover',
            description:
                'Constant tension exercise that targets inner chest definition',
          ),
        ],
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final String title;
  final String description;

  const _ExerciseCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: AppColors.black),
          ),
        ],
      ),
    );
  }
}
