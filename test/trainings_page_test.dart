import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_tracker_frontend/screens/trainings_page.dart';
import 'test_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  registerMockImageAssets();

  testWidgets('TrainingsPage lists Back & Biceps routine', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: TrainingsPage()));
    expect(find.text('Back & Biceps'), findsOneWidget);
  });
}
