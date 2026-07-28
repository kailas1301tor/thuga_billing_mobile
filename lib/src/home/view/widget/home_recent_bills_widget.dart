// lib/src/home/view/widget/home_recent_bills_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/src/bills/model/bill_model.dart';
import 'package:thuga/src/bills/view/bill_detail_screen.dart';
import 'package:thuga/src/bills/view/widget/bill_summary_card.dart';
import 'package:thuga/utils/common_widgets/common_section_header.dart';

import 'home_section_empty_text.dart';

class HomeRecentBillsWidget extends StatelessWidget {
  const HomeRecentBillsWidget({super.key, required this.bills});

  final List<BillModel> bills;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
      child: Column(
        children: [
          CommonSectionHeader(title: Strings.recentBills),
          10.verticalSpace,
          if (bills.isEmpty)
            const HomeSectionEmptyText(message: Strings.noRecentBills)
          else
            Column(
              children: [
                for (final bill in bills) ...[
                  BillSummaryCard(
                    bill: bill,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BillDetailScreen(billId: bill.id),
                        ),
                      );
                    },
                  ),
                  10.verticalSpace,
                ],
              ],
            ),
        ],
      ),
    );
  }
}
