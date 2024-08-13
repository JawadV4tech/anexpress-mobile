part of 'payment_manually_bloc.dart';

sealed class PaymentManuallyEvent extends Equatable {
  const PaymentManuallyEvent();

  @override
  List<Object> get props => [];
}

class GetPaymentManuallyEvent extends PaymentManuallyEvent {
  final Map<String, dynamic> requestMap;

  const GetPaymentManuallyEvent({required this.requestMap});

  @override
  List<Object> get props => [requestMap];
}
