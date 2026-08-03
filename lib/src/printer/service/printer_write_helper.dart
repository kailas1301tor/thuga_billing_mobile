// lib/src/printer/service/printer_write_helper.dart
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/utils/helpers/extensions.dart';
import 'package:thuga/utils/helpers/printer_error_helper.dart';

typedef PrinterChunkWriter = Future<bool> Function(List<int> chunk);

Future<bool> writeBytesInChunks({
  required List<int> bytes,
  required PrinterChunkWriter writeChunk,
  required void Function(PrinterError error) onChunkError,
  int chunkSize = 512,
  Duration interChunkDelay = const Duration(milliseconds: 75),
  required String action,
  Map<String, Object?>? context,
}) async {
  if (bytes.isEmpty) {
    return true;
  }

  final chunks = bytes.chunk(chunkSize);
  for (var index = 0; index < chunks.length; index++) {
    final success = await writeChunk(chunks[index]);
    if (!success) {
      onChunkError(
        PrinterError(
          code: PrinterErrorCodes.printFailed,
          message:
              'writeBytes returned false at chunk ${index + 1}/${chunks.length}',
          userMessage: Strings.printerPrintFailed,
        ),
      );
      return false;
    }

    if (chunks.length > 1 && index < chunks.length - 1) {
      await Future<void>.delayed(interChunkDelay);
    }
  }

  return true;
}
