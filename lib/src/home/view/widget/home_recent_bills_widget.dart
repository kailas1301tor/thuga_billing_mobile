// lib/src/home/view/widget/home_recent_bills_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/src/home/model/home_recent_bill_model.dart';
import 'package:vyapapp/src/main/notifier/dropdowns_notifier.dart';
import 'package:vyapapp/src/main/model/dropdown_model.dart';
import 'package:vyapapp/utils/common_widgets/common_container.dart';
import 'package:vyapapp/utils/common_widgets/common_section_header.dart';
import 'package:vyapapp/utils/helpers/extensions.dart';

class HomeRecentBillsWidget extends StatelessWidget {
  const HomeRecentBillsWidget({super.key, required this.bills});

  final List<HomeRecentBillModel> bills;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
      child: Column(
        children: [
          CommonSectionHeader(title: Strings.recentBills),
          10.verticalSpace,
          Column(
            children: [
              for (final b in bills) ...[_BillRow(bill: b), 10.verticalSpace],
            ],
          ),
        ],
      ),
    );
  }
}

class _BillRow extends ConsumerWidget {
  const _BillRow({required this.bill});

  final HomeRecentBillModel bill;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;

    final customers = ref.watch(
      dropdownsNotifierProvider.select((s) => s.data.customers),
    );
    final customerLabel = bill.customerId != null
        ? customers
              .firstWhere(
                (c) => c.id == bill.customerId,
                orElse: () => DropdownCustomerModel(
                  id: bill.customerId!,
                  name: bill.customerLabel,
                ),
              )
              .name
        : Strings.walkInCustomer;

    return CommonContainer(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      borderRadius: 16.r,
      border: Border.all(color: colors.inputBorder, width: 1.h),
      boxShadow: const [],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonContainer(
            width: 48.r,
            height: 48.r,
            padding: EdgeInsets.zero,
            borderRadius: 12.r,
            color: ColorPalette.homeStatGreenBg,
            boxShadow: const [],
            child: Center(
              child: Icon(
                Icons.receipt_long_outlined,
                size: 22.r,
                color: colors.primary,
              ),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bill.billNumber,
                  style: FontPalette.base700(15, color: colors.primaryText),
                ),
                4.verticalSpace,
                Text(
                  bill.timeLabel,
                  style: FontPalette.base400(12, color: colors.secondaryText),
                ),
                4.verticalSpace,
                Text(
                  customerLabel,
                  style: FontPalette.base500(12, color: colors.primaryText),
                ),
                4.verticalSpace,
                Row(
                  children: [
                    Text(
                      bill.paymentMethod.isNotEmpty
                          ? bill.paymentMethod
                          : 'N/A',
                      style: FontPalette.base400(
                        11,
                        color: colors.secondaryText,
                      ),
                    ),
                    if (bill.paymentStatus.isNotEmpty) ...[
                      6.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: bill.isPaid
                              ? ColorPalette.homeStatGreenBg
                              : colors.errorText.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          bill.paymentStatus,
                          style: FontPalette.base700(
                            9,
                            color: bill.isPaid
                                ? colors.primary
                                : colors.errorText,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          8.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                bill.amount.toCurrency(),
                style: FontPalette.base700(15, color: colors.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
