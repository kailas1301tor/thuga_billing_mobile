// lib/src/home/view/web/home_web_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/utils/common_widgets/common_switch_state.dart';
import 'package:thuga/utils/common_widgets/web/web_grid.dart';
import 'package:thuga/utils/common_widgets/web/web_page_layout.dart';
import 'package:thuga/utils/helpers/amount_formatter.dart';
import 'package:thuga/utils/routes/route_constants.dart';

import '../../model/home_dashboard_model.dart';
import '../../notifier/home_notifier.dart';
import 'widget/home_web_recent_bills_panel.dart';
import 'widget/home_web_section_card.dart';
import 'widget/home_web_stat_card.dart';
import 'widget/home_web_top_products_panel.dart';

class HomeWebScreen extends ConsumerStatefulWidget {
  const HomeWebScreen({super.key});

  @override
  ConsumerState<HomeWebScreen> createState() => _HomeWebScreenState();
}

class _HomeWebScreenState extends ConsumerState<HomeWebScreen> {
  static const int _maxRecentBills = 8;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).fetchDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loaderState = ref.watch(
      homeProvider.select((s) => s.loaderState),
    );
    final data = ref.watch(homeProvider.select((s) => s.data));
    final greetingPrefix = ref.watch(
      homeProvider.select((s) => s.greetingPrefix ?? ''),
    );
    final colors = context.appColors;

    return CommonSwitchState(
      loaderState: loaderState,
      reload: () => ref.read(homeProvider.notifier).fetchDashboard(),
      child: WebPageLayout(
        title: Strings.homeTitle,
        onRefresh: () => ref.read(homeProvider.notifier).fetchDashboard(),
        actions: [
          FilledButton.icon(
            onPressed: () => context.push(RouteConstants.routeNewBill),
            icon: const Icon(Icons.add, size: 18),
            label: Text(Strings.navNewBill),
            style: FilledButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: ColorPalette.white,
              padding: const EdgeInsets.symmetric(
                horizontal: WebSpacing.md,
                vertical: WebSpacing.sm,
              ),
            ),
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _greetingLine(greetingPrefix, data),
              style: FontPalette.base400(16, color: colors.secondaryText),
            ),
            const SizedBox(height: WebSpacing.xl),
            _buildStatsGrid(context, data, colors),
            const SizedBox(height: WebSpacing.xl),
            _buildDashboardPanels(context, data),
          ],
        ),
      ),
    );
  }

  String _greetingLine(String greetingPrefix, HomeDashboardModel? data) {
    final shop = data?.shopName;
    if (shop != null && shop.isNotEmpty) {
      return '$greetingPrefix, $shop';
    }
    return greetingPrefix;
  }

  Widget _buildStatsGrid(
    BuildContext context,
    HomeDashboardModel? data,
    AppColors colors,
  ) {
    return WebGrid(
      mobileColumns: 1,
      tabletColumns: 2,
      desktopColumns: 4,
      children: [
        HomeWebStatCard(
          label: Strings.todaysSales,
          value: formatDisplayCurrency(data?.todaySales ?? 0),
          subtitle: formatDisplayPercent(data?.salesChangePercent ?? 0),
          icon: Icons.payments_outlined,
          accentColor: colors.primary,
          trendIsPositive: (data?.salesChangePercent ?? 0) >= 0,
        ),
        HomeWebStatCard(
          label: Strings.bills,
          value: '${data?.billCount ?? 0}',
          subtitle: '+${data?.billCountDelta ?? 0}',
          icon: Icons.receipt_long_outlined,
          trendIsPositive: (data?.billCountDelta ?? 0) >= 0,
        ),
        HomeWebStatCard(
          label: Strings.avgBillValue,
          value: formatDisplayCurrency(data?.avgBillValue ?? 0),
          subtitle: formatDisplayPercent(data?.avgBillChangePercent ?? 0),
          icon: Icons.analytics_outlined,
          trendIsPositive: (data?.avgBillChangePercent ?? 0) >= 0,
        ),
        HomeWebStatCard(
          label: Strings.bestSeller,
          value: data?.bestSellerName ?? '—',
          subtitle: '${data?.bestSellerQty ?? 0} ${Strings.sold.toLowerCase()}',
          icon: Icons.star_outline_rounded,
        ),
      ],
    );
  }

  Widget _buildDashboardPanels(BuildContext context, HomeDashboardModel? data) {
    final recentBills = (data?.recentBills ?? []).take(_maxRecentBills).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HomeWebSectionCard(
          title: Strings.topProductsToday,
          child: HomeWebTopProductsPanel(products: data?.topProducts ?? []),
        ),
        const SizedBox(height: WebSpacing.lg),
        HomeWebSectionCard(
          title: Strings.recentBills,
          action: TextButton(
            onPressed: () => context.push(RouteConstants.routeBills),
            child: Text(
              Strings.viewAll,
              style: FontPalette.base600(13, color: context.appColors.primary),
            ),
          ),
          child: HomeWebRecentBillsPanel(bills: recentBills),
        ),
      ],
    );
  }
}
