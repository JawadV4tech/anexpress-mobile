import 'dart:async';

import 'package:anexpress/features/payment_card_feature/data/payment_card_response_model.dart';
import 'package:anexpress/features/payment_card_feature/data/payment_card_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_card_event.dart';
part 'payment_card_state.dart';

class PaymentCardBloc extends Bloc<PaymentCardEvent, PaymentCardState> {
  PaymentCardBloc({required this.repository}) : super(PaymentCardInitial()) {
    on<GetPaymentCardEvent>(_onGetPaymentManuallyEvent);
  }

  final PaymentCardRepository repository;

  FutureOr<void> _onGetPaymentManuallyEvent(
    GetPaymentCardEvent event,
    Emitter<PaymentCardState> emit,
  ) async {
    // update status to loading
    emit(PaymentCardLoading());

    // emit values received from event
    try {
      final result = await repository.requestPerformPaymentManually(
          requestMap: event.requestMap);

      emit(PaymentCardLoaded(paymentCardResponseModel: result));

      // incase error through exception with error state
    } on Exception catch (e) {
      emit(PaymentCardError(errorMessage: '$e'));
    }
  }
}
