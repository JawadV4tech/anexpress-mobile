import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/discount_feature/view/discount_input_view.dart';
import 'package:anexpress/features/send_money/bloc/send_money_bloc.dart';
import 'package:anexpress/features/send_money/view/components/calculation_value_list_tile.dart';
import 'package:anexpress/features/send_money/view/components/total_payment_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscountView extends StatefulWidget {
  const DiscountView({super.key});

  @override
  State<DiscountView> createState() => _DiscountViewState();
}

class _DiscountViewState extends State<DiscountView> {
  bool isShowReferralDiscountInput = false;
  bool isShowPromoCodeDiscountInput = false;

  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        // ========== Start Calculation Info Widget
        // =================================
        BlocBuilder<SendMoneyBloc, SendMoneyState>(
          builder: (context, state) {
            if (state.status == SendMoneyStatus.success) {
              // enable the next step
              // setState(() => isEnableNexStep = true);
              //
              if (state.calculationInfo.fees != null) {
                final calc = state.calculationInfo;
                return Padding(
                  padding: getPadding(left: 20, right: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: getPadding(left: 2, top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text24SemiBold("${state.serviceInfo.name}"),
                            Text16Bold(
                                "${calc.sendCurrency} - ${calc.receiveCurrency}")
                          ],
                        ),
                      ),
                      Card(
                        elevation: 10,
                        child: Column(
                          children: [
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
                              title: "Exchange rate",
                              value:
                                  "1 ${calc.sendCurrency} = ${calc.rate} ${calc.receiveCurrency}",
                            ),
                            (state.promoCodeDiscount != 0 ||
                                    state.referralCodeDiscount != 0)
                                ? TotalPaymentValueListTile(
                                    title: "You pay in total",
                                    value:
                                        "${formatDouble(calc.totalPayable ?? 0)} ${calc.sendCurrency}",
                                    discountedValue:
                                        "${formatDouble(calc.totalPayable! - (state.promoCodeDiscount + state.referralCodeDiscount))} ${calc.sendCurrency}",
                                  )
                                : CalculationValueListTile(
                                    title: "You pay in total",
                                    value:
                                        "${formatDouble(calc.totalPayable ?? 0)} ${calc.sendCurrency}",
                                  ),
                            CalculationValueListTile(
                              title: "Your recipient gets",
                              value:
                                  "${formatDouble(calc.recipientGet ?? 0)} ${calc.receiveCurrency}",
                            ),
                            CalculationValueListTile(
                              title: "Bank Name",
                              value: "${state.bankInfo.name}",
                            ),
                            CalculationValueListTile(
                              isShowInColumn: true,
                              title: "Branch Name",
                              value: "${state.branchInfo.name}",
                            ),
                            ListTile(
                              dense: true,
                              title: const Text("Get a promo code?"),
                              trailing: SizedBox(
                                width: 60,
                                child: CustomSwitch(
                                  margin: getMargin(
                                    top: 11,
                                    bottom: 13,
                                  ),
                                  value: isShowPromoCodeDiscountInput,
                                  onChanged: (value) {
                                    "onChanged value $value".log();
                                    setState(() {
                                      isShowPromoCodeDiscountInput = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            if (isShowPromoCodeDiscountInput)
                              DiscountInputWidget(
                                invoiceId: int.parse(
                                    state.storeCalculationModel.invoice ?? "0"),
                                isPromoOrReferral: true,
                              ),
                            ListTile(
                              dense: true,
                              title: const Text("Get a referral discount?"),
                              trailing: SizedBox(
                                width: 60,
                                child: CustomSwitch(
                                  margin: getMargin(
                                    top: 11,
                                    bottom: 13,
                                  ),
                                  value: isShowReferralDiscountInput,
                                  onChanged: (value) {
                                    "onChanged value $value".log();
                                    setState(() {
                                      isShowReferralDiscountInput = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            if (isShowReferralDiscountInput)
                              DiscountInputWidget(
                                invoiceId: int.parse(
                                    state.storeCalculationModel.invoice ?? "0"),
                                isPromoOrReferral: false,
                              ),
                            Padding(
                              padding: getPadding(top: 40),
                              child: LargeButtonSecondaryColor(
                                marginLeft: 0,
                                marginRight: 0,
                                title: Loc.alized.lbl_next,
                                onTap: () {
                                  // go to next Tab
                                  context.read<SendMoneyBloc>().add(
                                      const UpdateTabEvent(activeTabIndex: 3));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                const SizedBox.shrink();
              }
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
