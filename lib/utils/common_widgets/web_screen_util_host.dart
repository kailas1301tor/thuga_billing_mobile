// lib/utils/common_widgets/web_screen_util_host.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Keeps [ScreenUtil] available on web with a 1:1 scale so shared widgets
/// (FontPalette, CommonTextFormField, etc.) use logical pixels instead of
/// mobile design scaling.
class WebScreenUtilHost extends StatefulWidget {
  const WebScreenUtilHost({super.key, required this.child});

  final Widget child;

  @override
  State<WebScreenUtilHost> createState() => _WebScreenUtilHostState();
}

class _WebScreenUtilHostState extends State<WebScreenUtilHost>
    with WidgetsBindingObserver {
  late Size _designSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _designSize = _readLogicalSize();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final nextSize = _readLogicalSize();
    if (nextSize != _designSize) {
      setState(() => _designSize = nextSize);
    }
  }

  Size _readLogicalSize() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final logical = view.physicalSize / view.devicePixelRatio;
    if (logical.width <= 0 || logical.height <= 0) {
      return const Size(1280, 800);
    }
    return logical;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _designSize,
      minTextAdapt: true,
      builder: (context, child) => widget.child,
    );
  }
}
