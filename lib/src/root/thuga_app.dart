// lib/src/root/thuga_app.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:toastification/toastification.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/app_theme.dart';
import 'package:thuga/res/styles/theme_provider.dart';
import 'package:thuga/utils/common_widgets/connectivity_observer.dart';
import 'package:thuga/utils/common_widgets/thuga_logo.dart';
import 'package:thuga/utils/common_widgets/web_screen_util_host.dart';
import 'package:thuga/utils/routes/app_router.dart';

class ThugaApp extends ConsumerWidget {
  const ThugaApp({super.key});

  Widget _buildApp(ThemeMode themeMode) {
    return ToastificationWrapper(
      child: ConnectivityObserver(
        child: MaterialApp.router(
          title: Strings.appName,
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: MediaQuery.withClampedTextScaling(
              minScaleFactor: 1,
              maxScaleFactor: 1,
              child: child ?? const SizedBox(),
            ),
            breakpoints: const [
              Breakpoint(start: 0, end: 599, name: MOBILE),
              Breakpoint(start: 600, end: 1023, name: TABLET),
              Breakpoint(start: 1024, end: double.infinity, name: DESKTOP),
            ],
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en')],
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final themeMode = themeAsync.value ?? ThemeMode.system;
    final app = _buildApp(themeMode);

    if (kIsWeb) {
      return WebScreenUtilHost(
        child: ThugaLogoPrecacheHost(child: app),
      );
    }

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => app,
    );
  }
}
