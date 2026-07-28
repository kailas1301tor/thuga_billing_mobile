// lib/src/new_bill/view/mobile/new_bill_mobile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thuga/res/styles/color_palette.dart';
import 'package:thuga/src/printer/notifier/printer_notifier.dart';
import 'package:thuga/utils/common_widgets/common_scaffold.dart';
import 'package:thuga/utils/common_widgets/common_switch_state.dart';

import '../../notifier/new_bill_notifier.dart';
import '../new_bill_actions.dart';
import '../widget/amount_entry_view.dart';
import '../widget/new_bill_footer.dart';
import '../widget/new_bill_header.dart';
import '../widget/quick_tap_view.dart';

class NewBillMobileScreen extends ConsumerWidget {
  const NewBillMobileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final state = ref.watch(newBillProvider);
    final notifier = ref.read(newBillProvider.notifier);
    final isPrinterConnected = ref.watch(
      printerProvider.select((value) => value.isConnected),
    );

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
                  handleNewBillPaymentStatusChange(context, ref, status),
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
