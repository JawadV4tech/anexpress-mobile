import 'dart:async';

import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/config/pref_keys.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/features/two_fa_able_feature/data/two_fa_able_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'two_fa_able_event.dart';
part 'two_fa_able_state.dart';

class TwoFAableBloc extends Bloc<TwoFAableEvent, TwoFAableState> {
  TwoFAableBloc({required this.repository}) : super(TwoFAInitial()) {
    on<TwoFaAblePostEvent>(_onPrivacyGetEvent);
  }

  final TwoFAableRepository repository;

  final SharedPreferencesHelpers _sharedPrefKeys =
      locator<SharedPreferencesHelpers>();

  FutureOr<void> _onPrivacyGetEvent(
    TwoFaAblePostEvent event,
    Emitter<TwoFAableState> emit,
  ) async {
    try {
      emit(TwoFAableLoading());

      final result = await repository.requestGet2FAData(
        requestValueMap: event.requestValueMap,
        apiEndpoint: event.apiEndPoint,
      );

      // Save Status in Shared Preferences
      if (result.contains('enabled')) {
        _sharedPrefKeys.setIntData(key: PrefKeys.tempTwoFaStatusPrefKey, id: 1);
      } else {
        _sharedPrefKeys.setIntData(key: PrefKeys.tempTwoFaStatusPrefKey, id: 0);
      }

      emit(TwoFAableLoaded(result: result));
    } on Exception catch (e) {
      emit(TwoFAableError(errorMessage: e.toString()));
    }
  }
}
