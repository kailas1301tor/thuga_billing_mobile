// lib/src/splash/view/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_loader.dart';
import 'package:vyapapp/utils/common_widgets/common_scaffold.dart';

import '../notifier/splash_notifier.dart';
import '../state/splash_state.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(splashNotifierProvider.notifier).initialize(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final status = ref.watch(
      splashNotifierProvider.select((state) => state.status),
    );

    return CommonScaffold(
      backgroundColor: colors.background,
      enableFadeIn: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.appName,
              style: FontPalette.base700(34, color: colors.primary),
            ),
            if (status == SplashStatus.checking) ...[
              24.verticalSpace,
              const CommonLoader(),
            ],
          ],
        ),
      ),
    );
  }
}
