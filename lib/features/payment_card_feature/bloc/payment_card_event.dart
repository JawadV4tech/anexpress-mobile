part of 'payment_card_bloc.dart';

sealed class PaymentCardEvent extends Equatable {
  const PaymentCardEvent();

  @override
  List<Object> get props => [];
}

class GetPaymentCardEvent extends PaymentCardEvent {
  final Map<String, dynamic> requestMap;

  const GetPaymentCardEvent({required this.requestMap});

  @override
  List<Object> get props => [requestMap];
}
