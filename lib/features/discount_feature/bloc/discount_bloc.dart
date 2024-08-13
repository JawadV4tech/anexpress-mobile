import 'dart:async';

import 'package:anexpress/features/discount_feature/data/discount_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  DiscountBloc({required this.repository}) : super(DiscountInitial()) {
    on<GetDiscountEvent>(_onGetDiscountEvent);
    //DiscountResetEvent
    on<DiscountResetEvent>(_onDiscountResetEvent);
  }

  final DiscountRepository repository;

  FutureOr<void> _onGetDiscountEvent(
      GetDiscountEvent event, Emitter<DiscountState> emit) async {
    // update status to loading
    emit(DiscountLoading());

    // emit values received from event
    try {
      final result = await repository.requestGetDiscountData(
          requestMap: event.requestMap, apiUrl: event.apiUrl);

      emit(DiscountLoaded(
          discount: result,
          isPromo: event.apiUrl.contains('promo') ? true : false));

      // incase error through exception with error state
    } on Exception catch (e) {
      emit(DiscountError(errorMessage: '$e'));
    }
  }

  FutureOr<void> _onDiscountResetEvent(
      DiscountResetEvent event, Emitter<DiscountState> emit) {
    emit(DiscountInitial());
  }
}
