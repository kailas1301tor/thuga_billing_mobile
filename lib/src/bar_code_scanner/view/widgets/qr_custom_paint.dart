import 'package:flutter/material.dart';

class BarcodeScanCorners extends StatelessWidget {
  final double cutOutWidth;
  final double cutOutHeight;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;
  final double cornerLength;
  final bool isProductFound;

  const BarcodeScanCorners({
    super.key,
    required this.cutOutWidth,
    required this.cutOutHeight,
    this.borderColor,
    this.borderRadius = 8.0,
    this.borderWidth = 4.0,
    this.cornerLength = 30.0,
    this.isProductFound = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final scanRect = Rect.fromLTWH(
      (screenSize.width - cutOutWidth) / 2,
      (screenSize.height - cutOutHeight) / 2,
      cutOutWidth,
      cutOutHeight,
    );

    // Determine the color based on product found status
    final effectiveBorderColor =
        borderColor ?? (isProductFound ? Colors.green : Colors.white);

    return CustomPaint(
      size: screenSize,
      painter: BorderPainter(
        scanRect: scanRect,
        borderColor: effectiveBorderColor,
        borderRadius: borderRadius,
        borderWidth: borderWidth,
        cornerLength: cornerLength,
        isProductFound: isProductFound,
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  final Rect scanRect;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double cornerLength;
  final bool isProductFound;

  BorderPainter({
    required this.scanRect,
    required this.borderColor,
    required this.borderRadius,
    required this.borderWidth,
    required this.cornerLength,
    required this.isProductFound,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the dim overlay
    final overlayPath =
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final cutOutPath =
        Path()
          ..addRRect(
            RRect.fromRectAndRadius(scanRect, Radius.circular(borderRadius)),
          )
          ..close();

    final dimPath = Path.combine(
      PathOperation.difference,
      overlayPath,
      cutOutPath,
    );

    final paint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.6),
              Colors.black.withValues(alpha: 0.75),
            ],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
          ..style = PaintingStyle.fill;

    canvas.drawPath(dimPath, paint);

    // Draw corner brackets or full border based on product found status
    final cornerPaint =
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth
          ..strokeCap = StrokeCap.round;

    if (isProductFound) {
      // Draw full border when product is found
      canvas.drawRRect(
        RRect.fromRectAndRadius(scanRect, Radius.circular(borderRadius)),
        cornerPaint,
      );
    } else {
      // Draw faint full border in background
      final faintPaint =
          Paint()
            ..color = borderColor.withAlpha(150)
            ..style = PaintingStyle.stroke
            ..strokeWidth = borderWidth / 2;

      canvas.drawRRect(
        RRect.fromRectAndRadius(scanRect, Radius.circular(borderRadius)),
        faintPaint,
      );

      // Draw corner brackets over faint border
      _drawCorners(canvas, cornerPaint);
    }
  }

  void _drawCorners(Canvas canvas, Paint paint) {
    final left = scanRect.left;
    final right = scanRect.right;
    final top = scanRect.top;
    final bottom = scanRect.bottom;

    // Top-left corner
    canvas.drawLine(
      Offset(left, top + cornerLength),
      Offset(left, top + borderRadius),
      paint,
    );
    canvas.drawArc(
      Rect.fromLTWH(left, top, borderRadius * 2, borderRadius * 2),
      3.14159, // 180 degrees in radians
      1.5708, // 90 degrees in radians
      false,
      paint,
    );
    canvas.drawLine(
      Offset(left + borderRadius, top),
      Offset(left + cornerLength, top),
      paint,
    );

    // Top-right corner
    canvas.drawLine(
      Offset(right - cornerLength, top),
      Offset(right - borderRadius, top),
      paint,
    );
    canvas.drawArc(
      Rect.fromLTWH(
        right - borderRadius * 2,
        top,
        borderRadius * 2,
        borderRadius * 2,
      ),
      4.71239, // 270 degrees in radians
      1.5708, // 90 degrees in radians
      false,
      paint,
    );
    canvas.drawLine(
      Offset(right, top + borderRadius),
      Offset(right, top + cornerLength),
      paint,
    );

    // Bottom-right corner
    canvas.drawLine(
      Offset(right, bottom - cornerLength),
      Offset(right, bottom - borderRadius),
      paint,
    );
    canvas.drawArc(
      Rect.fromLTWH(
        right - borderRadius * 2,
        bottom - borderRadius * 2,
        borderRadius * 2,
        borderRadius * 2,
      ),
      0, // 0 degrees in radians
      1.5708, // 90 degrees in radians
      false,
      paint,
    );
    canvas.drawLine(
      Offset(right - borderRadius, bottom),
      Offset(right - cornerLength, bottom),
      paint,
    );

    // Bottom-left corner
    canvas.drawLine(
      Offset(left + cornerLength, bottom),
      Offset(left + borderRadius, bottom),
      paint,
    );
    canvas.drawArc(
      Rect.fromLTWH(
        left,
        bottom - borderRadius * 2,
        borderRadius * 2,
        borderRadius * 2,
      ),
      1.5708, // 90 degrees in radians
      1.5708, // 90 degrees in radians
      false,
      paint,
    );
    canvas.drawLine(
      Offset(left, bottom - borderRadius),
      Offset(left, bottom - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
