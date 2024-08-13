part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class PerformUserRegister extends RegisterEvent {
  final Map<String, dynamic> requestValueMap;

  const PerformUserRegister({
    required this.requestValueMap,
  });

  @override
  List<Object> get props => [requestValueMap];
}
