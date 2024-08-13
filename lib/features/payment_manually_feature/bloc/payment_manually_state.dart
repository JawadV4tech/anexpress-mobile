part of 'payment_manually_bloc.dart';

sealed class PaymentManuallyState extends Equatable {
  const PaymentManuallyState();
}

final class PaymentManuallyInitial extends PaymentManuallyState {
  @override
  List<Object> get props => [];
}

class PaymentManuallyLoading extends PaymentManuallyState {
  @override
  List<Object> get props => [];
}

class PaymentManuallyLoaded extends PaymentManuallyState {
  final String message;

  const PaymentManuallyLoaded({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class PaymentManuallyError extends PaymentManuallyState {
  final String errorMessage;
  const PaymentManuallyError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
