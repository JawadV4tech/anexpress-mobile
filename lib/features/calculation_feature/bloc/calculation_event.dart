part of 'calculation_bloc.dart';

abstract class CalculationEvent extends Equatable {
  const CalculationEvent();

  @override
  List<Object> get props => [];
}

class GetCalculationEvent extends CalculationEvent {
  final Map<String, dynamic> requestMap;

  const GetCalculationEvent({required this.requestMap});

  @override
  List<Object> get props => [requestMap];
}

class CalculationResetEvent extends CalculationEvent {
  const CalculationResetEvent();

  @override
  List<Object> get props => [];
}
