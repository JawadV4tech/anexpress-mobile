import 'dart:async';

import 'package:anexpress/features/services_feature/data/service_info_model.dart';
import 'package:anexpress/features/services_feature/data/services_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc({required this.repository}) : super(ServicesInitial()) {
    on<ServicesGetEvent>(_onServicesGetEvent);
    on<ServicesResetEvent>(_onServicesResetEvent);
  }

  final ServicesRepository repository;
  FutureOr<void> _onServicesGetEvent(
      ServicesGetEvent event, Emitter<ServicesState> emit) async {
    try {
      emit(ServicesLoading());

      final servicesData = await repository.requestGetServicesData();

      emit(ServicesLoaded(services: servicesData));
    } on Exception catch (e) {
      emit(ServicesError(errorMessage: e.toString()));
    }
  }

  void _onServicesResetEvent(
      ServicesResetEvent event, Emitter<ServicesState> emit) {
    emit(ServicesInitial());
  }
}
