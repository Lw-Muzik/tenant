import '../../domain/entities/payment.dart';
import '../../domain/entities/tenant.dart';
import '../../domain/repositories/payment_repository.dart';
import '../../domain/repositories/tenant_repository.dart';
import '../../domain/services/payment_service.dart';

class MakePaymentUseCase {
  final PaymentRepository _paymentRepository;
  final TenantRepository _tenantRepository;

  MakePaymentUseCase(this._paymentRepository, this._tenantRepository);

  Future<bool> execute({
    required String tenantId,
    required double rentAmount,
    required double electricityAmount,
    required String phoneNumber,
    required String paymentMode,
  }) async {
    final tenant = await _tenantRepository.getTenantById(tenantId);
    if (tenant == null) return false;

    if (!PaymentService.validatePhoneNumber(phoneNumber, tenant)) {
      return false;
    }

    if (!PaymentService.validatePaymentAmount(rentAmount) &&
        !PaymentService.validatePaymentAmount(electricityAmount)) {
      return false;
    }

    await _tenantRepository.updateTenantPayment(
      tenantId,
      rentAmount,
      electricityAmount,
    );

    final payment = PaymentService.createPayment(
      tenantId: tenantId,
      tenantName: tenant.name,
      rentAmount: rentAmount,
      electricityAmount: electricityAmount,
      paymentMode: paymentMode,
      property: tenant.property,
      balance: tenant.balance - rentAmount,
    );

    await _paymentRepository.recordPayment(payment);
    return true;
  }
}
