import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';

class FirebasePaymentRepository implements PaymentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> recordPayment(PaymentEntity payment) async {
    await _firestore.collection('payments').add({
      'tenantId': payment.tenantId,
      'tenantName': payment.tenantName,
      'amountPaid': payment.amount.toString(),
      'balance': payment.balance.toString(),
      'property': payment.property,
      'date': payment.date.toString(),
      'paymentMode': payment.paymentMode,
      'status': payment.status,
      'electricityBill': payment.electricityBill.toString(),
    });
  }

  @override
  Future<List<PaymentEntity>> getPaymentHistory(String tenantId) async {
    final snapshot = await _firestore
        .collection('payments')
        .where('tenantId', isEqualTo: tenantId)
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return PaymentEntity(
        id: doc.id,
        tenantId: data['tenantId'],
        tenantName: data['tenantName'],
        amount: double.parse(data['amountPaid'] ?? '0'),
        balance: double.parse(data['balance'] ?? '0'),
        property: data['property'],
        date: DateTime.parse(data['date']),
        paymentMode: data['paymentMode'],
        status: data['status'],
        electricityBill: double.parse(data['electricityBill'] ?? '0'),
      );
    }).toList();
  }

  @override
  Future<PaymentEntity?> getLatestPayment(String tenantId) async {
    final payments = await getPaymentHistory(tenantId);
    return payments.isNotEmpty ? payments.first : null;
  }
}
