// lib/utils/common_widgets/web/web_app_shell.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/src/main/view/widget/main_sidebar_menu_items.dart';
import 'package:thuga/utils/helpers/web_breakpoints.dart';

/// Responsive web app shell — drawer / rail / sidebar by breakpoint.
class WebAppShell extends StatelessWidget {
  const WebAppShell({
    super.key,
    required this.navigationShell,
    required this.onNewBill,
  });

  final StatefulNavigationShell navigationShell;
  final VoidCallback onNewBill;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    final body = navigationShell;

    if (isMobile) {
      return Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          title: Text(
            _titleForIndex(navigationShell.currentIndex),
            style: FontPalette.base700(18, color: colors.primaryText),
          ),
          backgroundColor: colors.surface,
          foregroundColor: colors.primaryText,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: onNewBill,
              icon: Icon(Icons.add_circle_outline, color: colors.primary),
              tooltip: Strings.navNewBill,
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: colors.surface,
          child: _SidebarContent(
            navigationShell: navigationShell,
            expanded: true,
            onNewBill: onNewBill,
          ),
        ),
        body: body,
        bottomNavigationBar: _WebBottomNav(
          currentIndex: navigationShell.currentIndex,
          onTap: (index) => _goBranch(navigationShell, index),
        ),
      );
    }

    if (isTablet) {
      return Scaffold(
        backgroundColor: colors.background,
        body: Row(
          children: [
            NavigationRail(
              backgroundColor: colors.surface,
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) =>
                  _goBranch(navigationShell, index),
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.only(top: WebSpacing.md),
                child: FloatingActionButton.small(
                  onPressed: onNewBill,
                  backgroundColor: colors.primary,
                  foregroundColor: ColorPalette.white,
                  child: const Icon(Icons.add),
                ),
              ),
              destinations: [
                for (final tab in MainSidebarMenuItems.primaryTabs)
                  NavigationRailDestination(
                    icon: Icon(tab.icon),
                    label: Text(tab.label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: body),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: colors.background,
      body: Row(
        children: [
          SizedBox(
            width: WebBreakpoints.sidebarWidth,
            child: Material(
              color: colors.surface,
              child: _SidebarContent(
                navigationShell: navigationShell,
                expanded: true,
                onNewBill: onNewBill,
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(child: body),
        ],
      ),
    );
  }

  static void _goBranch(StatefulNavigationShell shell, int index) {
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  static String _titleForIndex(int index) {
    return switch (index) {
      0 => Strings.navHome,
      1 => Strings.navBills,
      2 => Strings.navReports,
      3 => Strings.navSettings,
      _ => Strings.appName,
    };
  }
}

class _SidebarContent extends StatelessWidget {
  const _SidebarContent({
    required this.navigationShell,
    required this.expanded,
    required this.onNewBill,
  });

  final StatefulNavigationShell navigationShell;
  final bool expanded;
  final VoidCallback onNewBill;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: WebSpacing.md),
        children: [
          MainSidebarHeader(compact: !expanded),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(WebSpacing.md),
            child: FilledButton.icon(
              onPressed: onNewBill,
              icon: const Icon(Icons.add, size: 20),
              label: Text(Strings.navNewBill),
              style: FilledButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: ColorPalette.white,
                padding: const EdgeInsets.symmetric(vertical: WebSpacing.sm),
              ),
            ),
          ),
          ...MainSidebarMenuItems.primaryTabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            final selected = navigationShell.currentIndex == index;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: WebSpacing.sm),
              child: ListTile(
                selected: selected,
                selectedTileColor: colors.primary.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(
                  tab.icon,
                  color: selected ? colors.primary : colors.secondaryText,
                ),
                title: expanded
                    ? Text(
                        tab.label,
                        style: FontPalette.base600(
                          14,
                          color: selected
                              ? colors.primary
                              : colors.primaryText,
                        ),
                      )
                    : null,
                onTap: () => WebAppShell._goBranch(navigationShell, index),
                hoverColor: colors.inputBackground,
              ),
            );
          }),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              WebSpacing.lg,
              WebSpacing.md,
              WebSpacing.lg,
              WebSpacing.xs,
            ),
            child: Text(
              Strings.manageSectionTitle,
              style: FontPalette.base600(11, color: colors.secondaryText),
            ),
          ),
          for (final item in MainSidebarMenuItems.secondaryItems)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: WebSpacing.sm),
              child: MainSidebarMenuTile(
                item: item,
                compact: !expanded,
                onTap: () {
                  final scaffold = Scaffold.maybeOf(context);
                  if (scaffold?.isDrawerOpen ?? false) {
                    Navigator.of(context).pop();
                  }
                  context.push(item.route);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _WebBottomNav extends StatelessWidget {
  const _WebBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: colors.surface,
      indicatorColor: colors.primary.withValues(alpha: 0.15),
      destinations: [
        for (final tab in MainSidebarMenuItems.primaryTabs)
          NavigationDestination(
            icon: Icon(tab.icon),
            label: tab.label,
          ),
      ],
    );
  }
}
