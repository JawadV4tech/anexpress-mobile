// ignore_for_file: use_build_context_synchronously

import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/enums/dialog_type.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/core/helpers/loading/loading_screen.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/banks_feature/bloc/banks_bloc.dart';
import 'package:anexpress/features/branches_feature/bloc/branches_bloc.dart';
import 'package:anexpress/features/calculation_feature/bloc/calculation_bloc.dart';
import 'package:anexpress/features/discount_feature/bloc/discount_bloc.dart';
import 'package:anexpress/features/gateway_detail_feature/bloc/gateway_detail_bloc.dart';
import 'package:anexpress/features/card_payment_webview/card_payment_webview.dart';
import 'package:anexpress/features/gateway_detail_feature/view/payment_dialog.dart';
import 'package:anexpress/features/gateways_feature/bloc/gateway_bloc.dart';
import 'package:anexpress/features/home_screen/home_screen.dart';
import 'package:anexpress/features/logout_feature/bloc/logout_bloc.dart';
import 'package:anexpress/features/payment_card_feature/bloc/payment_card_bloc.dart';
import 'package:anexpress/features/payment_manually_feature/bloc/payment_manually_bloc.dart';
import 'package:anexpress/features/recipient_feature/bloc/recipient_bloc.dart';
import 'package:anexpress/features/send_money/bloc/send_money_bloc.dart';
import 'package:anexpress/features/send_money/view/components/circle_dot_tab_view_indicator.dart';
import 'package:anexpress/features/send_money/view/disccount_view.dart';
import 'package:anexpress/features/send_money/view/gate_ways_list_view.dart';
import 'package:anexpress/features/send_money/view/recipient_info_input_view.dart';
import 'package:anexpress/features/send_money/view/select_to_from_view.dart';
import 'package:anexpress/features/send_money/view/service_bank_branch_calculation_view.dart';
import 'package:anexpress/features/sendmoney_data_feature/bloc/send_money_data_bloc.dart';
import 'package:anexpress/features/services_feature/bloc/services_bloc.dart';
import 'package:anexpress/features/store_calculation_feature/bloc/store_calculation_bloc.dart';
import 'package:anexpress/features/user_data_feature/bloc/user_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked_services/stacked_services.dart';

class SendMoneyScreenContainer extends StatelessWidget {
  SendMoneyScreenContainer({super.key});

  final _dialogService = locator<DialogService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            // ServicesBloc Listener
            BlocListener<ServicesBloc, ServicesState>(
              listener: (context, servicesState) {
                if (servicesState is ServicesLoading) {
                  LoadingScreen().show(context: context, text: "");
                } else {
                  LoadingScreen().hide();
                }
              },
            ),

            // BanksBloc Listener
            BlocListener<BanksBloc, BanksState>(
              listener: (context, servicesState) {
                if (servicesState is BanksLoading) {
                  LoadingScreen().show(context: context, text: "");
                } else {
                  LoadingScreen().hide();
                }
              },
            ),
            // BranchesBloc Listener
            BlocListener<BranchesBloc, BranchesState>(
              listener: (context, branchesState) {
                if (branchesState is BranchesLoading) {
                  LoadingScreen().show(context: context, text: "");
                } else {
                  LoadingScreen().hide();
                }
              },
            ),

            // CalculationBloc Listener
            BlocListener<CalculationBloc, CalculationState>(
                listener: (context, calculationState) async {
              if (calculationState is CalculationLoading) {
                LoadingScreen().show(context: context, text: "");
              } else {
                LoadingScreen().hide();
              }

              if (calculationState is CalculationError) {
                await _dialogService.showCustomDialog(
                  variant: DialogType.Generic,
                  title: "Error",
                  description: calculationState.errorMessage,
                );
              }

              //

              if (calculationState is CalculationLoaded) {
                // update calculationInfo state
                context.read<SendMoneyBloc>().add(
                      UpdateCalculationEvent(
                        calculationInfo:
                            calculationState.calculationResponseModel,
                      ),
                    );
              }
            }),

            //StoreCalculationBloc
            BlocListener<StoreCalculationBloc, StoreCalculationState>(
                listener: (context, storeCalcState) async {
              if (storeCalcState is StoreCalculationLoading) {
                LoadingScreen().show(context: context, text: "");
              } else {
                LoadingScreen().hide();
              }

              if (storeCalcState is StoreCalculationError) {
                await _dialogService.showCustomDialog(
                  variant: DialogType.Generic,
                  title: "Error",
                  description: storeCalcState.errorMessage,
                );

                // Reset Banks, Branches and Calculations Blocs States
                context.read<BanksBloc>().add(const BanksResetEvent());
                context.read<BranchesBloc>().add(const BranchesResetEvent());
                context
                    .read<CalculationBloc>()
                    .add(const CalculationResetEvent());

                // navigate back to previous tab
                context
                    .read<SendMoneyBloc>()
                    .add(const UpdateTabEvent(activeTabIndex: 1));
              }

              //

              if (storeCalcState is StoreCalculationLoaded) {
                // initialize the Event to get  Send Money Api Data
                context.read<RecipientBloc>().add(
                      GetSendMoneyRecipientEvent(
                        id: storeCalcState.storeCalculationModel.id ?? 0,
                      ),
                    );

                // update Store calculationInfo in SendMoney state
                context.read<SendMoneyBloc>().add(
                      UpdateStoreCalculationEvent(
                        storeCalculationModel:
                            storeCalcState.storeCalculationModel,
                      ),
                    );
              }
            }),

            //DiscountBloc
            BlocListener<DiscountBloc, DiscountState>(
                listener: (context, discountState) async {
              if (discountState is DiscountLoading) {
                LoadingScreen().show(context: context, text: "");
              } else {
                LoadingScreen().hide();
              }

              if (discountState is DiscountError) {
                showErrorAlertLogoutUserOnSessionExpire(
                  discountState.errorMessage,
                  context,
                );
              }

              //

              if (discountState is DiscountLoaded) {
                // update Discount state
                if (discountState.isPromo) {
                  context.read<SendMoneyBloc>().add(
                        UpdatePromoDiscountEvent(
                          discount: discountState.discount,
                        ),
                      );
                } else {
                  context.read<SendMoneyBloc>().add(
                        UpdateReferralDiscountEvent(
                          discount: discountState.discount,
                        ),
                      );
                }
              }
            }),

            //SendMoneyDataBloc

            BlocListener<SendMoneyDataBloc, SendMoneyDataState>(
                listener: (context, sendMoneyDataState) async {
              if (sendMoneyDataState is SendMoneyDataLoading) {
                LoadingScreen().show(context: context, text: "");
              } else {
                LoadingScreen().hide();
              }

              if (sendMoneyDataState is SendMoneyDataError) {
                showErrorAlertLogoutUserOnSessionExpire(
                  sendMoneyDataState.errorMessage,
                  context,
                );
              }

              //

              if (sendMoneyDataState is SendMoneyDataLoaded) {
                // initialize get gateways
                context.read<GatewayBloc>().add(GatewaysGetEvent());

                // clears the searched user so It can be searched again
                context
                    .read<SendMoneyBloc>()
                    .add(const ClearSearchedUserDataEvent());
                // navigate back to previous tab
                context
                    .read<SendMoneyBloc>()
                    .add(const UpdateTabEvent(activeTabIndex: 4));
              }
            }),

            //GatewayBloc
            BlocListener<GatewayBloc, GatewayState>(
                listener: (context, gatewaysState) async {
              if (gatewaysState is GatewayLoading) {
                LoadingScreen().show(context: context, text: "");
              } else {
                LoadingScreen().hide();
              }

              if (gatewaysState is GatewayError) {
                showErrorAlertLogoutUserOnSessionExpire(
                  gatewaysState.errorMessage,
                  context,
                );
              }
            }),

            BlocListener<GatewayDetailBloc, GatewayDetailState>(
                listener: (context, gatewayDetailState) async {
              if (gatewayDetailState is GatewayDetailLoading) {
                LoadingScreen().show(context: context, text: "");
              } else {
                LoadingScreen().hide();
              }

              if (gatewayDetailState is GatewayDetailError) {
                showErrorAlertLogoutUserOnSessionExpire(
                  gatewayDetailState.errorMessage,
                  context,
                );
              }

              if (gatewayDetailState is GatewayDetailLoaded) {
                //  show the dialogue

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: PaymentDialog(
                      gateWayCode: gatewayDetailState.gatewayCode,
                      gatewayData: gatewayDetailState.gatewayDetailModel,
                    ),
                    backgroundColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    insetPadding: const EdgeInsets.only(left: 0),
                  ),
                );

                //
              }
            }),

            //PaymentManuallyBloc
            BlocListener<PaymentManuallyBloc, PaymentManuallyState>(
                listener: (context, paymentManuallyBlocState) async {
              if (paymentManuallyBlocState is PaymentManuallyLoading) {
                LoadingScreen().show(context: context, text: "");
              } else {
                LoadingScreen().hide();
              }

              if (paymentManuallyBlocState is PaymentManuallyError) {
                showErrorAlertLogoutUserOnSessionExpire(
                  paymentManuallyBlocState.errorMessage,
                  context,
                );
              }

              if (paymentManuallyBlocState is PaymentManuallyLoaded) {
                //  show the dialogue
                await _dialogService.showCustomDialog(
                  variant: DialogType.Generic,
                  title: "Success",
                  description: paymentManuallyBlocState.message,
                );

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );

                //
              }
            }),

            //PaymentCardBloc
            BlocListener<PaymentCardBloc, PaymentCardState>(
                listener: (context, paymentCardBlocState) async {
              if (paymentCardBlocState is PaymentCardLoading) {
                LoadingScreen().show(context: context, text: "");
              } else {
                LoadingScreen().hide();
              }

              if (paymentCardBlocState is PaymentCardError) {
                showErrorAlertLogoutUserOnSessionExpire(
                  paymentCardBlocState.errorMessage,
                  context,
                );
              }

              if (paymentCardBlocState is PaymentCardLoaded) {
                //  show the dialogue
                // navigate to webview screen

                "${paymentCardBlocState.paymentCardResponseModel}".log();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CardPaymentWebView(
                      paymentData:
                          paymentCardBlocState.paymentCardResponseModel,
                    ),
                  ),
                );

                //
              }
            }),

            //SendMoneyDataBloc

            BlocListener<UserDataBloc, UserDataState>(
                listener: (context, userDataState) async {
              if (userDataState.status == UserDataStatus.loading) {
                LoadingScreen().show(context: context, text: "");
              } else {
                LoadingScreen().hide();
              }

              if (userDataState.status == UserDataStatus.error) {
                await _dialogService.showCustomDialog(
                  variant: DialogType.Generic,
                  title: "Error",
                  description: userDataState.message,
                );
              }

              //

              if (userDataState.status == UserDataStatus.success) {
                // navigate back to previous tab
                context.read<SendMoneyBloc>().add(UpdateSearchedUserDataEvent(
                    searchUserData: userDataState.userData));
              }
            }),
          ],
          child: BlocBuilder<SendMoneyBloc, SendMoneyState>(
            builder: (context, state) {
              if (state.status == SendMoneyStatus.success) {
                return SendMoneyScreenChild(
                  sendMoneyState: state,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  void showErrorAlertLogoutUserOnSessionExpire(
      String errorMessage, BuildContext context) async {
    await _dialogService.showCustomDialog(
      variant: DialogType.Generic,
      title: "Error",
      description: errorMessage,
    );
    if (errorMessage == "Session Expired Please login again") {
      context.read<LogoutBloc>().add(const PerformUserLogout());
    }
  }
}

class SendMoneyScreenChild extends StatefulWidget {
  const SendMoneyScreenChild({
    super.key,
    required this.sendMoneyState,
  });

  final SendMoneyState sendMoneyState;

  @override
  State<SendMoneyScreenChild> createState() => _SendMoneyScreenChildState();
}

class _SendMoneyScreenChildState extends State<SendMoneyScreenChild>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  //int tabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant SendMoneyScreenChild oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.sendMoneyState.activeTabIndex !=
        widget.sendMoneyState.activeTabIndex) {
      _tabController.animateTo(widget.sendMoneyState.activeTabIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: getPadding(left: 10, top: 10),
                child: IconButton(
                  onPressed: () {
                    if (widget.sendMoneyState.activeTabIndex == 0) {
                      Navigator.pop(context);
                    } else {
                      //
                      // Reset Banks, Branches and Calculations Blocs States
                      context.read<BanksBloc>().add(const BanksResetEvent());
                      context
                          .read<BranchesBloc>()
                          .add(const BranchesResetEvent());
                      context
                          .read<CalculationBloc>()
                          .add(const CalculationResetEvent());

                      // navigate back to previous tab
                      context.read<SendMoneyBloc>().add(UpdateTabEvent(
                          activeTabIndex:
                              widget.sendMoneyState.activeTabIndex - 1));
                    }
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.gray60001,
                  ),
                ),
              ),
            ),
            CircleDotTabViewIndicator(
              activeTabIndex: widget.sendMoneyState.activeTabIndex,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 115,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    const SelectToFromView(),
                    ServiceBankBranchCalculationView(
                      sendMoneyState: widget.sendMoneyState,
                    ),
                    const DiscountView(),
                    RecipientInfoInPutView(
                      sendMoneyState: widget.sendMoneyState,
                    ),
                    GateWaysListView(
                      sendMoneyState: widget.sendMoneyState,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
