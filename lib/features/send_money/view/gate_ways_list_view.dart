import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/gateway_detail_feature/bloc/gateway_detail_bloc.dart';
import 'package:anexpress/features/gateways_feature/bloc/gateway_bloc.dart';
import 'package:anexpress/features/send_money/bloc/send_money_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GateWaysListView extends StatefulWidget {
  const GateWaysListView({super.key, required this.sendMoneyState});

  final SendMoneyState sendMoneyState;

  @override
  State<GateWaysListView> createState() => _GateWaysListViewState();
}

class _GateWaysListViewState extends State<GateWaysListView> {
  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        // ========== Start Calculation Info Widget
        // =================================
        BlocBuilder<GatewayBloc, GatewayState>(
          builder: (context, state) {
            if (state is GatewayLoaded) {
              return Padding(
                padding: getPadding(left: 20, right: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: getPadding(left: 2, top: 20, bottom: 20),
                      child: const Text24SemiBold("Pay Now"),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.gatewaysModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final gateway = state.gatewaysModel.data?[index];

                        return InkWell(
                          onTap: () {
                            context.read<GatewayDetailBloc>().add(
                                  GatewayDetailGetEvent(
                                    gatewayCode: gateway?.code ?? '',
                                    requestMap: {
                                      "amount": widget.sendMoneyState
                                          .calculationInfo.totalPayable,
                                      "gateway": gateway?.code ?? '',
                                      "send_money": widget.sendMoneyState
                                          .storeCalculationModel.invoice
                                    },
                                  ),
                                );
                          },
                          child: Card(
                            margin: getMargin(bottom: 20),
                            elevation: 20,
                            child: Row(
                              children: [
                                CustomImageView(
                                  url:
                                      "${state.gatewaysModel.url}/${gateway?.image}",
                                  height: getSize(150),
                                  width: getSize(150),
                                  alignment: Alignment.bottomLeft,
                                  fit: BoxFit.fill,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: getPadding(top: 10, bottom: 10),
                                      child:
                                          Text24SemiBold(gateway?.name ?? ''),
                                    ),
                                    Padding(
                                      padding: getPadding(left: 10, bottom: 15),
                                      child: Text(gateway?.description ?? ''),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        context.read<GatewayDetailBloc>().add(
                                              GatewayDetailGetEvent(
                                                gatewayCode:
                                                    gateway?.code ?? '',
                                                requestMap: {
                                                  "amount": widget
                                                      .sendMoneyState
                                                      .calculationInfo
                                                      .totalPayable,
                                                  "gateway":
                                                      gateway?.code ?? '',
                                                  "send_money": widget
                                                      .sendMoneyState
                                                      .storeCalculationModel
                                                      .invoice
                                                },
                                              ),
                                            );
                                      },
                                      child: const Text("Pay Now"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            } else {
              const SizedBox.shrink();
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
