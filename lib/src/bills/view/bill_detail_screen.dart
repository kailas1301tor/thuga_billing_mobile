// lib/src/bills/view/bill_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vyapapp/utils/common_widgets/common_app_bar.dart';
import 'package:vyapapp/utils/common_widgets/common_scaffold.dart';
import 'package:vyapapp/utils/common_widgets/common_loader.dart';

import '../notifier/bill_detail_notifier.dart';
import 'widget/bill_detail_content.dart';

class BillDetailScreen extends ConsumerWidget {
  const BillDetailScreen({super.key, required this.billId});

  final int billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(billDetailNotifierProvider(billId));

    return CommonScaffold(
      appBar: const CommonAppBar(
        title: 'Bill Details',
        showBackButton: true,
      ),
      body: detailAsync.when(
        loading: () => const CommonLoader(),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(billDetailNotifierProvider(billId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (detail) => BillDetailContent(billDetail: detail),
      ),
    );
  }
}
