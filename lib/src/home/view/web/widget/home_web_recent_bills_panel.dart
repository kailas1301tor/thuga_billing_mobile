// lib/src/home/view/web/widget/home_web_recent_bills_panel.dart
import 'package:flutter/material.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/src/bills/model/bill_model.dart';
import 'package:thuga/src/bills/view/bill_detail_screen.dart';
import 'package:thuga/utils/common_widgets/web/web_grid.dart';
import 'package:thuga/utils/helpers/amount_formatter.dart';

class HomeWebRecentBillsPanel extends StatelessWidget {
  const HomeWebRecentBillsPanel({super.key, required this.bills});

  final List<BillModel> bills;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    if (bills.isEmpty) {
      return Text(
        Strings.noRecentBills,
        style: FontPalette.base400(14, color: colors.secondaryText),
      );
    }

    return WebGrid(
      mobileColumns: 1,
      tabletColumns: 2,
      desktopColumns: 2,
      children: [
        for (final bill in bills)
          _BillGridCard(
            bill: bill,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => BillDetailScreen(billId: bill.id),
                ),
              );
            },
          ),
      ],
    );
  }
}

class _BillGridCard extends StatelessWidget {
  const _BillGridCard({required this.bill, required this.onTap});

  final BillModel bill;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final isPaid = bill.paymentStatus.toLowerCase() == 'paid';
    final customer = bill.customerName?.isNotEmpty == true
        ? bill.customerName!
        : Strings.walkInCustomer;

    return Material(
      color: colors.inputBackground,
      borderRadius: BorderRadius.circular(WebSpacing.cardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(WebSpacing.cardRadius),
        child: Container(
          padding: const EdgeInsets.all(WebSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(WebSpacing.cardRadius),
            border: Border.all(color: colors.inputBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: ColorPalette.homeStatGreenBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.receipt_long_outlined,
                      size: 18,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(width: WebSpacing.sm),
                  Expanded(
                    child: Text(
                      bill.orderNumber,
                      style: FontPalette.base600(14, color: colors.primaryText),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: WebSpacing.sm),
              Text(
                customer,
                style: FontPalette.base500(13, color: colors.primaryText),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                bill.dateString,
                style: FontPalette.base400(12, color: colors.secondaryText),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: WebSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDisplayCurrency(bill.totalAmount),
                    style: FontPalette.base700(15, color: colors.primary),
                  ),
                  _StatusChip(
                    label: isPaid ? Strings.paid : Strings.unpaid,
                    isPositive: isPaid,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.isPositive});

  final String label;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    final bg = isPositive
        ? ColorPalette.homePaidBadgeBg
        : ColorPalette.formValidationErrorColor.withValues(alpha: 0.1);
    final fg = isPositive
        ? ColorPalette.homePaidBadgeBorder
        : ColorPalette.formValidationErrorColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: fg),
      ),
      child: Text(
        label,
        style: FontPalette.base600(10, color: fg),
      ),
    );
  }
}
