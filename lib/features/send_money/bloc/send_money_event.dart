part of 'send_money_bloc.dart';

abstract class SendMoneyEvent extends Equatable {
  const SendMoneyEvent();

  @override
  List<Object> get props => [];
}

class UpdateTabEvent extends SendMoneyEvent {
  final int activeTabIndex;

  const UpdateTabEvent({
    required this.activeTabIndex,
  });

  @override
  List<Object> get props => [activeTabIndex];
}

class UpdateFromCountryEvent extends SendMoneyEvent {
  final CountryInfoModel sendFromCountryInfo;

  const UpdateFromCountryEvent({
    required this.sendFromCountryInfo,
  });

  @override
  List<Object> get props => [sendFromCountryInfo];
}

class UpdateToCountryEvent extends SendMoneyEvent {
  final CountryInfoModel sendToCountryInfo;

  const UpdateToCountryEvent({
    required this.sendToCountryInfo,
  });

  @override
  List<Object> get props => [sendToCountryInfo];
}

class UpdateServiceEvent extends SendMoneyEvent {
  final ServiceInfoModel serviceInfo;

  const UpdateServiceEvent({
    required this.serviceInfo,
  });

  @override
  List<Object> get props => [serviceInfo];
}

class UpdateBankEvent extends SendMoneyEvent {
  final BankInfoModel bankInfo;

  const UpdateBankEvent({
    required this.bankInfo,
  });

  @override
  List<Object> get props => [bankInfo];
}

class UpdateBranchEvent extends SendMoneyEvent {
  final BankBranchInfoModel branchInfo;

  const UpdateBranchEvent({
    required this.branchInfo,
  });

  @override
  List<Object> get props => [branchInfo];
}

class UpdateCalculationEvent extends SendMoneyEvent {
  final CalculationInfoModel calculationInfo;

  const UpdateCalculationEvent({
    required this.calculationInfo,
  });

  @override
  List<Object> get props => [calculationInfo];
}

class UpdateStoreCalculationEvent extends SendMoneyEvent {
  final StoreCalculationModel storeCalculationModel;

  const UpdateStoreCalculationEvent({
    required this.storeCalculationModel,
  });

  @override
  List<Object> get props => [storeCalculationModel];
}

class UpdatePromoDiscountEvent extends SendMoneyEvent {
  final double discount;

  const UpdatePromoDiscountEvent({
    required this.discount,
  });

  @override
  List<Object> get props => [discount];
}

class UpdateReferralDiscountEvent extends SendMoneyEvent {
  final double discount;

  const UpdateReferralDiscountEvent({
    required this.discount,
  });

  @override
  List<Object> get props => [discount];
}

class UpdateSearchedUserDataEvent extends SendMoneyEvent {
  final SearchUserDataModel searchUserData;

  const UpdateSearchedUserDataEvent({
    required this.searchUserData,
  });

  @override
  List<Object> get props => [searchUserData];
}

class ClearSearchedUserDataEvent extends SendMoneyEvent {
  const ClearSearchedUserDataEvent();

  @override
  List<Object> get props => [];
}
