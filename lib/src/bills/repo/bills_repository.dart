// lib/src/bills/repo/bills_repository.dart
import 'package:either_dart/either.dart';
import 'package:vyapapp/data/remote/network_base_services.dart';
import '../model/bill_model.dart';

abstract class BillsRepo {
  Future<Either<ResponseError, BillsResponseModel>> getBills();
}

class BillsRepoImpl implements BillsRepo {
  BillsRepoImpl();

  @override
  Future<Either<ResponseError, BillsResponseModel>> getBills() async {
    // Simulating minor network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final threeDaysAgo = now.subtract(const Duration(days: 3));
    final fiveDaysAgo = now.subtract(const Duration(days: 5));

    final billsList = [
      BillModel(
        billNumber: '#1045',
        timeLabel: '9:35 AM',
        customerLabel: 'Walk-in Customer',
        itemsCount: 2,
        amount: 85.00,
        isPaid: true,
        paymentMethod: 'Cash',
        date: now,
      ),
      BillModel(
        billNumber: '#1044',
        timeLabel: '9:31 AM',
        customerLabel: 'Rajesh',
        itemsCount: 3,
        amount: 120.00,
        isPaid: true,
        paymentMethod: 'UPI',
        date: now,
      ),
      BillModel(
        billNumber: '#1043',
        timeLabel: '9:25 AM',
        customerLabel: 'Walk-in Customer',
        itemsCount: 1,
        amount: 45.00,
        isPaid: true,
        paymentMethod: 'Cash',
        date: now,
      ),
      BillModel(
        billNumber: '#1042',
        timeLabel: '9:18 AM',
        customerLabel: 'Suresh',
        itemsCount: 4,
        amount: 60.00,
        isPaid: true,
        paymentMethod: 'Card',
        date: now,
      ),
      BillModel(
        billNumber: '#1041',
        timeLabel: '9:12 AM',
        customerLabel: 'Walk-in Customer',
        itemsCount: 2,
        amount: 110.00,
        isPaid: true,
        paymentMethod: 'UPI',
        date: now,
      ),
      BillModel(
        billNumber: '#1040',
        timeLabel: '9:05 AM',
        customerLabel: 'Ajith',
        itemsCount: 3,
        amount: 150.00,
        isPaid: true,
        paymentMethod: 'Cash',
        date: now,
      ),
      BillModel(
        billNumber: '#1039',
        timeLabel: '9:00 AM',
        customerLabel: 'Walk-in Customer',
        itemsCount: 1,
        amount: 30.00,
        isPaid: true,
        paymentMethod: 'Card',
        date: now,
      ),
      BillModel(
        billNumber: '#1038',
        timeLabel: 'Yesterday 4:30 PM',
        customerLabel: 'Amit',
        itemsCount: 5,
        amount: 250.00,
        isPaid: false,
        paymentMethod: 'Card',
        date: yesterday,
      ),
      BillModel(
        billNumber: '#1037',
        timeLabel: 'Yesterday 11:15 AM',
        customerLabel: 'Walk-in Customer',
        itemsCount: 2,
        amount: 50.00,
        isPaid: true,
        paymentMethod: 'Cash',
        date: yesterday,
      ),
      BillModel(
        billNumber: '#1036',
        timeLabel: '3 Days Ago',
        customerLabel: 'Vikram',
        itemsCount: 6,
        amount: 420.00,
        isPaid: true,
        paymentMethod: 'UPI',
        date: threeDaysAgo,
      ),
      BillModel(
        billNumber: '#1035',
        timeLabel: '5 Days Ago',
        customerLabel: 'Walk-in Customer',
        itemsCount: 1,
        amount: 20.00,
        isPaid: false,
        paymentMethod: 'Cash',
        date: fiveDaysAgo,
      ),
    ];

    // Compute stats dynamically from the mock list
    double totalSales = 0.0;
    int totalBills = billsList.length;
    int pendingBills = 0;

    for (final bill in billsList) {
      if (bill.isPaid) {
        totalSales += bill.amount;
      } else {
        pendingBills++;
      }
    }

    double avgBillValue = totalBills > 0 ? (totalSales / totalBills) : 0.0;

    final summary = BillsSummaryModel(
      totalBills: totalBills,
      totalSales: totalSales,
      avgBillValue: avgBillValue,
      pendingBills: pendingBills,
    );

    return Right(
      BillsResponseModel(
        summary: summary,
        bills: billsList,
      ),
    );
  }
}
