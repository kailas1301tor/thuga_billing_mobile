// lib/src/main/view/mobile/main_mobile_shell.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/src/main/notifier/selected_tab_notifier.dart';
import 'package:thuga/src/main/view/widget/main_sidebar_drawer.dart';
import 'package:thuga/src/main/view/widget/thuga_bottom_nav_bar.dart';
import 'package:thuga/utils/common_widgets/common_scaffold.dart';
import 'package:thuga/utils/common_widgets/custom_toast.dart';
import 'package:thuga/utils/routes/route_constants.dart';

class MainMobileShell extends ConsumerStatefulWidget {
  const MainMobileShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<MainMobileShell> createState() => _MainMobileShellState();
}

class _MainMobileShellState extends ConsumerState<MainMobileShell> {
  DateTime? _lastBackPressTime;

  void _showExitToast() {
    showCustomToast(message: Strings.exitPressAgain, isSuccess: false);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final selectedTab = widget.navigationShell.currentIndex;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (selectedTab != 0) {
          widget.navigationShell.goBranch(0);
          ref.read(selectedTabProvider.notifier).setTab(0);
          return;
        }

        final now = DateTime.now();
        const doubleTapDuration = Duration(seconds: 2);

        if (_lastBackPressTime == null ||
            now.difference(_lastBackPressTime!) > doubleTapDuration) {
          _lastBackPressTime = now;
          _showExitToast();
          return;
        }

        SystemNavigator.pop();
      },
      child: CommonScaffold(
        backgroundColor: colors.background,
        body: widget.navigationShell,
        drawer: const MainSidebarDrawer(),
        bottomNavigationBar: ThugaBottomNavBar(
          selectedTab: selectedTab,
          onTabSelected: (index) {
            ref.read(selectedTabProvider.notifier).setTab(index);
            widget.navigationShell.goBranch(
              index,
              initialLocation: index == selectedTab,
            );
          },
          onNewBillPressed: () => context.push(RouteConstants.routeNewBill),
        ),
      ),
    );
  }
}
