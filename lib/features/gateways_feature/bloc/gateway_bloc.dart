import 'dart:async';

import 'package:anexpress/features/gateways_feature/data/gateways_model.dart';
import 'package:anexpress/features/gateways_feature/data/gateways_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gateway_event.dart';
part 'gateway_state.dart';

class GatewayBloc extends Bloc<GatewayEvent, GatewayState> {
  GatewayBloc({required this.repository}) : super(GatewayInitial()) {
    on<GatewaysGetEvent>(_onGatewaysGetEvent);
  }

  final GateWaysRepository repository;

  FutureOr<void> _onGatewaysGetEvent(
      GatewaysGetEvent event, Emitter<GatewayState> emit) async {
    //
    emit(GatewayLoading());

    try {
      final data = await repository.requestGetGatewaysData();

      emit(GatewayLoaded(gatewaysModel: data));
    } on Exception catch (e) {
      emit(GatewayError(errorMessage: e.toString()));
    }
  }
}
