import 'package:anexpress/features/calculation_feature/data/calculation_repository.dart';
import 'package:anexpress/features/calculation_feature/data/calculation_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calculation_event.dart';
part 'calculation_state.dart';

class CalculationBloc extends Bloc<CalculationEvent, CalculationState> {
  CalculationBloc({required this.repository}) : super(CalculationInitial()) {
    on<GetCalculationEvent>(_onGetCalculationEvent);
    on<CalculationResetEvent>(_onCalculationResetEvent);

    //
  }

  final CalculationRepository repository;

  void _onGetCalculationEvent(
      GetCalculationEvent event, Emitter<CalculationState> emit) async {
    // update status to loading
    emit(CalculationLoading());

    // emit values received from event
    try {
      final result = await repository.requestGetCalculationEvent(
          requestValueMap: event.requestMap);

      emit(CalculationLoaded(calculationResponseModel: result));

      // incase error through exception with error state
    } on Exception catch (e) {
      emit(CalculationError(errorMessage: '$e'));
    }
  }

  void _onCalculationResetEvent(
      CalculationResetEvent event, Emitter<CalculationState> emit) {
    emit(CalculationInitial());
  }
}
