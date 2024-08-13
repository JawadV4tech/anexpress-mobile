// ignore_for_file: use_build_context_synchronously

import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/banks_feature/bloc/banks_bloc.dart';
import 'package:anexpress/features/banks_feature/data/bank_info_model.dart';
import 'package:anexpress/features/branches_feature/bloc/branches_bloc.dart';
import 'package:anexpress/features/branches_feature/data/bank_branch_info_model.dart';
import 'package:anexpress/features/calculation_feature/bloc/calculation_bloc.dart';
import 'package:anexpress/features/countries_feature/data/country_info_model.dart';
import 'package:anexpress/features/send_money/bloc/send_money_bloc.dart';
import 'package:anexpress/features/send_money/view/components/banks_search.dart';
import 'package:anexpress/features/send_money/view/components/branches_search.dart';
import 'package:anexpress/features/send_money/view/components/calculation_value_list_tile.dart';
import 'package:anexpress/features/send_money/view/components/send_money_to_country_title.dart';
import 'package:anexpress/features/services_feature/bloc/services_bloc.dart';
import 'package:anexpress/features/store_calculation_feature/bloc/store_calculation_bloc.dart';
import 'package:anexpress/widgets/common_text_field_view.dart';
import 'package:anexpress/widgets/services_drop_down.dart';
import 'package:anexpress/widgets/text_18_semibold_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore_for_file: must_be_immutable
class ServiceBankBranchCalculationView extends StatefulWidget {
  const ServiceBankBranchCalculationView({
    super.key,
    required this.sendMoneyState,
  });

  final SendMoneyState sendMoneyState;

  @override
  State<ServiceBankBranchCalculationView> createState() =>
      _ServiceBankBranchCalculationViewState();
}

class _ServiceBankBranchCalculationViewState
    extends State<ServiceBankBranchCalculationView> {
  // final _dialogService = locator<DialogService>();
  bool isEnableNexStep = false;

  int selectedServiceId = 0;
  int selectedBankId = 0;
  int selectedBranchId = 0;
  String selectedBranchName = "";
  String selectedBankName = "";
  String _errorServiceSelection = "";
  String _errorBankSelection = "";
  String _errorBranchSelection = "";

  String _errorAmount = '';
  late TextEditingController _amountController;

  BankBranchInfoModel selectedBranchInfo = const BankBranchInfoModel();
  BankInfoModel selectedBankInfo = const BankInfoModel();

  @override
  void initState() {
    _amountController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme();
    return Container(
      width: double.maxFinite,
      padding: getPadding(left: 13, top: 0, right: 13, bottom: 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SendMoneyToCountryTitle(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // ========== Start  Service Selection
                // =================================
                BlocBuilder<ServicesBloc, ServicesState>(
                  builder: (context, servicesState) {
                    if (servicesState is ServicesLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(left: 4, top: 10, bottom: 5),
                            child: const Text20Medium("Select Service"),
                          ),
                          ServicesDropDown(
                            width: size.width,
                            focusNode: FocusNode(),
                            autofocus: true,
                            icon: Padding(
                                padding: getPadding(left: 21, right: 11),
                                child: CustomImageView(
                                  svgPath: LocalFiles.imgArrowdown,
                                )),
                            hintText: "Select Service",
                            margin: getMargin(top: 0),
                            services: servicesState.services,
                            onChanged: (selectedServiceValue) {
                              "value received $selectedServiceValue".log();
                              setState(() {
                                selectedServiceId = selectedServiceValue.id!;
                              });

                              // update serviceInfo state
                              context.read<SendMoneyBloc>().add(
                                    UpdateServiceEvent(
                                      serviceInfo: selectedServiceValue,
                                    ),
                                  );

                              final receiveCountryId =
                                  widget.sendMoneyState.sendToCountryInfo.id ??
                                      0;
                              // initialize  BanksGetEvent
                              context.read<BanksBloc>().add(BanksGetEvent(
                                  receiveCountryId: receiveCountryId));
                            },
                          ),
                          if (_errorServiceSelection != "")
                            RedErrorText(message: _errorServiceSelection),
                        ],
                      );
                    }

                    if (servicesState is ServicesError) {
                      return Center(
                        child: ErrorMessageWithRetryButton(
                          message: servicesState.errorMessage,
                          onTap: () {
                            // call the CountriesGetEvent
                            context
                                .read<ServicesBloc>()
                                .add(const ServicesGetEvent());
                          },
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),

                // ========== end  Services Selection
                // =================================

                // ========== Start  Bank Selection
                // =================================

                BlocBuilder<BanksBloc, BanksState>(
                  builder: (context, banksState) {
                    if (banksState is BanksLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(left: 4, top: 10),
                            child: const Text20Medium("Select Bank"),
                          ),
                          SelectOptionButton(
                            title: (selectedBankName != "")
                                ? selectedBankName
                                : "Select Bank",
                            onTap: () async {
                              final result = await showSearch(
                                context: context,
                                delegate: BanksSearch(banksState.banks),
                              );

                              if (result?.id != null) {
                                "search rec: $result".log();
                                "value received $result".log();
                                setState(() {
                                  selectedBankId = result!.id!;
                                  selectedBankInfo = result;
                                  selectedBankName = result.name ?? "";
                                });

                                setState(() {
                                  selectedBankId = result!.id!;
                                });

                                // update bankInfo state
                                context.read<SendMoneyBloc>().add(
                                      UpdateBankEvent(
                                        bankInfo: result!,
                                      ),
                                    );

                                context.read<BranchesBloc>().add(
                                    BranchesGetEvent(bankId: selectedBankId));
                              }
                            },
                          ),
                          // BanksDropDown(
                          //   width: size.width,
                          //   focusNode: FocusNode(),
                          //   autofocus: true,
                          //   icon: Container(
                          //       margin: getMargin(left: 21, right: 11),
                          //       child: CustomImageView(
                          //         svgPath: LocalFiles.imgArrowdown,
                          //       )),
                          //   hintText: "Select Bank",
                          //   margin: getMargin(top: 0),
                          //   items: banksState.banks,
                          //   onChanged: (selectedBankInfo) {
                          //     "value received $selectedBankInfo".log();
                          //     setState(() {
                          //       selectedBankId = selectedBankInfo.id!;
                          //     });

                          //     // update bankInfo state
                          //     context.read<SendMoneyBloc>().add(
                          //           UpdateBankEvent(
                          //             bankInfo: selectedBankInfo,
                          //           ),
                          //         );

                          //     context.read<BranchesBloc>().add(
                          //         BranchesGetEvent(bankId: selectedBankId));
                          //   },
                          // ),
                          if (_errorBankSelection != "")
                            RedErrorText(message: _errorBankSelection),
                        ],
                      );
                    }

                    if (banksState is BanksError) {
                      return Center(
                        child: ErrorMessageWithRetryButton(
                          message: banksState.errorMessage,
                          onTap: () {
                            final receiveCountryId =
                                widget.sendMoneyState.sendToCountryInfo.id ?? 0;
                            // call the CountriesGetEvent
                            context.read<BanksBloc>().add(BanksGetEvent(
                                receiveCountryId: receiveCountryId));
                          },
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),

                // ========== end  Bank Selection
                // =================================

                // ========== Start  Branch Selection
                // =================================

                BlocBuilder<BranchesBloc, BranchesState>(
                  builder: (context, branchesState) {
                    if (branchesState is BranchesLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: getPadding(left: 4, top: 10, bottom: 10),
                            child: const Text20Medium("Select Branch"),
                          ),
                          SelectOptionButton(
                            title: (selectedBranchName != "")
                                ? selectedBranchName
                                : "Select Branch",
                            onTap: () async {
                              final result = await showSearch(
                                context: context,
                                delegate:
                                    BranchesSearch(branchesState.branches),
                              );

                              if (result?.id != null) {
                                "search rec: $result".log();
                                "value received $result".log();
                                setState(() {
                                  selectedBranchId = result!.id!;
                                  selectedBranchInfo = result;
                                  selectedBranchName = result.name ?? "";
                                });

                                // update bankInfo state
                                context.read<SendMoneyBloc>().add(
                                      UpdateBranchEvent(
                                        branchInfo: result!,
                                      ),
                                    );
                              }
                            },
                          ),
                          // BranchesDropDown(
                          //   selectedBranch: selectedBranchId != 0
                          //       ? selectedBranchInfo
                          //       : null,
                          //   width: size.width,
                          //   focusNode: FocusNode(),
                          //   autofocus: true,
                          //   icon: Container(
                          //       margin: getMargin(left: 21, right: 11),
                          //       child: CustomImageView(
                          //         svgPath: LocalFiles.imgArrowdown,
                          //       )),
                          //   hintText: "Select Branch",
                          //   margin: getMargin(top: 0),
                          //   items: branchesState.branches,
                          //   onChanged: (branchInfo) {
                          //     "value received $branchInfo".log();
                          //     setState(() {
                          //       selectedBranchId = branchInfo.id!;
                          //       selectedBranchInfo = branchInfo;
                          //     });

                          //     // update bankInfo state
                          //     context.read<SendMoneyBloc>().add(
                          //           UpdateBranchEvent(
                          //             branchInfo: branchInfo,
                          //           ),
                          //         );
                          //   },
                          // ),
                          if (_errorBranchSelection != "" &&
                              selectedBankId == 0)
                            RedErrorText(message: _errorBranchSelection),
                          // "Enter Amount" inPutField
                          if (selectedBranchId != 0)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: getPadding(top: 10),
                                  child: const Text20Medium("Enter Amount"),
                                ),
                                Stack(
                                  children: [
                                    CommonTextFieldView(
                                      controller: _amountController,
                                      focusNode: FocusNode(),
                                      errorText: _errorAmount,
                                      labelText: "Enter Amount",
                                      keyboardType: TextInputType.number,
                                      onChanged: (String txt) {
                                        // reset the calculation state if amount is changed
                                        context.read<CalculationBloc>().add(
                                              const CalculationResetEvent(),
                                            );
                                      },
                                      textCapitalization:
                                          TextCapitalization.none,
                                    ),
                                    // const Positioned(
                                    //   right: 10,
                                    //   top: 18,
                                    //   child: Text18SemiBold("GBP"),
                                    // )
                                  ],
                                ),
                              ],
                            ),
                        ],
                      );
                    }

                    if (branchesState is BranchesError) {
                      return Center(
                        child: ErrorMessageWithRetryButton(
                          message: branchesState.errorMessage,
                          onTap: () {
                            // call the CountriesGetEvent
                            context
                                .read<BranchesBloc>()
                                .add(BranchesGetEvent(bankId: selectedBankId));
                          },
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),

                // ========== end  Branch Selection
                // =================================
              ],
            ),
            const VerticalSpace(20),
            // ========== Start Calculation Info Widget
            // =================================
            BlocBuilder<CalculationBloc, CalculationState>(
              builder: (context, state) {
                if (state is CalculationLoaded) {
                  // enable the next step
                  // setState(() => isEnableNexStep = true);
                  //
                  if (state.calculationResponseModel.fees != null) {
                    final calc = state.calculationResponseModel;
                    return Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Text18SemiBoldTheme(
                              "Exchange Rate: 1 ${calc.sendCurrency} = ${calc.rate} ${calc.receiveCurrency}"),
                          CalculationValueListTile(
                            title: "Send amount",
                            value:
                                "${formatDouble(calc.sendAmount ?? 0)} ${calc.sendCurrency}",
                          ),
                          CalculationValueListTile(
                            title: "Fees",
                            value:
                                "${formatDouble(calc.fees ?? 0)} ${calc.sendCurrency}",
                          ),
                          CalculationValueListTile(
                            title: "You pay in total",
                            value:
                                "${formatDouble(calc.totalPayable ?? 0)} ${calc.sendCurrency}",
                          ),
                          CalculationValueListTile(
                            title: "Your recipient gets",
                            value:
                                "${formatDouble(calc.recipientGet ?? 0)} ${calc.receiveCurrency}",
                          ),
                          //Text("$state"),
                        ],
                      ),
                    );
                  } else {
                    const SizedBox.shrink();
                  }
                }

                if (state is CalculationError) {
                  return const SizedBox.shrink();
                }

                return const SizedBox.shrink();
              },
            ),

            if (_errorBranchSelection != "")
              RedErrorText(message: _errorBranchSelection),
            // ========== end Calculation Info Widget
            // =================================

            if (selectedBranchId != 0)
              BlocBuilder<SendMoneyBloc, SendMoneyState>(
                builder: (context, sendMoneyState) {
                  return BlocBuilder<CalculationBloc, CalculationState>(
                    builder: (context, calculationState) {
                      return Padding(
                        padding: getPadding(top: 10),
                        child: LargeButtonSecondaryColor(
                          marginLeft: 0,
                          marginRight: 0,
                          title: Loc.alized.lbl_next,
                          onTap: () {
                            if (_allValidation()) {
                              //
                              closSoftKeyBoard(context);
                              //
                              if (calculationState is CalculationLoaded) {
                                // prepare the store calculation request Map
                                Map<String, dynamic> requestMap = {
                                  "amount":
                                      sendMoneyState.calculationInfo.sendAmount,
                                  "sendCountry":
                                      sendMoneyState.sendFromCountryInfo.id,
                                  "getCountry":
                                      sendMoneyState.sendToCountryInfo.id,
                                  "country_service":
                                      sendMoneyState.serviceInfo.id,
                                  "payout_network": sendMoneyState.bankInfo.id,
                                  "payout_network_sub":
                                      sendMoneyState.branchInfo.id,
                                  "sendReceive": "send"
                                };
                                // initialize Store Calculation Event
                                context
                                    .read<StoreCalculationBloc>()
                                    .add(GetStoreCalculationEvent(
                                      requestMap: requestMap,
                                    ));

                                // go to next Tab
                                context.read<SendMoneyBloc>().add(
                                    const UpdateTabEvent(activeTabIndex: 2));
                              } else {
                                Map<String, dynamic> requestMap = {
                                  "amount": double.parse(
                                      _amountController.text.trim()),
                                  "sendCountry":
                                      sendMoneyState.sendFromCountryInfo.id,
                                  "getCountry":
                                      sendMoneyState.sendToCountryInfo.id,
                                  "serviceId": selectedServiceId,
                                  "sendReceive": 'send',
                                };

                                context.read<CalculationBloc>().add(
                                      GetCalculationEvent(
                                          requestMap: requestMap),
                                    );
                              }
                            } else {}
                          },
                        ),
                      );
                    },
                  );
                },
              )
          ],
        ),
      ),
    );
  }

  List<String> getSendingCountriesName(
    List<CountryInfoModel> countries,
    String sendToCountryName,
  ) {
    List<String> nameList = [];

    for (var country in countries) {
      if (sendToCountryName != country.name) {
        nameList.add(country.name ?? "");
      }
    }

    return nameList;
  }

  List<String> getToCountriesName(
    List<CountryInfoModel> countries,
    String sendFromCountryName,
  ) {
    List<String> nameList = [];

    for (var country in countries) {
      if (sendFromCountryName != country.name) {
        nameList.add(country.name ?? "");
      }
    }

    return nameList;
  }

  bool _allValidation() {
    bool isValid = true;

    if (selectedServiceId == 0) {
      isValid = false;
      _errorServiceSelection = "Required";
    } else {
      _errorServiceSelection = "";
    }

    if (selectedBankId == 0) {
      isValid = false;
      _errorBankSelection = "Required";
    } else {
      _errorBankSelection = "";
    }

    if (selectedBranchId == 0) {
      isValid = false;
      _errorBranchSelection = "Required";
    } else {
      _errorBranchSelection = "";
    }

    if (_amountController.text.trim().isEmpty) {
      _errorAmount = "Required";
      isValid = false;
    } else {
      _errorAmount = '';
    }

    setState(() {});
    return isValid;
  }
}

class SelectOptionButton extends StatelessWidget {
  const SelectOptionButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: getPadding(left: 10),
              child: Text(title,
                  style: TextStyle(
                    color: AppColors.gray60001,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Padding(
              padding: getMargin(left: 21, right: 11),
              child: CustomImageView(
                svgPath: LocalFiles.imgArrowdown,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BranchSearchButtonWidget extends StatelessWidget {
  const BranchSearchButtonWidget({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CustomImageView(
            svgPath: LocalFiles.imgSearch,
            height: 20,
            color: AppColors.secondary.withOpacity(0.7),
          ),
          const SizedBox(width: 4),
          const Text20Medium("Search")
        ],
      ),
    );
  }
}
