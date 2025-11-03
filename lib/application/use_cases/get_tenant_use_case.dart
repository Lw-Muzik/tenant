import '../../domain/entities/tenant.dart';
import '../../domain/repositories/tenant_repository.dart';

class GetTenantUseCase {
  final TenantRepository _tenantRepository;

  GetTenantUseCase(this._tenantRepository);

  Future<Tenant?> execute(String tenantId) async {
    return await _tenantRepository.getTenantById(tenantId);
  }
}
