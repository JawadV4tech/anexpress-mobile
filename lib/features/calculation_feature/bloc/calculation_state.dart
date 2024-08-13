part of 'calculation_bloc.dart';

abstract class CalculationState extends Equatable {
  const CalculationState();
}

class CalculationInitial extends CalculationState {
  @override
  List<Object> get props => [];
}

class CalculationLoading extends CalculationState {
  @override
  List<Object> get props => [];
}

class CalculationLoaded extends CalculationState {
  final CalculationInfoModel calculationResponseModel;

  const CalculationLoaded({
    required this.calculationResponseModel,
  });

  @override
  List<Object?> get props => [calculationResponseModel];
}

class CalculationError extends CalculationState {
  final String errorMessage;
  const CalculationError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
