part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactLoaded extends ContactState {
  final String successMessage;

  const ContactLoaded({
    required this.successMessage,
  });

  @override
  List<Object> get props => [successMessage];
}

class ContactError extends ContactState {
  final String errorMessage;

  const ContactError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
