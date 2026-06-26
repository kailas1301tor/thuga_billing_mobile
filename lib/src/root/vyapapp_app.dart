// lib/src/root/vyapapp_app.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/app_theme.dart';
import 'package:vyapapp/res/styles/theme_provider.dart';
import 'package:vyapapp/utils/common_widgets/connectivity_observer.dart';
import 'package:vyapapp/utils/routes/app_navigator.dart';
import 'package:vyapapp/utils/routes/route_constants.dart';
import 'package:vyapapp/utils/routes/route_generator.dart';

class VyapApp extends ConsumerWidget {
  const VyapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final themeMode = themeAsync.valueOrNull ?? ThemeMode.system;

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => ToastificationWrapper(
        child: ConnectivityObserver(
          child: MaterialApp(
            title: Strings.appName,
            debugShowCheckedModeBanner: false,
            navigatorKey: appNavigatorKey,
            builder: (_, child) => MediaQuery.withClampedTextScaling(
              minScaleFactor: 1,
              maxScaleFactor: 1,
              child: child ?? const SizedBox(),
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en')],
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: RouteConstants.routeSplash,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
          ),
        ),
      ),
    );
  }
}
