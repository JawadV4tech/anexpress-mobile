part of 'send_money_data_bloc.dart';

sealed class SendMoneyDataEvent extends Equatable {
  const SendMoneyDataEvent();

  @override
  List<Object> get props => [];
}

class GetSendMoneyDataEvent extends SendMoneyDataEvent {
  final Map<String, dynamic> requestMap;

  const GetSendMoneyDataEvent({required this.requestMap});

  @override
  List<Object> get props => [requestMap];
}
