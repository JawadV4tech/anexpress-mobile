import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/gateway_detail_feature/data/gateway_detail_model.dart';
import 'package:anexpress/features/gateway_detail_feature/view/component/payment_list_tile.dart';
import 'package:anexpress/features/payment_card_feature/bloc/payment_card_bloc.dart';
import 'package:anexpress/features/payment_manually_feature/bloc/payment_manually_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore_for_file: must_be_immutable
class PaymentDialog extends StatelessWidget {
  const PaymentDialog({
    Key? key,
    required this.gatewayData,
    required this.gateWayCode,
  }) : super(
          key: key,
        );

  final GatewayDetailModel gatewayData;
  final String gateWayCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getHorizontalSize(
        340,
      ),
      padding: getPadding(
        all: 32,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteA700,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomImageView(
            url: gatewayData.gatewayImage ?? "",
            height: getSize(150),
            width: getSize(150),
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: getPadding(top: 34),
            child: PaymentListTile(
              title: "Amount:",
              value: "${gatewayData.amount}",
            ),
          ),
          PaymentListTile(
            title: "Charge:",
            value: "${gatewayData.charge}",
          ),
          PaymentListTile(
            title: "Payable:",
            value: "${gatewayData.payable}",
          ),
          PaymentListTile(
            title: "${gatewayData.inCurrency}",
            value: "",
          ),
          CustomButton(
            height: getVerticalSize(60),
            text: "Pay Now",
            margin: getMargin(top: 29),
            padding: ButtonPadding.PaddingAll12,
            onTap: () {
              Map<String, dynamic> requestMap = {
                "track": gatewayData.track,
              };
              if (gateWayCode == "manually") {
                context
                    .read<PaymentManuallyBloc>()
                    .add(GetPaymentManuallyEvent(requestMap: requestMap));
              } else {
                context
                    .read<PaymentCardBloc>()
                    .add(GetPaymentCardEvent(requestMap: requestMap));
              }
            },
          ),
        ],
      ),
    );
  }
}
