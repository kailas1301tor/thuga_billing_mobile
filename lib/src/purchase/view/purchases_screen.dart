// lib/src/purchase/view/purchases_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_app_bar.dart';
import 'package:thuga/utils/common_widgets/common_container.dart';
import 'package:thuga/utils/common_widgets/common_refresh_indicator.dart';
import 'package:thuga/utils/common_widgets/common_scaffold.dart';
import 'package:thuga/utils/common_widgets/common_switch_state.dart';
import 'package:thuga/utils/common_widgets/web/responsive_list_grid.dart';
import 'package:thuga/utils/helpers/common_functions.dart';
import '../notifier/purchases_notifier.dart';
import 'widget/purchase_item_card.dart';
import 'create_purchase_screen.dart';

class PurchasesScreen extends ConsumerWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final state = ref.watch(purchasesProvider);
    final notifier = ref.read(purchasesProvider.notifier);

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: CommonAppBar(
        title: 'Purchases',
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_rounded, size: 24.r, color: colors.primaryText),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreatePurchaseScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Date Range Selector
          GestureDetector(
            onTap: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                initialDateRange: DateTimeRange(
                  start: state.startDate,
                  end: state.endDate,
                ),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                            primary: colors.primary,
                            onPrimary: Colors.white,
                            surface: colors.surface,
                            onSurface: colors.primaryText,
                          ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                notifier.setDateRange(picked.start, picked.end);
              }
            },
            child: CommonContainer(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              borderRadius: 16.r,
              border: Border.all(color: colors.inputBorder, width: 1.w),
              color: colors.surface,
              child: Row(
                children: [
                  Icon(
                    Icons.date_range_rounded,
                    color: colors.primary,
                    size: 20.r,
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Text(
                      '${formatDate(state.startDate, pattern: 'dd MMM yyyy')} - ${formatDate(state.endDate, pattern: 'dd MMM yyyy')}',
                      style: FontPalette.base600(14, color: colors.primaryText),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: colors.secondaryText,
                    size: 24.r,
                  ),
                ],
              ),
            ),
          ),
          
          // Purchases List
          Expanded(
            child: CommonSwitchState(
              loaderState: state.loaderState,
              reload: () => notifier.fetchPurchases(),
              child: CommonRefreshIndicator(
                onRefresh: () => notifier.fetchPurchases(),
                child: ResponsiveListGrid(
                  controller: notifier.scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.purchases.length,
                  minItemWidth: 300,
                  itemBuilder: (context, index) {
                    final purchase = state.purchases[index];
                    return PurchaseItemCard(purchase: purchase);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
