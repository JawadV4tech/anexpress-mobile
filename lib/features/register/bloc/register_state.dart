part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {}

class RegisterInitial extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterLoading extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterLoaded extends RegisterState {
  final String token;
  final bool isRegister;

  RegisterLoaded({
    required this.token,
    required this.isRegister,
  });

  @override
  List<Object?> get props => [token, isRegister];
}

class RegisterError extends RegisterState {
  final String errorMessage;
  RegisterError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
