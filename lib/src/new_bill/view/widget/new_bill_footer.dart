// lib/src/new_bill/view/widget/new_bill_footer.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/utils/common_widgets/bottomsheet_content.dart';
import 'package:thuga/utils/common_widgets/common_text_form_field.dart';
import 'package:thuga/utils/common_widgets/primary_button.dart';
import 'package:thuga/utils/helpers/extensions.dart';
import '../../../main/model/dropdown_model.dart';
import '../../../main/notifier/dropdowns_notifier.dart';

class NewBillFooter extends ConsumerWidget {
  const NewBillFooter({
    super.key,
    required this.totalAmount,
    required this.isPrinterConnected,
    required this.paymentMethod,
    required this.selectedCustomer,
    required this.paymentStatus,
    required this.receivedAmount,
    required this.receivedAmountController,
    required this.onPaymentMethodChanged,
    required this.onPaymentStatusChanged,
    required this.onSubmitPressed,
  });

  final double totalAmount;
  final bool isPrinterConnected;
  final String paymentMethod;
  final DropdownCustomerModel? selectedCustomer;
  final String paymentStatus;
  final double receivedAmount;
  final TextEditingController receivedAmountController;
  final ValueChanged<String> onPaymentMethodChanged;
  final ValueChanged<String> onPaymentStatusChanged;
  final VoidCallback onSubmitPressed;

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
          padding: EdgeInsets.symmetric(vertical: 6.h),
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
              10,
              color: isSelected ? colors.primary : colors.secondaryText,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;

    final dropdownsState = ref.watch(dropdownsProvider);
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
            Row(
              children: [
                Text(
                  Strings.paymentStatusLabel,
                  style: FontPalette.base700(11, color: colors.secondaryText),
                ),
                8.horizontalSpace,
                _buildChoiceChip(
                  context: context,
                  label: Strings.paid,
                  isSelected: paymentStatus == Strings.paid,
                  onTap: () => onPaymentStatusChanged(Strings.paid),
                ),
                6.horizontalSpace,
                _buildChoiceChip(
                  context: context,
                  label: Strings.unpaid,
                  isSelected: paymentStatus == Strings.credit,
                  onTap: () => onPaymentStatusChanged(Strings.credit),
                ),
                6.horizontalSpace,
                _buildChoiceChip(
                  context: context,
                  label: Strings.partiallyPaid,
                  isSelected: paymentStatus == Strings.partiallyPaid,
                  onTap: () => onPaymentStatusChanged(Strings.partiallyPaid),
                ),
              ],
            ),
            if (paymentStatus == Strings.partiallyPaid)
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
                      'Balance: ${(totalAmount - receivedAmount).clamp(0.0, totalAmount).toCurrency()}',
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
            if (paymentStatus == Strings.credit)
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
                        selectedCustomer != null
                            ? '${totalAmount.toCurrency()} will be added to ${selectedCustomer!.name}\'s credit balance'
                            : '${totalAmount.toCurrency()} ${Strings.walkInCreditBalanceMessage}',
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

                // Right: Save/Print Button (Takes all remaining width)
                Expanded(
                  child: PrimaryButton(
                    onPressed: totalAmount > 0 ? onSubmitPressed : null,
                    radius: 12,
                    prefixIcon: Icon(
                      isPrinterConnected
                          ? Icons.print_rounded
                          : Icons.save_rounded,
                      size: 20.r,
                      color: Colors.white,
                    ),
                    text:
                        '${isPrinterConnected ? Strings.printBill.toUpperCase() : Strings.saveBillLabel.toUpperCase()}  ·  ${totalAmount.toCurrency()}',
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
