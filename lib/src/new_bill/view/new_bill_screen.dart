// lib/src/new_bill/view/new_bill_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/constants/string_constants.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/src/printer/notifier/printer_notifier.dart';
import 'package:vyapapp/utils/common_widgets/common_dialog_box.dart';
import 'package:vyapapp/utils/common_widgets/common_scaffold.dart';
import 'package:vyapapp/utils/common_widgets/common_switch_state.dart';

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
  final state = ref.read(newBillNotifierProvider);
  final notifier = ref.read(newBillNotifierProvider.notifier);

  final needsConfirm = state.selectedCustomer == null &&
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

class NewBillScreen extends ConsumerWidget {
  const NewBillScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final state = ref.watch(newBillNotifierProvider);
    final notifier = ref.read(newBillNotifierProvider.notifier);
    final isPrinterConnected = ref.watch(
      printerNotifierProvider.select((value) => value.isConnected),
    );

    // Compute tax-inclusive grand total
    final totals = notifier.billTotals;
    final totalAmount = totals.grandTotal;

    return CommonScaffold(
      backgroundColor: colors.background,
      appBar: NewBillHeader(billNumber: state.billNumber),
      body: CommonSwitchState(
        loaderState: state.loaderState,
        reload: () => notifier.fetchProducts(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            8.verticalSpace,
            // Segmented control mode selector
            // NewBillModeSelector(
            //   selectedMode: state.billingMode,
            //   onModeChanged: (val) => notifier.setBillingMode(val),
            // ),
            // 8.verticalSpace,

            // Active View based on selected billingMode
            if (state.billingMode == 0)
              const QuickTapView()
            else
              AmountEntryView(
                amountController: notifier.amountController,
                descriptionController: notifier.descriptionController,
                cartItems: state.cart,
                onAddPressed: () => notifier.addAmountEntry(),
                onRemoveItem: (item) => notifier.decrementQuantity(item),
              ),

            // Footer Section
            NewBillFooter(
              totalAmount: totalAmount,
              isPrinterConnected: isPrinterConnected,
              paymentMethod: state.paymentMethod,
              selectedCustomer: state.selectedCustomer,
              paymentStatus: state.paymentStatus,
              receivedAmount: state.receivedAmount,
              receivedAmountController: notifier.receivedAmountController,
              onPaymentMethodChanged: (val) => notifier.setPaymentMethod(val),
              onPaymentStatusChanged: (status) =>
                  _onPaymentStatusChanged(context, ref, status),
              onSubmitPressed: () => notifier.saveAndMaybePrint(
                context,
                printWhenPossible: isPrinterConnected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
