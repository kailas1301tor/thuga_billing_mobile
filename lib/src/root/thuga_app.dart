// lib/src/root/thuga_app.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/app_theme.dart';
import 'package:thuga/res/styles/theme_provider.dart';
import 'package:thuga/utils/common_widgets/connectivity_observer.dart';
import 'package:thuga/utils/routes/app_navigator.dart';
import 'package:thuga/utils/routes/route_constants.dart';
import 'package:thuga/utils/routes/route_generator.dart';

class ThugaApp extends ConsumerWidget {
  const ThugaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final themeMode = themeAsync.value ?? ThemeMode.system;

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => ToastificationWrapper(
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
