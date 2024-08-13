part of 'send_money_bloc.dart';

enum SendMoneyStatus { initial, success, error, loading }

extension SendMoneyStatusX on SendMoneyStatus {
  bool get isInitial => this == SendMoneyStatus.initial;
  bool get isSuccess => this == SendMoneyStatus.success;
  bool get isError => this == SendMoneyStatus.error;
  bool get isLoading => this == SendMoneyStatus.loading;
}

class SendMoneyState extends Equatable {
  final SendMoneyStatus status;
  final String message;
  final int activeTabIndex;
  final CountryInfoModel sendFromCountryInfo;
  final CountryInfoModel sendToCountryInfo;
  final ServiceInfoModel serviceInfo;
  final BankInfoModel bankInfo;
  final BankBranchInfoModel branchInfo;
  final CalculationInfoModel calculationInfo;
  final String sendOrReceive;
  final StoreCalculationModel storeCalculationModel;
  final double promoCodeDiscount;
  final double referralCodeDiscount;
  final SearchUserDataModel searchUserData;

  const SendMoneyState({
    this.status = SendMoneyStatus.initial,
    this.message = "",
    this.activeTabIndex = 0,
    CountryInfoModel? sendFromCountryInfo,
    CountryInfoModel? sendToCountryInfo,
    ServiceInfoModel? serviceInfo,
    BankInfoModel? bankInfo,
    BankBranchInfoModel? branchInfo,
    CalculationInfoModel? calculationInfo,
    this.sendOrReceive = "send",
    StoreCalculationModel? storeCalculationModel,
    this.promoCodeDiscount = 0,
    this.referralCodeDiscount = 0,
    SearchUserDataModel? searchUserData,
  })  : sendFromCountryInfo = sendFromCountryInfo ?? const CountryInfoModel(),
        sendToCountryInfo = sendToCountryInfo ?? const CountryInfoModel(),
        serviceInfo = serviceInfo ?? const ServiceInfoModel(),
        bankInfo = bankInfo ?? const BankInfoModel(),
        branchInfo = branchInfo ?? const BankBranchInfoModel(),
        calculationInfo = calculationInfo ?? const CalculationInfoModel(),
        storeCalculationModel =
            storeCalculationModel ?? const StoreCalculationModel(),
        searchUserData = searchUserData ?? const SearchUserDataModel();

  @override
  List<Object?> get props => [
        status,
        message,
        activeTabIndex,
        sendFromCountryInfo,
        sendToCountryInfo,
        serviceInfo,
        bankInfo,
        branchInfo,
        calculationInfo,
        sendOrReceive,
        storeCalculationModel,
        promoCodeDiscount,
        referralCodeDiscount,
        searchUserData
      ];

  SendMoneyState copyWith({
    SendMoneyStatus? status,
    String? message,
    int? activeTabIndex,
    CountryInfoModel? sendFromCountryInfo,
    CountryInfoModel? sendToCountryInfo,
    ServiceInfoModel? serviceInfo,
    BankInfoModel? bankInfo,
    BankBranchInfoModel? branchInfo,
    CalculationInfoModel? calculationInfo,
    String? sendOrReceive,
    StoreCalculationModel? storeCalculationModel,
    double? promoCodeDiscount,
    double? referralCodeDiscount,
    SearchUserDataModel? searchUserData,
  }) {
    return SendMoneyState(
      status: status ?? this.status,
      message: message ?? this.message,
      activeTabIndex: activeTabIndex ?? this.activeTabIndex,
      sendFromCountryInfo: sendFromCountryInfo ?? this.sendFromCountryInfo,
      sendToCountryInfo: sendToCountryInfo ?? this.sendToCountryInfo,
      serviceInfo: serviceInfo ?? this.serviceInfo,
      bankInfo: bankInfo ?? this.bankInfo,
      branchInfo: branchInfo ?? this.branchInfo,
      calculationInfo: calculationInfo ?? this.calculationInfo,
      sendOrReceive: sendOrReceive ?? this.sendOrReceive,
      storeCalculationModel:
          storeCalculationModel ?? this.storeCalculationModel,
      promoCodeDiscount: promoCodeDiscount ?? this.promoCodeDiscount,
      referralCodeDiscount: referralCodeDiscount ?? this.referralCodeDiscount,
      searchUserData: searchUserData ?? this.searchUserData,
    );
  }
}
