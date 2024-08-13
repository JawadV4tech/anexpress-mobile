import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/discount_feature/bloc/discount_bloc.dart';
import 'package:anexpress/widgets/common_text_field_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscountInputWidget extends StatefulWidget {
  const DiscountInputWidget({
    super.key,
    required this.isPromoOrReferral,
    required this.invoiceId,
  });

  final bool isPromoOrReferral;
  final int invoiceId;

  @override
  State<DiscountInputWidget> createState() => _DiscountInputWidgetState();
}

class _DiscountInputWidgetState extends State<DiscountInputWidget> {
  final String _errorDiscountCode = '';
  late TextEditingController _discountCodeController;

  @override
  void initState() {
    _discountCodeController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _discountCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 65;
    return SizedBox(
      height: 50,
      child: Padding(
        padding: getPadding(left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width * 0.75,
              child: CommonTextFieldView(
                controller: _discountCodeController,
                focusNode: FocusNode(),
                errorText: _errorDiscountCode,
                labelText:
                    widget.isPromoOrReferral ? "Enter Code" : "Enter Amount",
                keyboardType: TextInputType.text,
                onChanged: (String txt) {},
                textCapitalization: TextCapitalization.none,
              ),
            ),
            SizedBox(
              width: width * 0.25,
              child: LargeButtonSecondaryColor(
                marginLeft: 0,
                marginRight: 0,
                title: "APPLY",
                onTap: () {
                  if (_discountCodeController.text.trim().isNotEmpty) {
                    //
                    closSoftKeyBoard(context);
                    //
                    if (widget.isPromoOrReferral) {
                      // initialize Promo Discount Event
                      context.read<DiscountBloc>().add(
                            GetDiscountEvent(
                              requestMap: {
                                "send_money": widget.invoiceId,
                                "promo": _discountCodeController.text.trim()
                              },
                              apiUrl: postPromoDiscountApi,
                            ),
                          );
                    } else {
                      // initialize Promo Discount Event
                      context.read<DiscountBloc>().add(
                            GetDiscountEvent(
                              requestMap: {
                                "send_money": widget.invoiceId,
                                "referral": _discountCodeController.text.trim()
                              },
                              apiUrl: postReferralDiscountApi,
                            ),
                          );
                    }
                  } else {
                    "form error".log();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
