part of 'logout_bloc.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

class PerformUserLogout extends LogoutEvent {
  const PerformUserLogout();

  @override
  List<Object> get props => [];
}
