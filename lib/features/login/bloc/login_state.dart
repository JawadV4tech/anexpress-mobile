part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoaded extends LoginState {
  final UserInfoModel userInfo;

  LoginLoaded({
    required this.userInfo,
  });

  @override
  List<Object?> get props => [userInfo];
}

class LoginError extends LoginState {
  final String errorMessage;
  LoginError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
