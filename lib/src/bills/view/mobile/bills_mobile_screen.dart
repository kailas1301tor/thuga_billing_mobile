// lib/src/bills/view/bills_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/common_app_bar.dart';
import 'package:thuga/utils/common_widgets/common_refresh_indicator.dart';
import 'package:thuga/utils/common_widgets/common_scaffold.dart';
import 'package:thuga/utils/common_widgets/common_search_bar.dart';
import 'package:thuga/utils/common_widgets/common_switch_state.dart';

import '../../model/bill_model.dart';
import '../../notifier/bills_notifier.dart';
import '../bill_detail_screen.dart';
import '../widget/bill_item_card.dart';
import '../widget/bills_filter_row.dart';

class BillsMobileScreen extends ConsumerWidget {
  const BillsMobileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final loaderState = ref.watch(
      billsProvider.select((s) => s.loaderState),
    );
    final dateRangeFilter = ref.watch(
      billsProvider.select((s) => s.dateRangeFilter),
    );
    final totalCount = ref.watch(
      billsProvider.select((s) => s.data?.results.totalCount),
    );
    final isLoadingMore = ref.watch(
      billsProvider.select((s) => s.isLoadingMore),
    );
    final bills = ref.watch(
      billsProvider.select((s) {
        final list = List<BillModel>.from(s.data?.results.data ?? []);
        if (s.isNewestFirst) {
          list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        } else {
          list.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        }
        return list;
      }),
    );
    final notifier = ref.read(billsProvider.notifier);

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: const CommonAppBar(
        title: Strings.billsTitle,
        showBackButton: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: CommonSearchBar(
              controller: notifier.searchController,
              hintText: Strings.searchBillsHint,
              onClear: notifier.clearSearch,
            ),
          ),
          BillsFilterRow(
            selectedDate: dateRangeFilter,
            onDateChanged: notifier.setDateRangeFilter,
          ),
          Expanded(
            child: CommonSwitchState(
              loaderState: loaderState,
              reload: () => notifier.fetchBills(),
              child: _buildBody(
                context,
                colors,
                bills,
                totalCount ?? bills.length,
                isLoadingMore,
                notifier,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppColors colors,
    List<BillModel> bills,
    int billCount,
    bool isLoadingMore,
    BillsNotifier notifier,
  ) {
    return CommonRefreshIndicator(
      onRefresh: () => notifier.fetchBills(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              '$billCount Bills',
              style: FontPalette.base700(15, color: colors.primaryText),
            ),
          ),
          12.verticalSpace,
          Expanded(
            child: ListView.builder(
              controller: notifier.scrollController,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: bills.length + (isLoadingMore ? 1 : 0),
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == bills.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Center(
                      child: SizedBox(
                        width: 24.r,
                        height: 24.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.w,
                          color: colors.primary,
                        ),
                      ),
                    ),
                  );
                }
                final bill = bills[index];
                return BillItemCard(
                  bill: bill,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            BillDetailScreen(billId: bill.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
