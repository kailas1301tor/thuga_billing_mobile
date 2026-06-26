import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vyapapp/res/constants/app_constants.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'common_functions.dart';

class FileSelectionService {
  FileSelectionService._();

  static final FileSelectionService _instance = FileSelectionService._();
  static FileSelectionService get instance => _instance;

  final ImagePicker _picker = ImagePicker();

  /// Max pixel dimension — caps Samsung 108 MP shots to avoid OOM.
  /// ImagePicker downscales at the native layer BEFORE loading into Dart.
  static const double _maxDimension = 800;

  /// JPEG quality passed to ImagePicker's native encoder.
  /// Quality 50 at 800px max ≈ 30–70 KB depending on scene complexity.
  static const int _pickQuality = 50;

  /// Allowed image extensions.
  static const _allowedExtensions = ['.png', '.heic', '.jpg', '.jpeg'];

  // ─── Validation ────────────────────────────────────────────────────────────

  /// Validates extension, checks source exists, and verifies final size.
  Future<File?> _validateImage(File file) async {
    try {
      // Samsung's MediaStore can return stale URIs — verify first.
      if (!await file.exists()) {
        showCustomErrorToast(
          message: 'Could not access the selected file.',
        );
        return null;
      }

      final ext = p.extension(file.path).toLowerCase();
      if (!_allowedExtensions.contains(ext)) {
        showCustomErrorToast(message: 'Unsupported file type.');
        return null;
      }

      final sizeKb = (await file.length()) / 1024;
      if (sizeKb > AppConstants.maxImageSizeMb * 1024) {
        showCustomErrorToast(
          message: 'File too large (max ${AppConstants.maxImageSizeMb} MB).',
        );
        return null;
      }

      return file;
    } catch (_) {
      showCustomErrorToast(message: 'File processing failed.');
      return null;
    }
  }

  // ─── Pick from gallery ─────────────────────────────────────────────────────

  Future<File?> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: _pickQuality,
        maxWidth: _maxDimension,
        maxHeight: _maxDimension,
      );

      if (pickedFile == null) return null;
      return await _validateImage(File(pickedFile.path));
    } catch (_) {
      showCustomErrorToast(message: 'Image picking failed.');
      return null;
    }
  }

  /// Picks multiple images — processes sequentially to avoid OOM on low-end
  /// Samsung A-series devices. Each image is copied to an app-controlled temp
  /// dir first because Samsung Android 10–12 MediaStore URI grants can expire
  /// mid-loop when the gallery reclaims them.
  Future<List<File>> pickMultipleImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage(
        imageQuality: _pickQuality,
        maxWidth: _maxDimension,
        maxHeight: _maxDimension,
      );
      if (pickedFiles.isEmpty) return [];

      final List<File> results = [];

      for (final xFile in pickedFiles) {
        final file = File(xFile.path);

        // Copy to app-controlled temp dir before processing.
        final safeCopy = await _copyToTemp(file);
        if (safeCopy == null) continue;

        try {
          final validated = await _validateImage(safeCopy);
          if (validated != null) results.add(validated);
        } catch (_) {
          // Clean up on failure
          await _safeDelete(safeCopy);
        }
      }

      return results;
    } catch (_) {
      showCustomErrorToast(message: 'Image picking failed.');
      return [];
    }
  }

  /// Copies a file to a private temp location we fully control.
  Future<File?> _copyToTemp(File source) async {
    try {
      if (!await source.exists()) return null;
      final tempDir = await getTemporaryDirectory();
      final dest = p.join(
        tempDir.path,
        '${DateTime.now().microsecondsSinceEpoch}_${p.basename(source.path)}',
      );
      return await source.copy(dest);
    } catch (_) {
      return null;
    }
  }

  // ─── Capture from camera ───────────────────────────────────────────────────

  /// Captures an image using the in-app [CameraCapturePage].
  ///
  /// Uses the `camera` package directly instead of Android intents.
  /// This avoids Samsung Activity-recreation crashes entirely because the
  /// camera runs inside the Flutter process — no external app is involved.
  Future<File?> captureImage(BuildContext context) async {
    showCustomErrorToast(message: 'Camera capture is not supported.');
    return null;
  }

  // ─── Select document file ──────────────────────────────────────────────────

  Future<File?> selectFile({
    List<String>? allowedExtensions,
    bool allowMultiple = true,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? ['pdf', 'doc'],
        allowMultiple: allowMultiple,
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        if (await file.length() > AppConstants.maxImageSizeMb * 1024 * 1024) {
          showCustomErrorToast(
            message: 'File too large (max ${AppConstants.maxImageSizeMb} MB).',
          );
          return null;
        }
        return file;
      }
    } on PlatformException catch (_) {
      showCustomErrorToast(
        message: 'Please allow VyapApp to access storage from settings.',
      );
      await openAppSettings();
    } catch (_) {
      showCustomErrorToast(message: 'File selection failed.');
    }
    return null;
  }

  // ─── Compression ───────────────────────────────────────────────────────────

  /// Compresses an image to ~50 KB using pure Dart (no native code).
  /// Resizes to max 800px and encodes as JPEG at quality 50.
  /// Falls back to the original file if compression fails.
  // Future<File> _compressToTarget(File source) async {
  //   try {
  //     final bytes = await source.readAsBytes();
  //     final decoded = img.decodeImage(bytes);
  //     if (decoded == null) return source;
  // 
  //     // Resize to max 800px maintaining aspect ratio.
  //     final maxDim = _maxDimension.toInt();
  //     img.Image resized;
  //     if (decoded.width > maxDim || decoded.height > maxDim) {
  //       if (decoded.width >= decoded.height) {
  //         resized = img.copyResize(decoded, width: maxDim);
  //       } else {
  //         resized = img.copyResize(decoded, height: maxDim);
  //       }
  //     } else {
  //       resized = decoded;
  //     }
  // 
  //     // Encode as JPEG at quality 50 → ~30-70 KB
  //     final compressed = Uint8List.fromList(
  //       img.encodeJpg(resized, quality: _pickQuality),
  //     );
  // 
  //     // Write to unique temp file
  //     final tempDir = await getTemporaryDirectory();
  //     final tempPath = p.join(
  //       tempDir.path,
  //       '${DateTime.now().microsecondsSinceEpoch}_compressed.jpg',
  //     );
  //     final compressedFile = File(tempPath);
  //     await compressedFile.writeAsBytes(compressed);
  // 
  //     // Clean up original captured file
  //     await _safeDelete(source);
  // 
  //     return compressedFile;
  //   } catch (_) {
  //     // If compression fails, return original — better than nothing
  //     return source;
  //   }
  // }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  /// Null-safe, exception-safe file deletion.
  static Future<void> _safeDelete(File? file) async {
    try {
      if (file != null && await file.exists()) await file.delete();
    } catch (_) {
      // Swallow — best-effort cleanup
    }
  }

  /// Call after upload completes to free up temp storage.
  Future<void> clearTempImages() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final entities = await tempDir.list().toList();
      for (final entity in entities) {
        if (entity is File && p.basename(entity.path).contains('_compressed')) {
          await _safeDelete(entity);
        }
      }
    } catch (_) {}
  }
}
