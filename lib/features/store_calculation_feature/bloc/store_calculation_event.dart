part of 'store_calculation_bloc.dart';

sealed class StoreCalculationEvent extends Equatable {
  const StoreCalculationEvent();

  @override
  List<Object> get props => [];
}

class GetStoreCalculationEvent extends StoreCalculationEvent {
  final Map<String, dynamic> requestMap;

  const GetStoreCalculationEvent({required this.requestMap});

  @override
  List<Object> get props => [requestMap];
}

class StoreCalculationResetEvent extends StoreCalculationEvent {
  const StoreCalculationResetEvent();

  @override
  List<Object> get props => [];
}
