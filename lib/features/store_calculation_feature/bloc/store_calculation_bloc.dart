import 'dart:async';

import 'package:anexpress/features/store_calculation_feature/data/store_calculation_model.dart';
import 'package:anexpress/features/store_calculation_feature/data/store_calculation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'store_calculation_event.dart';
part 'store_calculation_state.dart';

class StoreCalculationBloc
    extends Bloc<StoreCalculationEvent, StoreCalculationState> {
  StoreCalculationBloc({required this.repository})
      : super(StoreCalculationInitial()) {
    on<GetStoreCalculationEvent>(_onGetStoreCalculationEvent);
    on<StoreCalculationResetEvent>(_onStoreCalculationResetEvent);
  }

  final StoreCalculationRepository repository;

  FutureOr<void> _onGetStoreCalculationEvent(GetStoreCalculationEvent event,
      Emitter<StoreCalculationState> emit) async {
    // update status to loading
    emit(StoreCalculationLoading());

    // emit values received from event
    try {
      final result = await repository.requestGetStoreCalcData(
          requestMap: event.requestMap);

      emit(StoreCalculationLoaded(storeCalculationModel: result));

      // incase error through exception with error state
    } on Exception catch (e) {
      emit(StoreCalculationError(errorMessage: '$e'));
    }
  }

  FutureOr<void> _onStoreCalculationResetEvent(
      StoreCalculationResetEvent event, Emitter<StoreCalculationState> emit) {
    emit(StoreCalculationInitial());
  }
}
