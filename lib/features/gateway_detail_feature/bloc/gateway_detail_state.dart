part of 'gateway_detail_bloc.dart';

sealed class GatewayDetailState extends Equatable {
  const GatewayDetailState();
}

final class GatewayDetailInitial extends GatewayDetailState {
  @override
  List<Object> get props => [];
}

final class GatewayDetailLoading extends GatewayDetailState {
  @override
  List<Object> get props => [];
}

final class GatewayDetailLoaded extends GatewayDetailState {
  final GatewayDetailModel gatewayDetailModel;
  final String gatewayCode;

  const GatewayDetailLoaded(
      {required this.gatewayDetailModel, required this.gatewayCode});

  @override
  List<Object> get props => [gatewayDetailModel, gatewayCode];
}

final class GatewayDetailError extends GatewayDetailState {
  final String errorMessage;

  const GatewayDetailError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
