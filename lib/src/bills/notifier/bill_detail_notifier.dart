// lib/src/bills/notifier/bill_detail_notifier.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thuga/services/repo_di.dart';
import '../model/bill_detail_model.dart';

part 'bill_detail_notifier.g.dart';

@riverpod
class BillDetailNotifier extends _$BillDetailNotifier {
  @override
  FutureOr<BillDetailModel> build(int id) async {
    final repo = ref.read(billsRepositoryProvider);
    final result = await repo.getBillDetail(id);
    return result.fold(
      (left) => throw left.message ?? 'Failed to load bill details',
      (right) => right.results,
    );
  }
}
