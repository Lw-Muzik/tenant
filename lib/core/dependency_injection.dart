import '../domain/repositories/tenant_repository.dart';
import '../domain/repositories/payment_repository.dart';
import '../exports/exports.dart' hide TenantController;
import '../infrastructure/repositories/firebase_tenant_repository.dart';
import '../infrastructure/repositories/firebase_payment_repository.dart';
import '../application/use_cases/get_tenant_use_case.dart';
import '../application/use_cases/make_payment_use_case.dart';
import '../presentation/controllers/tenant_controller.dart';
import '../presentation/controllers/payment_controller.dart';

class DependencyInjection {
  static List<RepositoryProvider> getRepositoryProviders() {
    return [
      RepositoryProvider<TenantRepository>(
        create: (context) => FirebaseTenantRepository(),
      ),
      RepositoryProvider<PaymentRepository>(
        create: (context) => FirebasePaymentRepository(),
      ),
    ];
  }

  static List<Provider> getUseCaseProviders() {
    return [
      Provider<GetTenantUseCase>(
        create: (context) => GetTenantUseCase(context.read<TenantRepository>()),
      ),
      Provider<MakePaymentUseCase>(
        create: (context) => MakePaymentUseCase(
          context.read<PaymentRepository>(),
          context.read<TenantRepository>(),
        ),
      ),
    ];
  }

  static List<BlocProvider> getBlocProviders() {
    return [
      BlocProvider<TenantController>(
        create: (context) => TenantController(context.read<GetTenantUseCase>()),
      ),
      BlocProvider<PaymentController>(
        create: (context) =>
            PaymentController(context.read<MakePaymentUseCase>()),
      ),
    ];
  }
}
