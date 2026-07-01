// lib/src/reports/view/widget/reports_content_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import 'package:vyapapp/utils/common_widgets/common_cached_network_image.dart';
import '../../notifier/reports_notifier.dart';
import '../../model/reports_model.dart';
import 'reports_metrics_grid.dart';
import 'reports_payment_share.dart';
import 'reports_sales_chart.dart';

class ReportsContentWidget extends ConsumerWidget {
  const ReportsContentWidget({super.key, this.data});

  final ReportsDataModel? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final selectedRange = ref.watch(
      reportsNotifierProvider.select((s) => s.selectedRange),
    );
    final notifier = ref.read(reportsNotifierProvider.notifier);

    final ranges = ['Today', 'Yesterday', 'Last 7 Days', 'This Month'];

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Date Range Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ranges.map((range) {
                final isSelected = selectedRange == range;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: ChoiceChip(
                    label: Text(range),
                    selected: isSelected,
                    onSelected: (_) => notifier.setRange(range),
                    selectedColor: colors.primary,
                    checkmarkColor: Colors.white,
                    showCheckmark: false,
                    backgroundColor: colors.inputBackground,
                    labelStyle: FontPalette.base700(
                      12,
                      color: isSelected ? Colors.white : colors.primaryText,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: BorderSide(
                        color: isSelected ? colors.primary : colors.inputBorder,
                        width: 1.w,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          16.verticalSpace,

          // 2. Metrics Summary Grid
          ReportsMetricsGrid(summary: data?.summary),
          16.verticalSpace,

          // 3. Sales Volume Custom Chart
          ReportsSalesChart(chartData: data?.chartData),
          16.verticalSpace,

          // 4. Payment Mode Distribution
          ReportsPaymentShare(shares: data?.paymentShares),
          16.verticalSpace,

          // 5. Top-Selling Products List
          _buildTopProductsCard(context, data?.topProducts),
          20.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildTopProductsCard(
    BuildContext context,
    List<ProductSaleModel> ?products,
  ) {
    final colors = context.appColors;

    return CommonContainer(
      padding: EdgeInsets.all(16.r),
      borderRadius: 20.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Selling Products',
            style: FontPalette.base700(14, color: colors.primaryText),
          ),
          16.verticalSpace,
          if ((products??[]).isEmpty)
            Center(
              child: Text(
                'No product sales recorded',
                style: FontPalette.base400(13, color: colors.secondaryText),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: (products??[]).length,
              separatorBuilder: (context, index) => 12.verticalSpace,
              itemBuilder: (context, index) {
                final prod = (products??[])[index];

                return Row(
                  children: [
                    // Emoji / Avatar Image
                    Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: BoxDecoration(
                        color: colors.inputBackground,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: (prod.image != null && prod.image!.isNotEmpty)
                          ? CommonCachedNetworkImage(
                              imageUrl: prod.image ?? "",
                              width: 36.r,
                              height: 36.r,
                              memCacheWidth: 80,
                              memCacheHeight: 80,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text(
                                prod.emoji,
                                style: TextStyle(fontSize: 18.sp),
                              ),
                            ),
                    ),
                    12.horizontalSpace,

                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prod.name,
                                style: FontPalette.base600(
                                  13,
                                  color: colors.primaryText,
                                ),
                              ),
                              Text(
                                '₹${prod.revenue.toStringAsFixed(0)}',
                                style: FontPalette.base700(
                                  13,
                                  color: colors.primaryText,
                                ),
                              ),
                            ],
                          ),
                          4.verticalSpace,
                          Text(
                            '${prod.quantity} sold',
                            style: FontPalette.base400(
                              11,
                              color: colors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
