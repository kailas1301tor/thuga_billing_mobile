// lib/src/new_bill/view/new_bill_actions.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thuga/res/constants/string_constants.dart';
import 'package:thuga/utils/common_widgets/common_dialog_box.dart';

import '../notifier/new_bill_notifier.dart';

void handleNewBillPaymentStatusChange(
  BuildContext context,
  WidgetRef ref,
  String status,
) {
  final state = ref.read(newBillProvider);
  final notifier = ref.read(newBillProvider.notifier);

  final needsConfirm = state.selectedCustomer == null &&
      status != Strings.paid &&
      state.paymentStatus == Strings.paid;

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
