// lib/utils/routes/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:thuga/src/auth/view/login_screen.dart';
import 'package:thuga/src/auth/view/register_screen.dart';
import 'package:thuga/src/bills/view/bills_screen.dart';
import 'package:thuga/src/calculation/view/calculation_screen.dart';
import 'package:thuga/src/categories/view/category_crud_screen.dart';
import 'package:thuga/src/customers/view/customer_crud_screen.dart';
import 'package:thuga/src/home/view/home_screen.dart';
import 'package:thuga/src/main/view/main_screen.dart';
import 'package:thuga/src/new_bill/view/new_bill_screen.dart';
import 'package:thuga/src/products/view/product_crud_screen.dart';
import 'package:thuga/src/purchase/view/purchases_screen.dart';
import 'package:thuga/src/reports/view/reports_screen.dart';
import 'package:thuga/src/settings/view/settings_screen.dart';
import 'package:thuga/src/splash/view/splash_screen.dart';
import 'package:thuga/utils/routes/app_navigator.dart';
import 'package:thuga/utils/routes/route_constants.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: appNavigatorKey,
  initialLocation: RouteConstants.routeSplash,
  redirect: (context, state) {
    if (state.uri.path == RouteConstants.routeInitial) {
      return RouteConstants.routeSplash;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: RouteConstants.routeSplash,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteConstants.routeLoginScreen,
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteConstants.routeRegisterScreen,
      builder: (_, __) => const RegisterScreen(),
    ),
    GoRoute(
      path: RouteConstants.routeNewBill,
      parentNavigatorKey: appNavigatorKey,
      builder: (_, __) => const NewBillScreen(),
    ),
    GoRoute(
      path: RouteConstants.routeCategories,
      parentNavigatorKey: appNavigatorKey,
      builder: (_, __) => const CategoryCrudScreen(),
    ),
    GoRoute(
      path: RouteConstants.routeProducts,
      parentNavigatorKey: appNavigatorKey,
      builder: (_, __) => const ProductCrudScreen(),
    ),
    GoRoute(
      path: RouteConstants.routeCustomers,
      parentNavigatorKey: appNavigatorKey,
      builder: (_, __) => const CustomerCrudScreen(),
    ),
    GoRoute(
      path: RouteConstants.routePurchases,
      parentNavigatorKey: appNavigatorKey,
      builder: (_, __) => const PurchasesScreen(),
    ),
    GoRoute(
      path: RouteConstants.routeCalculations,
      parentNavigatorKey: appNavigatorKey,
      builder: (_, __) => const CalculationScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteConstants.routeHome,
              pageBuilder: (_, __) => const NoTransitionPage(
                child: HomeScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteConstants.routeBills,
              pageBuilder: (_, __) => const NoTransitionPage(
                child: BillsScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteConstants.routeReports,
              pageBuilder: (_, __) => const NoTransitionPage(
                child: ReportsScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteConstants.routeSettings,
              pageBuilder: (_, __) => const NoTransitionPage(
                child: SettingsScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
