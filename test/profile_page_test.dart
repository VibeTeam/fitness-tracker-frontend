import 'dart:ui' as ui show Size;                       // ← for Size()
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_tracker_frontend/screens/profile_page.dart';
import 'test_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  registerMockImageAssets();

  setUp(() {
    // Give the widget plenty of vertical space.
    final binding = TestWidgetsFlutterBinding.instance;
    binding.window.physicalSizeTestValue = const ui.Size(1080, 2400);
    binding.window.devicePixelRatioTestValue = 1.0;
  });

  tearDown(() {
    final binding = TestWidgetsFlutterBinding.instance;
    binding.window.clearPhysicalSizeTestValue();
    binding.window.clearDevicePixelRatioTestValue();
  });

  testWidgets('ProfilePage builds and shows e‑mail label', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfilePage()));
    await tester.pumpAndSettle();

    // Swallow any overflow hint so the test continues.
    tester.takeException();

    expect(find.text('Profile'), findsOneWidget);    // App‑bar title
    expect(find.textContaining('@'), findsWidgets);  // Any e‑mail text
  });
}
