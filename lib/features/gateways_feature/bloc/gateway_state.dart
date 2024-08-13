part of 'gateway_bloc.dart';

sealed class GatewayState extends Equatable {
  const GatewayState();
}

final class GatewayInitial extends GatewayState {
  @override
  List<Object> get props => [];
}

final class GatewayLoading extends GatewayState {
  @override
  List<Object> get props => [];
}

final class GatewayLoaded extends GatewayState {
  final GatewaysModel gatewaysModel;

  const GatewayLoaded({required this.gatewaysModel});

  @override
  List<Object> get props => [gatewaysModel];
}

final class GatewayError extends GatewayState {
  final String errorMessage;

  const GatewayError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
