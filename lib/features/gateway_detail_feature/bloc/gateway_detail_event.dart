part of 'gateway_detail_bloc.dart';

sealed class GatewayDetailEvent extends Equatable {
  const GatewayDetailEvent();

  @override
  List<Object> get props => [];
}

class GatewayDetailGetEvent extends GatewayDetailEvent {
  final Map<String, dynamic> requestMap;
  final String gatewayCode;

  const GatewayDetailGetEvent({
    required this.requestMap,
    required this.gatewayCode,
  });

  @override
  List<Object> get props => [requestMap, gatewayCode];
}
