import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_tracker_frontend/screens/exercises.dart';
import 'test_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  registerMockImageAssets();

  testWidgets('ExercisesPage shows a known exercise', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: ExercisesPage(title: 'Chest')),
    );

    expect(find.text('Chest'), findsOneWidget);       // App‑bar title
    expect(find.text('Bench press'), findsOneWidget); // First card
  });
}
