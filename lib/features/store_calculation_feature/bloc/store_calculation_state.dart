part of 'store_calculation_bloc.dart';

sealed class StoreCalculationState extends Equatable {
  const StoreCalculationState();
}

final class StoreCalculationInitial extends StoreCalculationState {
  @override
  List<Object> get props => [];
}

class StoreCalculationLoading extends StoreCalculationState {
  @override
  List<Object> get props => [];
}

class StoreCalculationLoaded extends StoreCalculationState {
  final StoreCalculationModel storeCalculationModel;

  const StoreCalculationLoaded({
    required this.storeCalculationModel,
  });

  @override
  List<Object?> get props => [storeCalculationModel];
}

class StoreCalculationError extends StoreCalculationState {
  final String errorMessage;
  const StoreCalculationError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
