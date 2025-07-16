import 'package:fitness_tracker_frontend/theme/app_colors.dart';
import 'package:fitness_tracker_frontend/widgets/custom_app_bar.dart';
import 'package:fitness_tracker_frontend/widgets/set_dialog.dart';
import 'package:flutter/material.dart';
import '../services/workout_service.dart';
import '../models/workout_models.dart';
import '../utils/toast_utils.dart';

class ExercisesPage extends StatefulWidget {
  final String title;
  final int muscleGroupId;

  const ExercisesPage({
    required this.title,
    required this.muscleGroupId,
    super.key,
  });

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  List<WorkoutType> _exercises = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    try {
      final exercises = await WorkoutService.getWorkoutTypesByMuscleGroup(
        widget.muscleGroupId,
      );
      if (mounted) {
        setState(() {
          _exercises = exercises;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ToastUtils.showError('Failed to load exercises');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: CustomAppBar(title: widget.title, showBackButton: true),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadExercises,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                children: _exercises
                    .map(
                      (exercise) => _ExerciseCard(
                        title: exercise.name,
                        description: ExerciseDescription.getDescription(
                          exercise.name,
                        ),
                      ),
                    )
                    .toList(),
              ),
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
    return GestureDetector(
      onTap: () {
        showSetDialog(context, title);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
