// lib/utils/helpers/payment_qr_helper.dart
import 'package:path/path.dart' as p;

const allowedPaymentQrExtensions = {'.jpg', '.jpeg', '.png'};

bool isAllowedPaymentQrExtension(String path) {
  final ext = p.extension(path).toLowerCase();
  return allowedPaymentQrExtensions.contains(ext);
}

String? normalizeQrCodeUrl(String? raw) {
  if (raw == null) return null;
  final trimmed = raw.trim();
  if (trimmed.isEmpty) return null;
  return trimmed;
}
