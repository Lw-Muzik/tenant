import '../entities/payment.dart';

abstract class PaymentRepository {
  Future<void> recordPayment(PaymentEntity payment);
  Future<List<PaymentEntity>> getPaymentHistory(String tenantId);
  Future<PaymentEntity?> getLatestPayment(String tenantId);
}
