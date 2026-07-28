// lib/src/printer/model/printer_paper_size.dart
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

enum PrinterPaperSize {
  mm58,
  mm80;

  PaperSize get toEscPosPaperSize => switch (this) {
    PrinterPaperSize.mm58 => PaperSize.mm58,
    PrinterPaperSize.mm80 => PaperSize.mm80,
  };

  String get storageValue => switch (this) {
    PrinterPaperSize.mm58 => 'mm58',
    PrinterPaperSize.mm80 => 'mm80',
  };

  static PrinterPaperSize fromStorageValue(String? value) {
    return switch (value) {
      'mm58' => PrinterPaperSize.mm58,
      _ => PrinterPaperSize.mm80,
    };
  }
}
