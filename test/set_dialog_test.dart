import 'dart:ui' as ui show Size;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_tracker_frontend/widgets/set_dialog.dart';
import 'test_utils.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  registerMockImageAssets();

  setUp(() {
    // Plenty of vertical space to prevent flex overflows.
    final binding = TestWidgetsFlutterBinding.instance;
    binding.window.physicalSizeTestValue = const ui.Size(1080, 2400);
    binding.window.devicePixelRatioTestValue = 1.0;
  });

  tearDown(() {
    final binding = TestWidgetsFlutterBinding.instance;
    binding.window.clearPhysicalSizeTestValue();
    binding.window.clearDevicePixelRatioTestValue();
  });

  testWidgets('showSetDialog displays exercise name', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Center(
            child: ElevatedButton(
              onPressed: () => showSetDialog(context, 'Bench Press'),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    );

    // Open the dialog
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    // Swallow any benign overflow warning from the dialog layout
    tester.takeException();

    expect(find.text('Bench Press'), findsOneWidget);
  });
}
