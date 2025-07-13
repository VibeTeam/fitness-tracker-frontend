import 'package:flutter/material.dart';

class TrainingsPage extends StatelessWidget {
  const TrainingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            const Text(
              'My Trainings',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Back & Biceps
            _TrainingCard(
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
            _TrainingCard(
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
            _TrainingCard(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
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
          Text(name),
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
