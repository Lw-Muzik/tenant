import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/tenant.dart';
import '../../application/use_cases/get_tenant_use_case.dart';

class TenantController extends Cubit<Tenant?> {
  final GetTenantUseCase _getTenantUseCase;

  TenantController(this._getTenantUseCase) : super(null);

  Future<void> fetchTenant(String tenantId) async {
    final tenant = await _getTenantUseCase.execute(tenantId);
    emit(tenant);
  }
}
