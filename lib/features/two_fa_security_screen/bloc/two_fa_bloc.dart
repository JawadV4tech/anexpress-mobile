import 'dart:async';

import 'package:anexpress/features/two_fa_security_screen/data/two_fa_info_model.dart';
import 'package:anexpress/features/two_fa_security_screen/data/two_fa_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'two_fa_event.dart';
part 'two_fa_state.dart';

class TwoFABloc extends Bloc<TwoFAEvent, TwoFAState> {
  TwoFABloc({required this.repository}) : super(TwoFAInitial()) {
    on<TwoFAGetEvent>(_onPrivacyGetEvent);
  }

  final TwoFARepository repository;
  FutureOr<void> _onPrivacyGetEvent(
      TwoFAGetEvent event, Emitter<TwoFAState> emit) async {
    try {
      emit(TwoFALoading());

      final result = await repository.requestGet2FAData();

      emit(TwoFALoaded(twoInfoData: result));
    } on Exception catch (e) {
      emit(TwoFAError(errorMessage: e.toString()));
    }
  }
}
