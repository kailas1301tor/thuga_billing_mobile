// lib/src/new_bill/view/widget/new_bill_footer.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/res/styles/font_palette.dart';
import 'package:vyapapp/utils/common_widgets/bottomsheet_content.dart';
import 'package:vyapapp/utils/common_widgets/common_text_form_field.dart';
import 'package:vyapapp/utils/common_widgets/primary_button.dart';
import '../../../main/model/dropdown_model.dart';
import '../../../main/notifier/dropdowns_notifier.dart';

class NewBillFooter extends ConsumerWidget {
  const NewBillFooter({
    super.key,
    required this.totalAmount,
    required this.paymentMethod,
    required this.selectedCustomer,
    required this.paymentStatus,
    required this.receivedAmount,
    required this.receivedAmountController,
    required this.onPaymentMethodChanged,
    required this.onPaymentStatusChanged,
    required this.onPrintPressed,
  });

  final double totalAmount;
  final String paymentMethod;
  final DropdownCustomerModel? selectedCustomer;
  final String paymentStatus;
  final double receivedAmount;
  final TextEditingController receivedAmountController;
  final ValueChanged<String> onPaymentMethodChanged;
  final ValueChanged<String> onPaymentStatusChanged;
  final VoidCallback onPrintPressed;

  IconData _getPaymentIcon(String method) {
    final lower = method.toLowerCase();
    if (lower == 'cash') return Icons.payments_outlined;
    if (lower == 'upi') return Icons.qr_code_scanner_rounded;
    if (lower == 'card') return Icons.credit_card_rounded;
    return Icons.payment_rounded;
  }

  Widget _buildChoiceChip({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colors = context.appColors;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected
                ? colors.primary.withValues(alpha: 0.1)
                : colors.inputBackground,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected ? colors.primary : colors.inputBorder,
              width: 1.w,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: FontPalette.base700(
              12,
              color: isSelected ? colors.primary : colors.secondaryText,
            ),
          ),
        ),
      ),
    );
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Credit / Payment Status Section (Only visible for selected customers)
            if (selectedCustomer != null) ...[
              Row(
                children: [
                  Text(
                    'Payment Status:',
                    style: FontPalette.base700(12, color: colors.secondaryText),
                  ),
                  12.horizontalSpace,
                  _buildChoiceChip(
                    context: context,
                    label: 'Fully Paid',
                    isSelected: paymentStatus == 'Paid',
                    onTap: () => onPaymentStatusChanged('Paid'),
                  ),
                  8.horizontalSpace,
                  _buildChoiceChip(
                    context: context,
                    label: 'Credit',
                    isSelected: paymentStatus == 'Unpaid',
                    onTap: () => onPaymentStatusChanged('Unpaid'),
                  ),
                  8.horizontalSpace,
                  _buildChoiceChip(
                    context: context,
                    label: 'Partial',
                    isSelected: paymentStatus == 'Partial',
                    onTap: () => onPaymentStatusChanged('Partial'),
                  ),
                ],
              ),
              if (paymentStatus == 'Partial')
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: CommonTextFormField(
                    controller: receivedAmountController,
                    title: 'Amount Received',
                    hintText: 'Enter amount paid by customer',
                    inputType: const TextInputType.numberWithOptions(decimal: true),
                    suffix: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        'Balance: ₹${(totalAmount - receivedAmount).clamp(0.0, totalAmount).toStringAsFixed(2)}',
                        style: FontPalette.base700(
                          12,
                          color: (totalAmount - receivedAmount) > 0
                              ? colors.errorText
                              : Colors.green.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              if (paymentStatus == 'Unpaid')
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 14.r,
                        color: colors.errorText,
                      ),
                      6.horizontalSpace,
                      Expanded(
                        child: Text(
                          '₹${totalAmount.toStringAsFixed(2)} will be added to ${selectedCustomer?.name}\'s credit balance',
                          style: FontPalette.base500(
                            11,
                            color: colors.errorText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              12.verticalSpace,
            ],

            // Main Checkout Buttons row
            Row(
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
          ],
        ),
      ),
    );
  }
}
