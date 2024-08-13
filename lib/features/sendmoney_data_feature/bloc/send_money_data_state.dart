part of 'send_money_data_bloc.dart';

sealed class SendMoneyDataState extends Equatable {
  const SendMoneyDataState();
}

final class SendMoneyDataInitial extends SendMoneyDataState {
  @override
  List<Object> get props => [];
}

class SendMoneyDataLoading extends SendMoneyDataState {
  @override
  List<Object> get props => [];
}

class SendMoneyDataLoaded extends SendMoneyDataState {
  final int invoiceId;

  const SendMoneyDataLoaded({
    required this.invoiceId,
  });

  @override
  List<Object?> get props => [invoiceId];
}

class SendMoneyDataError extends SendMoneyDataState {
  final String errorMessage;
  const SendMoneyDataError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
