import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_tracker_frontend/screens/sign_up_page.dart';
import 'test_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  registerMockImageAssets();

  testWidgets('Sign-up button is present', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignUpPage()));
    expect(find.text('Sign up'), findsOneWidget);
  });
}
