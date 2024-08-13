import 'dart:async';

import 'package:anexpress/features/recipient_feature/data/recipient_repository.dart';
import 'package:anexpress/features/recipient_feature/data/send_money_recipient_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recipient_event.dart';
part 'recipient_state.dart';

class RecipientBloc extends Bloc<RecipientEvent, RecipientState> {
  RecipientBloc({required this.repository}) : super(RecipientInitial()) {
    on<GetSendMoneyRecipientEvent>(_onGetSendMoneyRecipientEvent);
  }

  final RecipientRepository repository;

  FutureOr<void> _onGetSendMoneyRecipientEvent(
    GetSendMoneyRecipientEvent event,
    Emitter<RecipientState> emit,
  ) async {
    // update status to loading
    emit(RecipientLoading());

    // emit values received from event
    try {
      final result = await repository.requestGetRecipientData(id: event.id);

      emit(RecipientLoaded(sendMoneyRecipientModel: result));

      // incase error through exception with error state
    } on Exception catch (e) {
      emit(RecipientError(errorMessage: '$e'));
    }
  }
}
