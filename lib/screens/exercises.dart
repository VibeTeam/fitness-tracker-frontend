import 'package:fitness_tracker_frontend/theme/app_colors.dart';
import 'package:fitness_tracker_frontend/widgets/custom_app_bar.dart';
import 'package:fitness_tracker_frontend/widgets/set_dialog.dart';
import 'package:flutter/material.dart';

class ExercisesPage extends StatelessWidget {
  final String title;
  const ExercisesPage({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: CustomAppBar(title: title, showBackButton: true),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: exercisesMap[title]!,
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

final Map<String, List<Widget>> exercisesMap = {
  'Chest': const [
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
  'Abs': const [
    _ExerciseCard(
        title: 'Crunches',
        description: 'Core-tightening exercise that emphasizes upper abdominal contraction for muscle tone'
    ),
    _ExerciseCard(
        title: 'Leg Raises',
        description: 'Lower-ab focused movement that builds core control and enhances midsection definition'
    ),
    _ExerciseCard(
        title: 'Russian Twists',
        description: 'Rotational core exercise that sharpens obliques and improves trunk stability'
    ),
    _ExerciseCard(
        title: 'Plank',
        description: 'Static hold that builds deep core endurance and full-body stabilization'
    ),
    _ExerciseCard(
        title: 'Bicycle Crunches',
        description: 'Dynamic ab movement combining flexion and rotation to target the entire core'
    ),
    _ExerciseCard(
        title: 'Mountain Climbers',
        description: 'Fast-paced cardio-core hybrid that activates abs while improving agility and endurance'
    ),
  ],
  'Back': const [
    _ExerciseCard(
      title: 'Pull-Ups',
      description: 'Essential bodyweight movement for building lat width and upper-body strength.',
    ),
    _ExerciseCard(
      title: 'Deadlifts',
      description: 'Full posterior chain builder that develops raw strength and back density.',
    ),
    _ExerciseCard(
      title: 'Bent-Over Rows',
      description: 'Compound pulling exercise that thickens the mid-back and improves posture.',
    ),
    _ExerciseCard(
      title: 'Lat Pulldowns',
      description: 'Machine-based vertical pull that widens the lats and strengthens the upper back.',
    ),
    _ExerciseCard(
      title: 'Superman Hold',
      description: 'Isometric move that builds lower back endurance and reinforces spinal alignment.',
    ),
    _ExerciseCard(
      title: 'Reverse Flys',
      description: 'Isolation exercise that enhances rear deltoid and upper-back definition.',
    ),
  ],
  'Arms': const [
    _ExerciseCard(
      title: 'Bicep Curls',
      description: 'Classic arm-building movement for developing peak size and shape in the biceps.',
    ),
    _ExerciseCard(
      title: 'Tricep Dips',
      description: 'Bodyweight push exercise that builds mass and definition in the triceps.',
    ),
    _ExerciseCard(
      title: 'Hammer Curls',
      description: 'Bicep and forearm builder that emphasizes arm thickness and grip strength.',
    ),
    _ExerciseCard(
      title: 'Overhead Tricep Extension',
      description: 'Stretch-focused movement that targets the long head of the triceps for fuller development.',
    ),
    _ExerciseCard(
      title: 'Concentration Curls',
      description: 'Focused isolation exercise for maximum bicep contraction and peak shaping.',
    ),
    _ExerciseCard(
      title: 'Close-Grip Push-Ups',
      description: 'Compound upper-body move that targets triceps while also working the chest.',
    ),
  ],
  'Legs': const [
    _ExerciseCard(
      title: 'Squats',
      description: 'Foundational lower-body exercise for building strength, mass, and functional mobility.',
    ),
    _ExerciseCard(
      title: 'Lunges',
      description: 'Unilateral leg movement that improves balance, stability, and muscular symmetry.',
    ),
    _ExerciseCard(
      title: 'Leg Press',
      description: 'Machine-based compound exercise for developing quad, hamstring, and glute power.',
    ),
    _ExerciseCard(
      title: 'Romanian Deadlifts',
      description: 'Posterior-chain dominant lift that emphasizes hamstring stretch and glute activation.',
    ),
    _ExerciseCard(
      title: 'Step-Ups',
      description: 'Functional strength exercise that targets quads and glutes with added balance work.',
    ),
    _ExerciseCard(
      title: 'Calf Raises',
      description: 'Isolation movement for developing lower leg strength, size, and endurance.',
    ),
  ],
  'Shoulders': const [
    _ExerciseCard(
      title: 'Shoulder Press',
      description: 'Compound lift that builds deltoid mass and upper-body pressing power.',
    ),
    _ExerciseCard(
      title: 'Lateral Raises',
      description: 'Isolation movement that adds width and definition to the side delts.',
    ),
    _ExerciseCard(
      title: 'Front Raises',
      description: 'Targeted exercise that builds front deltoid strength and shoulder shape.',
    ),
    _ExerciseCard(
      title: 'Arnold Press',
      description: 'Rotational pressing variation that fully engages all heads of the deltoid.',
    ),
    _ExerciseCard(
      title: 'Reverse Pec Deck Flys',
      description: 'Machine exercise for rear delts that improves shoulder balance and posture.',
    ),
    _ExerciseCard(
      title: 'Upright Rows',
      description: 'Compound pull that targets traps and lateral delts for a fuller shoulder look.',
    ),
  ],
};

