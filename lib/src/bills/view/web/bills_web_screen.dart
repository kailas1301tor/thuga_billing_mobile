// lib/src/bills/view/web/bills_web_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/utils/common_widgets/common_loader.dart';
import 'package:thuga/utils/common_widgets/common_refresh_indicator.dart';
import 'package:thuga/utils/common_widgets/common_search_bar.dart';
import 'package:thuga/utils/common_widgets/common_switch_state.dart';
import 'package:thuga/utils/helpers/web_breakpoints.dart';
import 'package:thuga/utils/helpers/web_responsive.dart';

import '../../model/bill_model.dart';
import '../../notifier/bills_notifier.dart';
import '../bill_detail_screen.dart';
import '../widget/bill_item_card.dart';
import '../widget/bills_filter_row.dart';

class BillsWebScreen extends ConsumerWidget {
  const BillsWebScreen({super.key});

  List<BillModel> _sortedBills(List<BillModel> raw, bool isNewestFirst) {
    final bills = List<BillModel>.from(raw);
    if (isNewestFirst) {
      bills.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else {
      bills.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }
    return bills;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final pagePadding = webPagePadding(context);
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
    final rawBills = ref.watch(
      billsProvider.select((s) => s.data?.results.data ?? const <BillModel>[]),
    );
    final isNewestFirst = ref.watch(
      billsProvider.select((s) => s.isNewestFirst),
    );
    final bills = _sortedBills(rawBills, isNewestFirst);
    final notifier = ref.read(billsProvider.notifier);

    return ColoredBox(
      color: colors.background,
      child: Align(
        alignment: Alignment.topLeft,
        child: MaxWidthBox(
          maxWidth: WebBreakpoints.maxContentWidth,
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  pagePadding,
                  WebSpacing.lg,
                  pagePadding,
                  WebSpacing.md,
                ),
                child: Text(
                  Strings.billsTitle,
                  style: FontPalette.base700(24, color: colors.primaryText),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: pagePadding),
                child: CommonSearchBar(
                  controller: notifier.searchController,
                  hintText: Strings.searchBillsHint,
                  onClear: notifier.clearSearch,
                ),
              ),
              const SizedBox(height: WebSpacing.sm),
              BillsFilterRow(
                selectedDate: dateRangeFilter,
                onDateChanged: notifier.setDateRangeFilter,
                horizontalPadding: pagePadding,
              ),
              const SizedBox(height: WebSpacing.sm),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: pagePadding),
                child: Text(
                  '${totalCount ?? bills.length} ${Strings.billsTitle}',
                  style: FontPalette.base700(15, color: colors.primaryText),
                ),
              ),
              const SizedBox(height: WebSpacing.sm),
              Expanded(
                child: CommonSwitchState(
                  loaderState: loaderState,
                  reload: () => notifier.fetchBills(),
                  child: CommonRefreshIndicator(
                    onRefresh: () => notifier.fetchBills(),
                    child: ListView.builder(
                      controller: notifier.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(
                        pagePadding,
                        0,
                        pagePadding,
                        WebSpacing.xxl,
                      ),
                      itemCount: bills.length + (isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == bills.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: WebSpacing.md,
                            ),
                            child: Center(
                              child: CommonLoader(size: 24, strokeWidth: 2),
                            ),
                          );
                        }

                        final bill = bills[index];
                        return BillItemCard(
                          bill: bill,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) =>
                                    BillDetailScreen(billId: bill.id),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
