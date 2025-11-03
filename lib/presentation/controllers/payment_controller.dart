import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/use_cases/make_payment_use_case.dart';

enum PaymentState { initial, loading, success, error }

class PaymentController extends Cubit<PaymentState> {
  final MakePaymentUseCase _makePaymentUseCase;

  PaymentController(this._makePaymentUseCase) : super(PaymentState.initial);

  Future<void> makePayment({
    required String tenantId,
    required double rentAmount,
    required double electricityAmount,
    required String phoneNumber,
    required String paymentMode,
  }) async {
    emit(PaymentState.loading);

    try {
      final success = await _makePaymentUseCase.execute(
        tenantId: tenantId,
        rentAmount: rentAmount,
        electricityAmount: electricityAmount,
        phoneNumber: phoneNumber,
        paymentMode: paymentMode,
      );

      if (success) {
        emit(PaymentState.success);
      } else {
        emit(PaymentState.error);
      }
    } catch (e) {
      emit(PaymentState.error);
    }
  }
}
