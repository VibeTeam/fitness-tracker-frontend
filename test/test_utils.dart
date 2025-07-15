import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void registerMockImageAssets() {
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  /* ---- data blobs ------------------------------------------------------- */

  // Transparent PNG (1×1).
  const pngBytes = <int>[
    0x89,0x50,0x4E,0x47,0x0D,0x0A,0x1A,0x0A,
    0x00,0x00,0x00,0x0D,0x49,0x48,0x44,0x52,
    0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x01,
    0x08,0x06,0x00,0x00,0x00,0x1F,0x15,0xC4,
    0x89,0x00,0x00,0x00,0x0A,0x49,0x44,0x41,
    0x54,0x78,0x9C,0x63,0x60,0x00,0x00,0x00,
    0x02,0x00,0x01,0xE5,0x27,0xD4,0xA2,0x00,
    0x00,0x00,0x00,0x49,0x45,0x4E,0x44,0xAE,
    0x42,0x60,0x82
  ];
  final pngData = Uint8List.fromList(pngBytes).buffer.asByteData();

  // Empty JSON `{}` as UTF‑8.
  final emptyJson =
      Uint8List.fromList(utf8.encode('{}')).buffer.asByteData();

  // Empty manifest encoded with StandardMessageCodec (for .bin files).
  final codec = const StandardMessageCodec();
  final emptyBin = codec.encodeMessage(<dynamic, dynamic>{})!;

  /* ---- channel stub ----------------------------------------------------- */

  messenger.setMockMessageHandler('flutter/assets', (ByteData? message) async {
    final key = utf8.decode(message!.buffer.asUint8List());

    // Any manifest => return an empty one in the expected encoding.
    if (key.contains('Manifest')) {
      return key.endsWith('.bin') ? emptyBin : emptyJson;
    }

    // Everything else (images, icons, etc.) => 1×1 transparent pixel.
    return pngData;
  });
}
