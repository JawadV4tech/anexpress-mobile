import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/helpers/otp_text_field.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/two_fa_able_feature/bloc/two_fa_able_bloc.dart';
import 'package:anexpress/features/two_fa_security_screen/data/two_fa_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class OTPBottomSheetWidget extends StatefulWidget {
  const OTPBottomSheetWidget({
    super.key,
    required this.twoFAInfoModel,
    required this.isPerformEnable,
  });

  final TwoFAInfoModel twoFAInfoModel;
  final bool isPerformEnable;

  @override
  State<OTPBottomSheetWidget> createState() => _OTPBottomSheetWidgetState();
}

class _OTPBottomSheetWidgetState extends State<OTPBottomSheetWidget>
    with WidgetsBindingObserver {
  bool isCheckbox = false;
  String otpValue = "";
  bool otpValueError = false;
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();

    // Add the observer to the state
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Remove the observer to avoid memory leaks
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool isKeyboardOpened = mediaQuery.viewInsets.bottom > 0.0 &&
        !mediaQuery.viewInsets.bottom.isNaN;
    setState(() {
      isKeyboardVisible = isKeyboardOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: getPadding(left: 20, top: 30),
          child: Text18SemiBold(
            Loc.alized.msg_enter_otp_for_verification,
          ),
        ),
        const VerticalSpace(41),
        OtpTextField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          enabledBorderColor: isLightMode() ? Colors.black87 : Colors.white,
          numberOfFields: 6,
          borderColor: AppColors.secondary,
          //set to true to show as box or false to show as dash
          showFieldAsBox: true,
          //runs when a code is typed in
          onCodeChanged: (String code) {
            //handle validation or checks here

            setState(() {
              otpValue = otpValue + code;
            });
            if (otpValue != "" && otpValue.length == 6) {
              setState(() {
                otpValueError = false;
              });
            }
          },
          //runs when every textfield is filled
          onSubmit: (String verificationCode) async {
            if (otpValue != "" && otpValue.length == 6) {
              setState(() {
                otpValueError = false;
              });

              Navigator.pop(context);

              if (widget.isPerformEnable) {
                //build requestValueMap
                Map<String, dynamic> requestValueMap = {
                  "key": widget.twoFAInfoModel.secret,
                  "code": otpValue
                };

                /// init Login events
                context.read<TwoFAableBloc>().add(
                      TwoFaAblePostEvent(
                        requestValueMap: requestValueMap,
                        apiEndPoint: post2FAEnableApi,
                      ),
                    );
              } else {
                //build requestValueMap
                Map<String, dynamic> requestValueMap = {
                  "previousCode": widget.twoFAInfoModel.previousCode,
                  "previousQR": widget.twoFAInfoModel.previousQR,
                  "code": otpValue
                };

                /// init Login events
                context.read<TwoFAableBloc>().add(
                      TwoFaAblePostEvent(
                        requestValueMap: requestValueMap,
                        apiEndPoint: post2FADisableApi,
                      ),
                    );
              }
            } else {
              setState(() {
                otpValueError = true;
              });
            }
          }, // end onSubmit
        ),
        const VerticalSpace(10),
        if (otpValueError)
          Center(
              child: Text(
            Loc.alized.msg_required,
            style: const TextStyle(color: Colors.red),
          )),
        const VerticalSpace(50),
      ],
    );
  }
}
