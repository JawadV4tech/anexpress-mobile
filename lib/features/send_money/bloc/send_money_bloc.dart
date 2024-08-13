import 'dart:async';

import 'package:anexpress/features/banks_feature/data/bank_info_model.dart';
import 'package:anexpress/features/branches_feature/data/bank_branch_info_model.dart';
import 'package:anexpress/features/calculation_feature/data/calculation_response_model.dart';
import 'package:anexpress/features/countries_feature/data/country_info_model.dart';
import 'package:anexpress/features/services_feature/data/service_info_model.dart';
import 'package:anexpress/features/store_calculation_feature/data/store_calculation_model.dart';
import 'package:anexpress/features/user_data_feature/data/search_user_data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'send_money_event.dart';
part 'send_money_state.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  SendMoneyBloc() : super(const SendMoneyState()) {
    //UpdateTabEvent
    on<UpdateTabEvent>(_onLoadToFromEventEvent);
    //UpdateFromCountryEvent
    on<UpdateFromCountryEvent>(_onUpdateFromCountryEvent);
    //UpdateToCountryEvent
    on<UpdateToCountryEvent>(_onUpdateToCountryEvent);
    //UpdateServiceEvent
    on<UpdateServiceEvent>(_onUpdateServiceEvent);
    //UpdateBankEvent
    on<UpdateBankEvent>(_onUpdateBankEvent);
    //UpdateBranchEvent
    on<UpdateBranchEvent>(_onUpdateBranchEvent);
    //UpdateCalculationEvent
    on<UpdateCalculationEvent>(_onUpdateCalculationEvent);
    //UpdateStoreCalculationEvent
    on<UpdateStoreCalculationEvent>(_onUpdateStoreCalculationEvent);
    //UpdatePromoDiscountEvent
    on<UpdatePromoDiscountEvent>(_onUpdatePromoDiscountEvent);
    //UpdateReferralDiscountEvent
    on<UpdateReferralDiscountEvent>(_onUpdateReferralDiscountEvent);
    //UpdateUserDataEvent
    on<UpdateSearchedUserDataEvent>(_onUpdateUserDataEvent);
    //ClearSearchedUserDataEvent
    on<ClearSearchedUserDataEvent>(_onClearSearchedUserDataEvent);
  }

  void _onLoadToFromEventEvent(
      UpdateTabEvent event, Emitter<SendMoneyState> emit) {
    emit(
      state.copyWith(
        status: SendMoneyStatus.success,
        activeTabIndex: event.activeTabIndex,
      ),
    );
  }

  void _onUpdateFromCountryEvent(
    UpdateFromCountryEvent event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(state.copyWith(
      status: SendMoneyStatus.success,
      sendFromCountryInfo: event.sendFromCountryInfo,
    ));
  }

  void _onUpdateToCountryEvent(
    UpdateToCountryEvent event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(state.copyWith(
      status: SendMoneyStatus.success,
      sendToCountryInfo: event.sendToCountryInfo,
    ));
  }

  FutureOr<void> _onUpdateServiceEvent(
      UpdateServiceEvent event, Emitter<SendMoneyState> emit) {
    emit(state.copyWith(
      status: SendMoneyStatus.success,
      serviceInfo: event.serviceInfo,
    ));
  }

  FutureOr<void> _onUpdateBankEvent(
    UpdateBankEvent event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(state.copyWith(
      status: SendMoneyStatus.success,
      bankInfo: event.bankInfo,
    ));
  }

  FutureOr<void> _onUpdateBranchEvent(
      UpdateBranchEvent event, Emitter<SendMoneyState> emit) {
    emit(state.copyWith(
      status: SendMoneyStatus.success,
      branchInfo: event.branchInfo,
    ));
  }

  FutureOr<void> _onUpdateCalculationEvent(
    UpdateCalculationEvent event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(state.copyWith(
      status: SendMoneyStatus.success,
      calculationInfo: event.calculationInfo,
    ));
  }

  FutureOr<void> _onUpdateStoreCalculationEvent(
    UpdateStoreCalculationEvent event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(state.copyWith(
      status: SendMoneyStatus.success,
      storeCalculationModel: event.storeCalculationModel,
    ));
  }

  FutureOr<void> _onUpdatePromoDiscountEvent(
    UpdatePromoDiscountEvent event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(state.copyWith(
      status: SendMoneyStatus.success,
      promoCodeDiscount: event.discount,
    ));
  }

  FutureOr<void> _onUpdateReferralDiscountEvent(
    UpdateReferralDiscountEvent event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(state.copyWith(
      status: SendMoneyStatus.success,
      referralCodeDiscount: event.discount,
    ));
  }

  FutureOr<void> _onUpdateUserDataEvent(
      UpdateSearchedUserDataEvent event, Emitter<SendMoneyState> emit) {
    emit(state.copyWith(
      status: SendMoneyStatus.success,
      searchUserData: event.searchUserData,
    ));
  }

  FutureOr<void> _onClearSearchedUserDataEvent(
      ClearSearchedUserDataEvent event, Emitter<SendMoneyState> emit) {
    emit(state.copyWith(
      status: SendMoneyStatus.success,
      searchUserData: const SearchUserDataModel(),
    ));
  }
}
