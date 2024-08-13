import 'dart:async';

import 'package:anexpress/features/banks_feature/data/bank_info_model.dart';
import 'package:anexpress/features/banks_feature/data/banks_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'banks_event.dart';
part 'banks_state.dart';

class BanksBloc extends Bloc<BanksEvent, BanksState> {
  BanksBloc({required this.repository}) : super(BanksInitial()) {
    on<BanksGetEvent>(_onBanksGetEvent);
    on<BanksResetEvent>(_onBanksResetEvent);
  }

  final BanksRepository repository;
  FutureOr<void> _onBanksGetEvent(
      BanksGetEvent event, Emitter<BanksState> emit) async {
    try {
      emit(BanksLoading());

      final banksData = await repository.requestGetBanksData(
          receiveCountryId: event.receiveCountryId);

      emit(BanksLoaded(banks: banksData));
    } on Exception catch (e) {
      emit(BanksError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onBanksResetEvent(
      BanksResetEvent event, Emitter<BanksState> emit) {
    emit(BanksInitial());
  }
}
