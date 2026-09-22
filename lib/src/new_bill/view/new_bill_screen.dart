// lib/src/new_bill/view/new_bill_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/src/bar_code_scanner/view/barcode_scanner.dart';
import 'package:thuga/src/printer/notifier/printer_notifier.dart';
import 'package:thuga/utils/common_widgets/common_dialog_box.dart';
import 'package:thuga/utils/common_widgets/printer_state_sync_host.dart';
import 'package:thuga/utils/common_widgets/common_scaffold.dart';
import 'package:thuga/res/enums/enums.dart';
import 'package:thuga/utils/common_widgets/common_switch_state.dart';

import '../notifier/new_bill_notifier.dart';
import 'widget/amount_entry_view.dart';
import 'widget/new_bill_footer.dart';
import 'widget/new_bill_header.dart';
import 'widget/quick_tap_view.dart';

void _onPaymentStatusChanged(
  BuildContext context,
  WidgetRef ref,
  String status,
) {
  final state = ref.read(newBillProvider);
  final notifier = ref.read(newBillProvider.notifier);

  final needsConfirm =
      state.selectedCustomer == null &&
      status != 'Paid' &&
      state.paymentStatus == 'Paid';

  if (!needsConfirm) {
    notifier.setPaymentStatus(status);
    return;
  }

  CommonDialogBox.show(
    context: context,
    title: Strings.noCustomerSelectedTitle,
    message: Strings.continueWithoutCustomerMessage,
    primaryLabel: Strings.continueLabel,
    secondaryLabel: Strings.cancel,
    onPrimary: () => notifier.setPaymentStatus(status),
  );
}

LoaderState _screenLoaderState({
  required LoaderState loaderState,
  required bool categoriesEmpty,
}) {
  if (!categoriesEmpty) {
    return switch (loaderState) {
      LoaderState.loading ||
      LoaderState.noSearchData ||
      LoaderState.noData => LoaderState.loaded,
      _ => loaderState,
    };
  }
  return loaderState;
}

class NewBillScreen extends ConsumerWidget {
  const NewBillScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final billNumber = ref.watch(newBillProvider.select((s) => s.billNumber));
    final loaderState = ref.watch(newBillProvider.select((s) => s.loaderState));
    final categoriesEmpty = ref.watch(
      newBillProvider.select((s) => s.categories.isEmpty),
    );
    final billingMode = ref.watch(newBillProvider.select((s) => s.billingMode));
    final cart = ref.watch(newBillProvider.select((s) => s.cart));
    final paymentMethod = ref.watch(
      newBillProvider.select((s) => s.paymentMethod),
    );
    final selectedCustomer = ref.watch(
      newBillProvider.select((s) => s.selectedCustomer),
    );
    final paymentStatus = ref.watch(
      newBillProvider.select((s) => s.paymentStatus),
    );
    final receivedAmount = ref.watch(
      newBillProvider.select((s) => s.receivedAmount),
    );
    final isSavingBill = ref.watch(
      newBillProvider.select((s) => s.isSavingBill),
    );
    final notifier = ref.read(newBillProvider.notifier);
    final canAttemptPrint = ref.watch(
      printerProvider.select(selectCanAttemptPrint),
    );

    // Compute tax-inclusive grand total
    final totals = notifier.billTotals;
    final totalAmount = totals.grandTotal;

    return PrinterStateSyncHost(
      child: CommonScaffold(
        backgroundColor: colors.background,
        appBar: NewBillHeader(
          billNumber: billNumber,
          onScanTap: () async {
            final barcode = await BarcodeScanner.scan(
              context,
              title: Strings.scanBarcode,
            );
            if (barcode != null && barcode.isNotEmpty) {
              notifier.addProductByBarcode(barcode);
            }
          },
        ),
        body: CommonSwitchState(
          loaderState: loaderState,
          reload: () => notifier.fetchProducts(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              8.verticalSpace,
              // Segmented control mode selector
              // NewBillModeSelector(
              //   selectedMode: billingMode,
              //   onModeChanged: (val) => notifier.setBillingMode(val),
              // ),
              // 8.verticalSpace,

              // Active View based on selected billingMode
              if (billingMode == 0)
                const QuickTapView()
              else
                AmountEntryView(
                  amountController: notifier.amountController,
                  descriptionController: notifier.descriptionController,
                  cartItems: cart,
                  onAddPressed: () => notifier.addAmountEntry(),
                  onRemoveItem: (item) => notifier.decrementQuantity(item),
                ),

              // Footer Section
              NewBillFooter(
                totalAmount: totalAmount,
                isPrinterConnected: canAttemptPrint,
                isSaving: isSavingBill,
                paymentMethod: paymentMethod,
                selectedCustomer: selectedCustomer,
                paymentStatus: paymentStatus,
                receivedAmount: receivedAmount,
                receivedAmountController: notifier.receivedAmountController,
                onPaymentMethodChanged: (val) => notifier.setPaymentMethod(val),
                onPaymentStatusChanged: (status) =>
                    _onPaymentStatusChanged(context, ref, status),
                onSubmitPressed: () => notifier.saveAndMaybePrint(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
