// lib/utils/helpers/share_image_helper.dart
import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

Future<void> sharePngBytes({
  required Uint8List bytes,
  required String fileName,
  String? shareText,
}) async {
  final normalizedName =
      fileName.endsWith('.png') ? fileName : '$fileName.png';

  await SharePlus.instance.share(
    ShareParams(
      files: [
        XFile.fromData(
          bytes,
          mimeType: 'image/png',
          name: normalizedName,
        ),
      ],
      text: shareText,
    ),
  );
}
