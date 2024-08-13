import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/enums/dialog_type.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/core/helpers/loading/loading_screen.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/home_screen/home_screen.dart';
import 'package:anexpress/features/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:async';

class OTPInputScreen extends StatefulWidget {
  const OTPInputScreen(
      {super.key,
      required this.email,
      required this.password,
      required this.otpType});

  final String email;
  final String password;
  final String otpType;

  @override
  State<OTPInputScreen> createState() => _OTPInputScreenState();
}

class _OTPInputScreenState extends State<OTPInputScreen> {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _snackBarService = locator<SnackbarService>();

  bool isCheckbox = false;
  String otpValue = "";
  bool otpValueError = false;

  @override
  void initState() {
    super.initState();

    startCountdown();
  }

  int seconds = 60;
  bool isShowResendOTPButton = false;

  Future<void> startCountdown() async {
    // Create a periodic timer that runs every second
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (seconds > 0) {
        // Decrement the seconds until it reaches 0

        setState(() => seconds = seconds - 1);
      } else {
        // Set the value to true after the countdown reaches 0

        setState(() => isShowResendOTPButton = true);

        // Cancel the timer once the countdown is completed
        timer.cancel();
      }
    });

    // Wait for the countdown to complete (60 seconds in this case)
    await Future.delayed(const Duration(seconds: 60));

    // After the countdown completes, you can now use the valueAfterCountdown as needed
    if (isShowResendOTPButton) {
      ("The countdown has completed, and the value is true.").log();
      // Add your desired logic here when the value becomes true after 60 seconds.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            setState(() => otpValue = "");
            "the state is $state".log();
            if (state is LoginLoading) {
              LoadingScreen().show(
                context: context,
                text: 'Please wait a moment',
              );
            } else {
              LoadingScreen().hide();
            }

            // if Success

            if (state is LoginLoaded) {
              _snackBarService.showSnackbar(
                duration: const Duration(seconds: 2),
                title: "Success",
                message: "Login Successful",
              );

              await Future.delayed(const Duration(seconds: 2));

              _navigationService.navigateToView(HomeScreen());
            }

            if (state is LoginError) {
              await _dialogService.showCustomDialog(
                variant: DialogType.Generic,
                title: "Error",
                description: state.errorMessage,
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CurveShapeHeader(),
                Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 15, top: 23, right: 15, bottom: 23),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(left: 2, top: 30),
                        child: Text24SemiBold(
                          Loc.alized.msg_enter_otp_for_verification,
                        ),
                      ),
                      Padding(
                        padding: getPadding(left: 2, top: 10),
                        child: const Text16Regular("We have sent the OTP"),
                      ),
                      const VerticalSpace(41),
                      Padding(
                        padding: getPadding(top: 65, left: 30, right: 30),
                        child: SizedBox(
                          child: PinCodeTextField(
                            appContext: context,
                            length: 6,
                            obscureText: false,
                            obscuringCharacter: '*',
                            keyboardType: TextInputType.text,
                            autoDismissKeyboard: true,
                            enableActiveFill: true,
                            inputFormatters: const [
                              //FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (code) {
                              "value: $code".log();

                              if (code.length == 6) {
                                //build loginMap
                                Map<String, dynamic> loginMap = {
                                  "email": widget.email,
                                  "password": widget.password,
                                  "login_request_flag": "2",
                                  "otp_type": widget.otpType,
                                  "code": code
                                };

                                "validation passed $loginMap".log();

                                /// init Login events
                                context.read<LoginBloc>().add(
                                      PerformUserLogin(
                                        requestValueMap: loginMap,
                                        apiEndPoint: userLoginApi,
                                      ),
                                    );
                              }
                            },
                            textStyle: TextStyle(
                              color: AppColors.black900,
                              fontSize: getFontSize(18),
                              fontWeight: FontWeight.w500,
                            ),
                            pinTheme: PinTheme(
                              fieldHeight: getHorizontalSize(60),
                              fieldWidth: getHorizontalSize(40),
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              selectedFillColor: AppColors.gray50,
                              activeFillColor: AppColors.gray50,
                              inactiveFillColor: AppColors.whiteA700,
                              inactiveColor: AppColors.gray600,
                              selectedColor: AppColors.secondary,
                              activeColor: AppColors.secondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
