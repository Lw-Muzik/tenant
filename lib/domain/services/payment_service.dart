import '../entities/tenant.dart';
import '../entities/payment.dart';

class PaymentService {
  static bool validatePaymentAmount(double amount) {
    return amount > 0;
  }

  static bool validatePhoneNumber(String phoneNumber, Tenant tenant) {
    return phoneNumber == tenant.contact || phoneNumber == tenant.acontact;
  }

  static PaymentEntity createPayment({
    required String tenantId,
    required String tenantName,
    required double rentAmount,
    required double electricityAmount,
    required String paymentMode,
    required String property,
    required double balance,
  }) {
    return PaymentEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      tenantId: tenantId,
      tenantName: tenantName,
      amount: rentAmount,
      balance: balance,
      property: property,
      date: DateTime.now(),
      paymentMode: paymentMode,
      status: 'success',
      electricityBill: electricityAmount,
    );
  }
}
