import 'dart:async';

import 'package:anexpress/features/sendmoney_data_feature/data/send_money_data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'send_money_data_event.dart';
part 'send_money_data_state.dart';

class SendMoneyDataBloc extends Bloc<SendMoneyDataEvent, SendMoneyDataState> {
  SendMoneyDataBloc({required this.repository})
      : super(SendMoneyDataInitial()) {
    on<GetSendMoneyDataEvent>(_onGetSendMoneyDataEvent);
  }

  final SendMoneyDataRepository repository;

  FutureOr<void> _onGetSendMoneyDataEvent(
    GetSendMoneyDataEvent event,
    Emitter<SendMoneyDataState> emit,
  ) async {
    // update status to loading
    emit(SendMoneyDataLoading());

    // emit values received from event
    try {
      final result = await repository.requestGetSendMoneyData(
          requestMap: event.requestMap);

      emit(SendMoneyDataLoaded(invoiceId: result));

      // incase error through exception with error state
    } on Exception catch (e) {
      emit(SendMoneyDataError(errorMessage: '$e'));
    }
  }
}
