// lib/src/bills/view/bills_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_app_bar.dart';
import 'package:vyapapp/utils/common_widgets/common_refresh_indicator.dart';
import 'package:vyapapp/utils/common_widgets/common_scaffold.dart';
import 'package:vyapapp/utils/common_widgets/common_search_bar.dart';
import 'package:vyapapp/utils/common_widgets/common_switch_state.dart';

import '../notifier/bills_notifier.dart';
import 'widget/bill_item_card.dart';
import 'widget/bills_filter_row.dart';

class BillsScreen extends ConsumerStatefulWidget {
  const BillsScreen({super.key});

  @override
  ConsumerState<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends ConsumerState<BillsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch dashboard/bills list on screen initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(billsNotifierProvider.notifier).fetchBills();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final state = ref.watch(billsNotifierProvider);
    final notifier = ref.read(billsNotifierProvider.notifier);

    // Watch filtered list of bills
    final filteredBills = ref.watch(
      billsNotifierProvider.select((_) => notifier.getFilteredBills()),
    );

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: const CommonAppBar(
        title: Strings.billsTitle,
        showBackButton: false,
      ),
      body: CommonSwitchState(
        loaderState: state.loaderState,
        reload: () => notifier.fetchBills(),
        child: CommonRefreshIndicator(
          onRefresh: () => notifier.fetchBills(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Search Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: CommonSearchBar(
                  controller: notifier.searchController,
                  hintText: 'Search by Bill No, Customer or Amount',
                ),
              ),

              // 2. Filter Row
              BillsFilterRow(
                selectedDate: state.dateRangeFilter,
                selectedStatus: state.statusFilter,
                selectedPayment: state.paymentFilter,
                onDateChanged: (val) => notifier.setDateRangeFilter(val),
                onStatusChanged: (val) => notifier.setStatusFilter(val),
                onPaymentChanged: (val) => notifier.setPaymentFilter(val),
                onClearPressed: () => notifier.clearFilters(),
              ),
              20.verticalSpace,

              // 3. Bills Count Row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  '${filteredBills.length} Bills',
                  style: FontPalette.base700(15, color: colors.primaryText),
                ),
              ),
              12.verticalSpace,

              // 5. Scrollable Bills List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: filteredBills.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final bill = filteredBills[index];
                    return BillItemCard(
                      bill: bill,
                      onTap: () {
                        // View details placeholder
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
