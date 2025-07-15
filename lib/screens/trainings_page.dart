import 'package:fitness_tracker_frontend/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TrainingsPage extends StatelessWidget {
  const TrainingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.grey,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'My Trainings',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            const SizedBox(height: 20),
            // Back & Biceps
            const _TrainingCard(
              title: 'Back & Biceps',
              date: 'Sat, Jan 20',
              exercises: [
                _ExerciseRow('Pull-ups', 'x4', Colors.green),
                _ExerciseRow('Horizontal rows', 'x4', Colors.green),
                _SetRow('Set 1: 40kg x 12'),
                _SetRow('Set 2: 45kg x 8'),
                _SetRow('Set 3: 50kg x 8', color: Colors.green),
                _SetRow('Set 4: 50kg x 7', color: Colors.green),
                _ExerciseRow('Biceps curls', 'x3'),
                _ExerciseRow('Hammer curls', 'x2'),
              ],
            ),
            const SizedBox(height: 16),
            // Chest & Triceps
            const _TrainingCard(
              title: 'Chest & Triceps',
              date: 'Wed, Jan 17',
              exercises: [
                _ExerciseRow('Bench press', 'x4', Colors.green),
                _ExerciseRow('Dumbbell press', 'x2'),
                _ExerciseRow('Skull crusher', 'x2', Colors.red),
                _SetRow('Set 1: 17kg x 12', color: Colors.red),
                _SetRow('Set 2: 15kg x 10', color: Colors.red),
                _ExerciseRow('Triceps pushdown', 'x3'),
              ],
            ),
            const SizedBox(height: 16),
            // Legs & Abs
            const _TrainingCard(
              title: 'Legs & Abs',
              date: 'Mon, Jan 15',
              exercises: [
                _ExerciseRow('Leg press', 'x3'),
                _ExerciseRow('Leg extensions', 'x4', Colors.green),
                _ExerciseRow('Calves', 'x2'),
                _ExerciseRow('Oblique crunches', 'x3'),
                _ExerciseRow('Crunch machine', 'x3'),
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.primaryGradient,
        ),
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (context) => DraggableScrollableSheet(
                initialChildSize: 0.7, // 70% экрана
                minChildSize: 0.4,
                maxChildSize: 0.95,
                expand: false,
                builder: (context, scrollController) => SingleChildScrollView(
                  controller: scrollController,
                  child: const _AddTrainingModal(),
                ),
              ),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, color: AppColors.white, size: 32),
        ),
      ),
    );
  }
}

class _TrainingCard extends StatelessWidget {
  final String title;
  final String date;
  final List<Widget> exercises;

  const _TrainingCard({
    required this.title,
    required this.date,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...exercises,
          ],
        ),
      ),
    );
  }
}

class _ExerciseRow extends StatelessWidget {
  final String name;
  final String count;
  final Color? color;

  const _ExerciseRow(this.name, this.count, [this.color]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.black54
            ),
          ),
          const SizedBox(width: 6),
          Text(
            count,
            style: TextStyle(
              color: color ?? Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SetRow extends StatelessWidget {
  final String text;
  final Color? color;

  const _SetRow(this.text, {this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, top: 1, bottom: 1),
      child: Text(
        text,
        style: TextStyle(color: color ?? Colors.grey[800], fontSize: 13),
      ),
    );
  }
}

class _AddTrainingModal extends StatelessWidget {
  const _AddTrainingModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'New workout',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: null,
                      decoration: InputDecoration(
                        hintText: 'Enter title',
                        filled: true,
                        fillColor: AppColors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pull ups x3',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 6),
                          Text('Set 1: 12'),
                          Text('Set 2: 11'),
                          Text('Set 3: 9'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/exercises_group'
                    ),
                    child: const Text(
                      'Add exercise',
                      style: TextStyle(color: Color(0xFF3981E0), fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 44,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
