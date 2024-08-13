import 'dart:async';

import 'package:anexpress/features/payment_manually_feature/data/store_calculation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_manually_event.dart';
part 'payment_manually_state.dart';

class PaymentManuallyBloc
    extends Bloc<PaymentManuallyEvent, PaymentManuallyState> {
  PaymentManuallyBloc({required this.repository})
      : super(PaymentManuallyInitial()) {
    on<GetPaymentManuallyEvent>(_onGetPaymentManuallyEvent);
  }

  final PaymentManuallyRepository repository;

  FutureOr<void> _onGetPaymentManuallyEvent(
    GetPaymentManuallyEvent event,
    Emitter<PaymentManuallyState> emit,
  ) async {
    // update status to loading
    emit(PaymentManuallyLoading());

    // emit values received from event
    try {
      final result = await repository.requestPerformPaymentManually(
          requestMap: event.requestMap);

      emit(PaymentManuallyLoaded(message: result));

      // incase error through exception with error state
    } on Exception catch (e) {
      emit(PaymentManuallyError(errorMessage: '$e'));
    }
  }
}
