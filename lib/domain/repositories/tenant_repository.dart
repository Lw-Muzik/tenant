import '../entities/tenant.dart';

abstract class TenantRepository {
  Future<Tenant?> getTenantById(String tenantId);
  Future<void> updateTenantPayment(
    String tenantId,
    double rentAmount,
    double electricityAmount,
  );
  Future<List<Tenant>> getAllTenants();
}
