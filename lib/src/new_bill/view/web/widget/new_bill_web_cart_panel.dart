// lib/src/new_bill/view/web/widget/new_bill_web_cart_panel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/res/styles/font_palette.dart';
import 'package:thuga/res/styles/web_spacing.dart';
import 'package:thuga/src/main/model/dropdown_model.dart';
import 'package:thuga/src/main/notifier/dropdowns_notifier.dart';
import 'package:thuga/src/printer/notifier/printer_notifier.dart';
import 'package:thuga/utils/common_widgets/bottomsheet_content.dart';
import 'package:thuga/utils/common_widgets/common_bottom_sheet.dart';
import 'package:thuga/utils/common_widgets/common_cached_network_image.dart';
import 'package:thuga/utils/common_widgets/common_text_form_field.dart';
import 'package:thuga/utils/common_widgets/primary_button.dart';
import 'package:thuga/utils/helpers/bill_tax_helper.dart';
import 'package:thuga/utils/helpers/extensions.dart';

import '../../../model/new_bill_model.dart';
import '../../../notifier/new_bill_notifier.dart';
import '../../new_bill_actions.dart';
import '../../widget/item_discount_sheet.dart';

class NewBillWebCartPanel extends ConsumerWidget {
  const NewBillWebCartPanel({
    super.key,
    required this.onSubmit,
    required this.onApplyDiscount,
  });

  final VoidCallback onSubmit;
  final VoidCallback onApplyDiscount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final notifier = ref.read(newBillProvider.notifier);
    final cartItems = ref.watch(newBillProvider.select((s) => s.cart));
    final discountAmount = ref.watch(
      newBillProvider.select((s) => s.discountAmount),
    );
    final paymentStatus = ref.watch(
      newBillProvider.select((s) => s.paymentStatus),
    );
    final paymentMethod = ref.watch(
      newBillProvider.select((s) => s.paymentMethod),
    );
    final selectedCustomer = ref.watch(
      newBillProvider.select((s) => s.selectedCustomer),
    );
    final isPrinterConnected = ref.watch(
      printerProvider.select((value) => value.isConnected),
    );
    final isSavingBill = ref.watch(
      newBillProvider.select((s) => s.isSavingBill),
    );
    final paymentMethods = ref.watch(
      dropdownsProvider.select((s) => s.data.paymentMethods),
    );
    final dropdownsLoaderState = ref.watch(
      dropdownsProvider.select((s) => s.loaderState),
    );
    final totals = notifier.billTotals;
    final grandTotal = totals.grandTotal;

    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(left: BorderSide(color: colors.inputBorder)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              WebSpacing.lg,
              WebSpacing.lg,
              WebSpacing.lg,
              WebSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    Strings.orderSummary,
                    style: FontPalette.base700(18, color: colors.primaryText),
                  ),
                ),
                if (cartItems.isNotEmpty)
                  TextButton(
                    onPressed: notifier.clearCart,
                    child: Text(
                      Strings.clearAll,
                      style: FontPalette.base600(13, color: colors.errorText),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: cartItems.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(WebSpacing.lg),
                      child: Text(
                        Strings.newBillPlaceholder,
                        textAlign: TextAlign.center,
                        style: FontPalette.base400(
                          14,
                          color: colors.secondaryText,
                        ),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: WebSpacing.lg,
                    ),
                    itemCount: cartItems.length,
                    separatorBuilder: (_, __) => Divider(
                      color: colors.inputBorder,
                      height: 1,
                    ),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return _CartLineItem(
                        item: item,
                        onIncrement: () => notifier.incrementQuantity(item),
                        onDecrement: () => notifier.decrementQuantity(item),
                        onRemove: () => notifier.removeCartItem(item),
                        onDiscount: () => _showItemDiscount(context, ref, item),
                      );
                    },
                  ),
          ),
          if (cartItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: WebSpacing.lg),
              child: _TotalsBlock(
                totals: totals,
                discountAmount: discountAmount,
                onEditDiscount: onApplyDiscount,
              ),
            ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(WebSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  Strings.paymentStatusLabel,
                  style: FontPalette.base600(12, color: colors.secondaryText),
                ),
                const SizedBox(height: WebSpacing.sm),
                Row(
                  children: [
                    _StatusChip(
                      label: Strings.paid,
                      selected: paymentStatus == Strings.paid,
                      onTap: () => handleNewBillPaymentStatusChange(
                        context,
                        ref,
                        Strings.paid,
                      ),
                    ),
                    const SizedBox(width: WebSpacing.xs),
                    _StatusChip(
                      label: Strings.unpaid,
                      selected: paymentStatus == Strings.credit,
                      onTap: () => handleNewBillPaymentStatusChange(
                        context,
                        ref,
                        Strings.credit,
                      ),
                    ),
                    const SizedBox(width: WebSpacing.xs),
                    _StatusChip(
                      label: Strings.partiallyPaid,
                      selected: paymentStatus == Strings.partiallyPaid,
                      onTap: () => handleNewBillPaymentStatusChange(
                        context,
                        ref,
                        Strings.partiallyPaid,
                      ),
                    ),
                  ],
                ),
                if (paymentStatus == Strings.partiallyPaid) ...[
                  const SizedBox(height: WebSpacing.md),
                  CommonTextFormField(
                    controller: notifier.receivedAmountController,
                    title: Strings.amountReceived,
                    hintText: Strings.enterAmountReceived,
                    inputType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ],
                if (paymentStatus == Strings.credit)
                  Padding(
                    padding: const EdgeInsets.only(top: WebSpacing.sm),
                    child: Text(
                      selectedCustomer != null
                          ? '${grandTotal.toCurrency()} will be added to ${selectedCustomer.name}\'s credit balance'
                          : '${grandTotal.toCurrency()} ${Strings.walkInCreditBalanceMessage}',
                      style: FontPalette.base500(12, color: colors.errorText),
                    ),
                  ),
                const SizedBox(height: WebSpacing.md),
                Row(
                  children: [
                    _PaymentMethodButton(
                      method: paymentMethod,
                      onTap: () {
                        showSingleSelectBottomSheet<DropdownItemModel>(
                          context: context,
                          ref: ref,
                          title: Strings.selectPaymentMethod,
                          options: paymentMethods,
                          currentValue: paymentMethods.firstWhere(
                            (m) =>
                                m.id.toLowerCase() ==
                                paymentMethod.toLowerCase(),
                            orElse: () => paymentMethods.isNotEmpty
                                ? paymentMethods.first
                                : const DropdownItemModel(
                                    id: 'Cash',
                                    name: 'Cash',
                                  ),
                          ),
                          onSelected: (method) =>
                              notifier.setPaymentMethod(method.id),
                          displayText: (method) => method.name,
                          loaderState: dropdownsLoaderState,
                        );
                      },
                    ),
                    const SizedBox(width: WebSpacing.sm),
                    Expanded(
                      child: PrimaryButton(
                        onPressed: grandTotal > 0 && !isSavingBill ? onSubmit : null,
                        isLoading: isSavingBill,
                        radius: 12,
                        height: 48,
                        prefixIcon: Icon(
                          isPrinterConnected
                              ? Icons.print_rounded
                              : Icons.save_rounded,
                          size: 18,
                          color: ColorPalette.white,
                        ),
                        text: isPrinterConnected
                            ? '${Strings.printBill} · ${grandTotal.toCurrency()}'
                            : '${Strings.saveBillLabel} · ${grandTotal.toCurrency()}',
                        fontStyle:
                            FontPalette.base700(14, color: ColorPalette.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showItemDiscount(
    BuildContext context,
    WidgetRef ref,
    CartItemModel item,
  ) {
    final notifier = ref.read(newBillProvider.notifier);
    CommonBottomSheet.show(
      context: context,
      title: Strings.discount,
      isScrollControlled: true,
      child: ItemDiscountSheet(
        item: item,
        onApply: ({
          required String discountType,
          required double discountValue,
          int? bogoBuyQty,
          int? bogoGetQty,
        }) {
          notifier.updateCartItemDiscount(
            item: item,
            discountType: discountType,
            discountValue: discountValue,
            bogoBuyQty: bogoBuyQty,
            bogoGetQty: bogoGetQty,
          );
        },
        onRemove: () => notifier.removeCartItemDiscount(item),
      ),
    );
  }
}

class _CartLineItem extends StatelessWidget {
  const _CartLineItem({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    required this.onDiscount,
  });

  final CartItemModel item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;
  final VoidCallback onDiscount;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: WebSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(WebSpacing.xs),
            child: SizedBox(
              width: 44,
              height: 44,
              child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                  ? CommonCachedNetworkImage(
                      imageUrl: item.imageUrl!,
                      width: 44,
                      height: 44,
                      memCacheWidth: 88,
                      memCacheHeight: 88,
                      fit: BoxFit.cover,
                    )
                  : ColoredBox(
                      color: colors.inputBackground,
                      child: Center(
                        child: Text(item.emoji, style: const TextStyle(fontSize: 20)),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: WebSpacing.sm),
          Expanded(
            child: GestureDetector(
              onTap: onDiscount,
              behavior: HitTestBehavior.opaque,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: FontPalette.base600(13, color: colors.primaryText),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.totalPrice.toCurrency(),
                    style: FontPalette.base600(12, color: colors.primary),
                  ),
                  if (item.hasDiscount)
                    Text(
                      item.discountLabel,
                      style: FontPalette.base500(11, color: colors.primary),
                    ),
                ],
              ),
            ),
          ),
          _QtyControl(
            quantity: item.quantity,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          ),
          IconButton(
            tooltip: Strings.clear,
            onPressed: onRemove,
            icon: Icon(Icons.close_rounded, size: 18, color: colors.secondaryText),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}

class _QtyControl extends StatelessWidget {
  const _QtyControl({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors.inputBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QtyButton(icon: Icons.remove, onTap: onDecrement),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '$quantity',
              style: FontPalette.base700(13, color: colors.primaryText),
            ),
          ),
          _QtyButton(icon: Icons.add, onTap: onIncrement),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 16, color: context.appColors.primaryText),
      ),
    );
  }
}

class _TotalsBlock extends StatelessWidget {
  const _TotalsBlock({
    required this.totals,
    required this.discountAmount,
    required this.onEditDiscount,
  });

  final BillTotals totals;
  final double discountAmount;
  final VoidCallback onEditDiscount;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      children: [
        _TotalRow(
          label: Strings.customerSubtotal,
          value: totals.subtotal.toCurrency(),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onEditDiscount,
          child: _TotalRow(
            label: Strings.discount,
            value: discountAmount > 0
                ? '- ${discountAmount.toCurrency()}'
                : 0.toCurrency(),
            valueColor: discountAmount > 0 ? colors.primary : null,
            trailing: Icon(Icons.edit_rounded, size: 14, color: colors.primary),
          ),
        ),
        if (totals.sgstTotal > 0) ...[
          const SizedBox(height: 6),
          _TotalRow(
            label: Strings.sgstTotal,
            value: totals.sgstTotal.toCurrency(),
          ),
        ],
        if (totals.cgstTotal > 0) ...[
          const SizedBox(height: 6),
          _TotalRow(
            label: Strings.cgstTotal,
            value: totals.cgstTotal.toCurrency(),
          ),
        ],
        const SizedBox(height: WebSpacing.sm),
        _TotalRow(
          label: Strings.totalLabel,
          value: totals.grandTotal.toCurrency(),
          labelStyle: FontPalette.base700(15, color: colors.primaryText),
          valueStyle: FontPalette.base700(16, color: colors.primary),
        ),
        const SizedBox(height: WebSpacing.md),
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
    this.valueColor,
    this.trailing,
  });

  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final Color? valueColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      children: [
        Text(
          label,
          style: labelStyle ??
              FontPalette.base500(13, color: colors.secondaryText),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 4),
          trailing!,
        ],
        const Spacer(),
        Text(
          value,
          style: valueStyle ??
              FontPalette.base600(13, color: valueColor ?? colors.primaryText),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected
                ? colors.primary.withValues(alpha: 0.12)
                : colors.inputBackground,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? colors.primary : colors.inputBorder,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: FontPalette.base600(
              11,
              color: selected ? colors.primary : colors.secondaryText,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class _PaymentMethodButton extends StatelessWidget {
  const _PaymentMethodButton({
    required this.method,
    required this.onTap,
  });

  final String method;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: colors.inputBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colors.inputBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.payments_outlined, size: 18, color: colors.primary),
            const SizedBox(width: 6),
            Text(
              method,
              style: FontPalette.base600(13, color: colors.primaryText),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: colors.secondaryText,
            ),
          ],
        ),
      ),
    );
  }
}
