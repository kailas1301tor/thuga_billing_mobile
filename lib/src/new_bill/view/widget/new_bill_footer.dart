// lib/src/new_bill/view/widget/new_bill_footer.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/bottomsheet_content.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';
import '../../../main/model/dropdown_model.dart';
import '../../../main/notifier/dropdowns_notifier.dart';

class NewBillFooter extends ConsumerWidget {
  const NewBillFooter({
    super.key,
    required this.totalAmount,
    required this.paymentMethod,
    required this.onPaymentMethodChanged,
    required this.onPrintPressed,
  });

  final double totalAmount;
  final String paymentMethod;
  final ValueChanged<String> onPaymentMethodChanged;
  final VoidCallback onPrintPressed;

  IconData _getPaymentIcon(String method) {
    final lower = method.toLowerCase();
    if (lower == 'cash') return Icons.payments_outlined;
    if (lower == 'upi') return Icons.qr_code_scanner_rounded;
    if (lower == 'card') return Icons.credit_card_rounded;
    return Icons.payment_rounded;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;

    final dropdownsState = ref.watch(dropdownsNotifierProvider);
    final paymentMethods = dropdownsState.data.paymentMethods;
    final dropdownsLoader = dropdownsState.loaderState;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          top: BorderSide(color: colors.inputBorder, width: 1.w),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Left: Payment Method Toggle (Icon + Text, 52px height)
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                showSingleSelectBottomSheet<DropdownItemModel>(
                  context: context,
                  ref: ref,
                  title: 'Select Payment Method',
                  options: paymentMethods,
                  currentValue: paymentMethods.firstWhere(
                    (m) => m.id.toLowerCase() == paymentMethod.toLowerCase(),
                    orElse: () => paymentMethods.isNotEmpty
                        ? paymentMethods.first
                        : const DropdownItemModel(id: 'Cash', name: 'Cash'),
                  ),
                  onSelected: (method) => onPaymentMethodChanged(method.id),
                  displayText: (method) => method.name,
                  loaderState: dropdownsLoader,
                );
              },
              child: Container(
                height: 52.h,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: colors.inputBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: colors.inputBorder, width: 1.w),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 150),
                      child: Icon(
                        _getPaymentIcon(paymentMethod),
                        key: ValueKey(paymentMethod),
                        size: 20.r,
                        color: colors.primary,
                      ),
                    ),
                    8.horizontalSpace,
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 150),
                      child: Text(
                        paymentMethod,
                        key: ValueKey(paymentMethod),
                        style: FontPalette.base700(13, color: colors.primaryText),
                      ),
                    ),
                    4.horizontalSpace,
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16.r,
                      color: colors.secondaryText,
                    ),
                  ],
                ),
              ),
            ),
            12.horizontalSpace,

            // Right: PRINT BILL Button (Takes all remaining width)
            Expanded(
              child: PrimaryButton(
                onPressed: totalAmount > 0 ? onPrintPressed : null,
                radius: 12,
                prefixIcon: Icon(
                  Icons.print_rounded,
                  size: 20.r,
                  color: Colors.white,
                ),
                text: 'PRINT BILL  ·  ₹${totalAmount.toStringAsFixed(0)}',
                fontStyle: FontPalette.base700(14, color: Colors.white),
                height: 52,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
