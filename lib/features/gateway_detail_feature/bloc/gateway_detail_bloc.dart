import 'dart:async';

import 'package:anexpress/features/gateway_detail_feature/data/gateway_detail_model.dart';
import 'package:anexpress/features/gateway_detail_feature/data/gateway_detail_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'gateway_detail_event.dart';
part 'gateway_detail_state.dart';

class GatewayDetailBloc extends Bloc<GatewayDetailEvent, GatewayDetailState> {
  GatewayDetailBloc({required this.repository})
      : super(GatewayDetailInitial()) {
    on<GatewayDetailGetEvent>(_onGatewayDetailGetEvent);
  }

  final GateWayDetailRepository repository;

  FutureOr<void> _onGatewayDetailGetEvent(
    GatewayDetailGetEvent event,
    Emitter<GatewayDetailState> emit,
  ) async {
    emit(GatewayDetailLoading());

    try {
      final data = await repository.requestGetGatewayDetailData(
          requestMap: event.requestMap);

      emit(GatewayDetailLoaded(
        gatewayDetailModel: data,
        gatewayCode: event.gatewayCode,
      ));
    } on Exception catch (e) {
      emit(GatewayDetailError(errorMessage: e.toString()));
    }
  }
}
