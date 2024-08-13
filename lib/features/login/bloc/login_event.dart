part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PerformUserLogin extends LoginEvent {
  final Map<String, dynamic> requestValueMap;
  final String apiEndPoint;

  const PerformUserLogin({
    required this.requestValueMap,
    required this.apiEndPoint,
  });

  @override
  List<Object> get props => [requestValueMap, apiEndPoint];
}
