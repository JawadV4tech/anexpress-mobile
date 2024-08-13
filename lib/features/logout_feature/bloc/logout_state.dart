part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();
}

class LogoutInitial extends LogoutState {
  @override
  List<Object?> get props => [];
}

class LogoutLoading extends LogoutState {
  @override
  List<Object?> get props => [];
}

class LogoutLoaded extends LogoutState {
  final bool isLoggedOut;
  final String message;

  const LogoutLoaded({required this.isLoggedOut, required this.message});

  @override
  List<Object> get props => [isLoggedOut, message];
}

class LogoutError extends LogoutState {
  final String errorMessage;
  const LogoutError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
