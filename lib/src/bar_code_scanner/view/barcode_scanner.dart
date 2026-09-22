// lib/src/bar_code_scanner/view/barcode_scanner.dart
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'widgets/animated_scan_line.dart';
import 'widgets/qr_custom_paint.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({
    super.key,
    this.onScanned,
    this.title,
  });

  /// Optional callback invoked when a barcode is successfully detected.
  /// If omitted, the screen pops and returns the barcode [String].
  final ValueChanged<String>? onScanned;

  /// Optional title displayed at the top of the scanner overlay.
  final String? title;

  /// Convenience static helper to push the scanner and await the result.
  static Future<String?> scan(BuildContext context, {String? title}) async {
    return Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => BarcodeScanner(title: title),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner>
    with SingleTickerProviderStateMixin {
  late final MobileScannerController _scannerController;
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  final ValueNotifier<String?> _scannedCodeNotifier = ValueNotifier<String?>(null);
  bool _isHandlingScan = false;

  final double scanAreaWidth = 280.w;
  final double scanAreaHeight = 160.h;
  final double scanBorderWidth = 4.h;
  final double scanBorderRadius = 20.r;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      torchEnabled: false,
    );

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scannedCodeNotifier.dispose();
    _scannerController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isHandlingScan) return;

    for (final barcode in capture.barcodes) {
      final code = barcode.rawValue?.trim() ?? barcode.displayValue?.trim();
      if (code != null && code.isNotEmpty) {
        _handleResult(code);
        break;
      }
    }
  }

  void _handleResult(String barcode) {
    if (_isHandlingScan) return;
    _isHandlingScan = true;

    HapticFeedback.mediumImpact();
    _scannedCodeNotifier.value = barcode;

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      if (widget.onScanned != null) {
        widget.onScanned!(barcode);
      }
      Navigator.pop(context, barcode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // 1. Camera View
            MobileScanner(
              controller: _scannerController,
              onDetect: _onDetect,
              errorBuilder: (context, error) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.videocam_off_rounded,
                          size: 48.r,
                          color: ColorPalette.white.withValues(alpha: 0.7),
                        ),
                        16.verticalSpace,
                        Text(
                          Strings.noCameraPermission,
                          style: FontPalette.base500(
                            14,
                            color: ColorPalette.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        20.verticalSpace,
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            Strings.cancel,
                            style: FontPalette.base600(
                              14,
                              color: ColorPalette.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // 2. Blur Overlay
            Positioned.fill(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                child: const SizedBox.expand(),
              ),
            ),

            // 3. Scan Border Corners & Dimmed Mask
            ValueListenableBuilder<String?>(
              valueListenable: _scannedCodeNotifier,
              builder: (context, scannedCode, _) {
                return BarcodeScanCorners(
                  cutOutWidth: scanAreaWidth,
                  cutOutHeight: scanAreaHeight,
                  borderRadius: scanBorderRadius,
                  borderWidth: scanBorderWidth,
                  isProductFound: scannedCode != null,
                  borderColor: scannedCode != null
                      ? ColorPalette.primaryColor
                      : ColorPalette.white,
                );
              },
            ),

            // 4. Animated Laser Scan Line
            ValueListenableBuilder<String?>(
              valueListenable: _scannedCodeNotifier,
              builder: (context, scannedCode, _) {
                return scannedCode == null
                    ? AnimatedScanLine(
                        isScanned: false,
                        animation: _animation,
                        cutOutWidth: scanAreaWidth,
                        cutOutHeight: scanAreaHeight,
                      )
                    : const SizedBox.shrink();
              },
            ),

            // 5. Top Controls Header
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: false,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Close button
                      _topIconButton(
                        onTap: () => Navigator.pop(context),
                        icon: Icons.close_rounded,
                      ),

                      // Title
                      Text(
                        widget.title ?? Strings.scanBarcode,
                        style: FontPalette.base600(
                          16,
                          color: ColorPalette.white,
                        ),
                      ),

                      // Actions: Torch & Camera Switch
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ValueListenableBuilder<MobileScannerState>(
                            valueListenable: _scannerController,
                            builder: (context, scannerState, _) {
                              final isTorchOn = scannerState.torchState == TorchState.on;
                              return _topIconButton(
                                onTap: () => _scannerController.toggleTorch(),
                                icon: isTorchOn
                                    ? Icons.flash_on_rounded
                                    : Icons.flash_off_rounded,
                                isActive: isTorchOn,
                              );
                            },
                          ),
                          8.horizontalSpace,
                          _topIconButton(
                            onTap: () => _scannerController.switchCamera(),
                            icon: Icons.flip_camera_ios_rounded,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topIconButton({
    required VoidCallback onTap,
    required IconData icon,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive
              ? ColorPalette.primaryColor.withValues(alpha: 0.6)
              : ColorPalette.white.withValues(alpha: 0.25),
        ),
        child: Icon(
          icon,
          size: 20.r,
          color: ColorPalette.white,
        ),
      ),
    );
  }
}
