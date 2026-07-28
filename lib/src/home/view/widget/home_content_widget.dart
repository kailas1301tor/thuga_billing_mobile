// lib/src/home/view/widget/home_content_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/src/home/model/home_dashboard_model.dart';

import 'home_greeting_row_widget.dart';
import 'home_header_widget.dart';
import 'home_recent_bills_widget.dart';
import 'home_stats_row_widget.dart';
import 'home_today_sales_card_widget.dart';
import 'home_top_products_widget.dart';

class HomeContentWidget extends StatelessWidget {
  const HomeContentWidget({super.key, this.data, required this.greetingPrefix});

  final HomeDashboardModel? data;
  final String greetingPrefix;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeHeaderWidget(notificationCount: data?.notificationCount ?? 0),
          HomeGreetingRowWidget(
            greetingPrefix: greetingPrefix,
            shopName: data?.shopName ?? '',
          ),
          HomeTodaySalesCardWidget(
            todaySales: data?.todaySales ?? 0,
            salesChangePercent: data?.salesChangePercent ?? 0,
          ),
          HomeStatsRowWidget(
            billCount: data?.billCount ?? 0,
            billCountDelta: data?.billCountDelta ?? 0,
            avgBillValue: data?.avgBillValue ?? 0,
            avgBillChangePercent: data?.avgBillChangePercent ?? 0,
            bestSellerName: data?.bestSellerName ?? '',
            bestSellerQty: data?.bestSellerQty ?? 0,
          ),
          HomeTopProductsWidget(products: data?.topProducts ?? []),
          HomeRecentBillsWidget(bills: data?.recentBills ?? []),
          100.verticalSpace,
        ],
      ),
    );
  }
}
