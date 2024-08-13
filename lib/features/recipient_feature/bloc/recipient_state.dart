part of 'recipient_bloc.dart';

abstract class RecipientState extends Equatable {}

class RecipientInitial extends RecipientState {
  @override
  List<Object> get props => [];
}

class RecipientLoading extends RecipientState {
  @override
  List<Object> get props => [];
}

class RecipientLoaded extends RecipientState {
  final SendMoneyRecipientModel sendMoneyRecipientModel;

  RecipientLoaded({required this.sendMoneyRecipientModel});

  @override
  List<Object> get props => [sendMoneyRecipientModel];
}

class RecipientError extends RecipientState {
  final String errorMessage;

  RecipientError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
