// lib/src/main/view/main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/src/bills/view/bills_screen.dart';
import 'package:vyapapp/src/home/view/home_screen.dart';
import 'package:vyapapp/src/new_bill/view/new_bill_screen.dart';
import 'package:vyapapp/src/reports/view/reports_screen.dart';
import 'package:vyapapp/src/settings/view/settings_screen.dart';
import 'package:vyapapp/utils/common_widgets/custom_toast.dart';

import '../../../utils/common_widgets/common_scaffold.dart';
import '../notifier/selected_tab_notifier.dart';
import '../notifier/dropdowns_notifier.dart';
import 'widget/vyap_bottom_nav_bar.dart';
import 'widget/main_sidebar_drawer.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  DateTime? _lastBackPressTime;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(dropdownsNotifierProvider.notifier).fetchDropdowns();
    });
  }

  void _showExitToast() {
    showCustomToast(message: Strings.exitPressAgain, isSuccess: false);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final selectedTab = ref.watch(
      selectedTabNotifierProvider.select((index) => index),
    );

    const pages = [
      HomeScreen(),
      BillsScreen(),
      ReportsScreen(),
      SettingsScreen(),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (selectedTab != 0) {
          ref.read(selectedTabNotifierProvider.notifier).setTab(0);
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
        body: IndexedStack(index: selectedTab, children: pages),
        drawer: const MainSidebarDrawer(),
        bottomNavigationBar: VyapBottomNavBar(
          selectedTab: selectedTab,
          onTabSelected: (index) =>
              ref.read(selectedTabNotifierProvider.notifier).setTab(index),
          onNewBillPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewBillScreen()),
            );
          },
        ),
      ),
    );
  }
}
