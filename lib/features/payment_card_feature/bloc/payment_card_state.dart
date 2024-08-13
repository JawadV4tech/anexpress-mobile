part of 'payment_card_bloc.dart';

sealed class PaymentCardState extends Equatable {
  const PaymentCardState();
}

final class PaymentCardInitial extends PaymentCardState {
  @override
  List<Object> get props => [];
}

class PaymentCardLoading extends PaymentCardState {
  @override
  List<Object> get props => [];
}

class PaymentCardLoaded extends PaymentCardState {
  final PaymentCardResponseModel paymentCardResponseModel;

  const PaymentCardLoaded({
    required this.paymentCardResponseModel,
  });

  @override
  List<Object?> get props => [paymentCardResponseModel];
}

class PaymentCardError extends PaymentCardState {
  final String errorMessage;
  const PaymentCardError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
