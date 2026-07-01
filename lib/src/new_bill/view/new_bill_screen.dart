// lib/src/new_bill/view/new_bill_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vyapapp/res/styles/color_palette.dart';
import 'package:vyapapp/utils/common_widgets/common_scaffold.dart';
import 'package:vyapapp/utils/common_widgets/common_switch_state.dart';

import '../notifier/new_bill_notifier.dart';
import 'widget/amount_entry_view.dart';
import 'widget/new_bill_footer.dart';
import 'widget/new_bill_header.dart';
import 'widget/quick_tap_view.dart';

class NewBillScreen extends ConsumerWidget {
  const NewBillScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final state = ref.watch(newBillNotifierProvider);
    final notifier = ref.read(newBillNotifierProvider.notifier);

    // Compute total amount in cart
    final subtotal = state.cart.fold<double>(
      0,
      (sum, item) => sum + item.totalPrice,
    );
    final totalAmount = (subtotal - state.discountAmount).clamp(0.0, double.infinity);

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
              paymentMethod: state.paymentMethod,
              onPaymentMethodChanged: (val) => notifier.setPaymentMethod(val),
              onPrintPressed: () => notifier.printBill(context),
            ),
          ],
        ),
      ),
    );
  }
}
