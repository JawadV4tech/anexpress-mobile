import 'dart:async';

import 'package:anexpress/features/privacy_policy_screen/data/privacy_repository.dart';
import 'package:anexpress/features/privacy_policy_screen/data/privacy_terms_conditions_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'privacy_event.dart';
part 'privacy_state.dart';

class PrivacyBloc extends Bloc<PrivacyEvent, PrivacyState> {
  PrivacyBloc({required this.repository}) : super(PrivacyInitial()) {
    on<PrivacyGetEvent>(_onPrivacyGetEvent);
  }

  final PrivacyRepository repository;
  FutureOr<void> _onPrivacyGetEvent(
      PrivacyGetEvent event, Emitter<PrivacyState> emit) async {
    try {
      
      emit(PrivacyLoading());

      final privacyData = await repository.requestGetPrivacyData();

      emit(PrivacyLoaded(privacy: privacyData));
    } on Exception catch (e) {
      emit(PrivacyError(errorMessage: e.toString()));
    }
  }
}
