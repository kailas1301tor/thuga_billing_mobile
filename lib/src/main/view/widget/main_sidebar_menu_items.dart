// lib/src/main/view/widget/main_sidebar_menu_items.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/thuga_logo.dart';
import 'package:thuga/utils/routes/route_constants.dart';

class MainSidebarMenuItem {
  const MainSidebarMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String route;
}

abstract final class MainSidebarMenuItems {
  static const List<MainSidebarMenuItem> secondaryItems = [
    MainSidebarMenuItem(
      icon: Icons.grid_view_rounded,
      title: 'Categories',
      subtitle: 'Manage product divisions',
      route: RouteConstants.routeCategories,
    ),
    MainSidebarMenuItem(
      icon: Icons.inventory_2_rounded,
      title: 'Products',
      subtitle: 'Stock lists & pricing',
      route: RouteConstants.routeProducts,
    ),
    MainSidebarMenuItem(
      icon: Icons.people_alt_rounded,
      title: 'Customers',
      subtitle: 'Store contacts directory',
      route: RouteConstants.routeCustomers,
    ),
    MainSidebarMenuItem(
      icon: Icons.calculate_rounded,
      title: Strings.calculationTitle,
      subtitle: Strings.calculationSubtitle,
      route: RouteConstants.routeCalculations,
    ),
    MainSidebarMenuItem(
      icon: Icons.shopping_bag_rounded,
      title: 'Purchases',
      subtitle: 'Stock procurement & bills',
      route: RouteConstants.routePurchases,
    ),
  ];

  static const List<({String label, IconData icon, String route})> primaryTabs =
      [
    (label: Strings.navHome, icon: Icons.home_outlined, route: RouteConstants.routeHome),
    (label: Strings.navBills, icon: Icons.receipt_long_outlined, route: RouteConstants.routeBills),
    (label: Strings.navReports, icon: Icons.bar_chart_outlined, route: RouteConstants.routeReports),
    (label: Strings.navSettings, icon: Icons.settings_outlined, route: RouteConstants.routeSettings),
  ];
}

class MainSidebarMenuTile extends StatelessWidget {
  const MainSidebarMenuTile({
    super.key,
    required this.item,
    this.compact = false,
    this.onTap,
  });

  final MainSidebarMenuItem item;
  final bool compact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.symmetric(
        horizontal: compact ? 12 : 16,
        vertical: compact ? 4 : 2,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(item.icon, color: colors.secondaryText, size: 22),
      title: compact
          ? null
          : Text(
              item.title,
              style: FontPalette.base600(14, color: colors.primaryText),
            ),
      subtitle: compact
          ? null
          : Text(
              item.subtitle,
              style: FontPalette.base400(11, color: colors.secondaryText),
            ),
      trailing: compact
          ? null
          : Icon(
              Icons.chevron_right_rounded,
              color: colors.secondaryText,
              size: 20,
            ),
      onTap: onTap ?? () => context.push(item.route),
      hoverColor: colors.inputBackground,
    );
  }
}

class MainSidebarHeader extends StatelessWidget {
  const MainSidebarHeader({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 12 : 24,
        vertical: compact ? 16 : 24,
      ),
      child: Row(
        children: [
          ThugaLogo(size: compact ? 40 : 48),
          if (!compact) ...[
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.appMenuTitle,
                    style: FontPalette.base700(16, color: colors.primaryText),
                  ),
                  Text(
                    Strings.appMenuSubtitle,
                    style: FontPalette.base400(11, color: colors.secondaryText),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
