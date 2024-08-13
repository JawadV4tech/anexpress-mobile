import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/enums/dialog_type.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/core/helpers/loading/loading_screen.dart';
import 'package:anexpress/core/utils/validator.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/home_screen/home_screen.dart';
import 'package:anexpress/features/login/bloc/login_bloc.dart';
import 'package:anexpress/features/login/view/otp_input_screen.dart';
import 'package:anexpress/widgets/agree_terms_text.dart';
import 'package:anexpress/widgets/common_text_field_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:upgrader/upgrader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _snackBarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  List<String> radioItems = ['Email', 'SMS', 'Authenticator'];
  late String selectedOTPType = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  String _errorPassword = '';
  late TextEditingController _passwordController;

  String _errorEmail = '';
  late TextEditingController _emailController;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    super.initState();

    //setTestValues();
  }

  setTestValues() {
    setState(() {
      _emailController.text = "javeedishaq88@gmail.com";
      _passwordController.text = "Jawad1980*";
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: UpgradeAlert(
          upgrader: Upgrader(dialogStyle: UpgradeDialogStyle.material),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) async {
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
                // _snackBarService.showSnackbar(
                //   duration: const Duration(seconds: 2),
                //   title: "Success",
                //   message: "Login Successful",
                // );

                // await Future.delayed(const Duration(seconds: 2));

                if (state.userInfo.twoFa == 1) {
                  _navigationService.navigateToView(
                    OTPInputScreen(
                      email: _emailController.text,
                      password: _passwordController.text,
                      otpType: getOtpTypeValue(selectedOTPType),
                    ),
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false,
                  );
                }
              }

              if (state is LoginError) {
                if (state.errorMessage.contains('Code sent') ||
                    state.errorMessage.contains('app')) {
                  _snackBarService.showSnackbar(
                    duration: const Duration(seconds: 2),
                    title: "Success",
                    message: state.errorMessage.replaceAll('Exception:', ''),
                  );

                  await Future.delayed(const Duration(seconds: 2));

                  _navigationService.navigateToView(
                    OTPInputScreen(
                      email: _emailController.text,
                      password: _passwordController.text,
                      otpType: getOtpTypeValue(selectedOTPType),
                    ),
                  );
                } else {
                  await _dialogService.showCustomDialog(
                    variant: DialogType.Generic,
                    title: "Error",
                    description:
                        state.errorMessage.replaceAll('Exception:', ''),
                  );
                }
              }
            },
            child: RemoveFocus(
              onClick: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CurveShapeHeader(),
                        Padding(
                          padding: getPadding(left: 16),
                          child: Text32SemiBold(Loc.alized.lbl_login),
                        ),
                        Padding(
                          padding: getPadding(left: 16, top: 20),
                          child: Text20Medium(Loc.alized.lbl_email),
                        ),
                        Padding(
                          padding: getPadding(left: 16, right: 16),
                          child: CommonTextFieldView(
                            controller: _emailController,
                            focusNode: FocusNode(),
                            errorText: _errorEmail,
                            labelText: "Enter Your Email",
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (String txt) {},
                            textCapitalization: TextCapitalization.none,
                          ),
                        ),
                        Padding(
                          padding: getPadding(left: 16, top: 22),
                          child: Text20Medium(Loc.alized.lbl_password),
                        ),
                        Padding(
                          padding: getPadding(left: 16, right: 16),
                          child: CommonTextFieldView(
                            controller: _passwordController,
                            focusNode: FocusNode(),
                            errorText: _errorPassword,
                            labelText: "Type your password here",
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (String txt) {},
                            textCapitalization: TextCapitalization.none,
                            toggleObscure: () {
                              setState(
                                  () => _passwordVisible = !_passwordVisible);
                            },
                            isObscureText: !_passwordVisible,
                          ),
                        ),

                        // Align(
                        //   alignment: Alignment.bottomRight,
                        //   child: InkWell(
                        //     onTap: () {
                        //       Navigator.of(context).push(
                        //         MaterialPageRoute(
                        //           builder: (context) => PhoneNumberInputScreen(
                        //             title: Loc.alized.lbl_forgot_password,
                        //             subTitle: Loc.alized.msg_enter_your_mobile,
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     child: Padding(
                        //       padding:
                        //           getPadding(right: 16, top: 12, bottom: 16),
                        //       child: Text20MediumOrange(
                        //         Loc.alized.lbl_forgot_password,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: getPadding(left: 16, top: 20),
                          child: const Text14Medium(
                              "Choose where to receive one time password"),
                        ),
                        Wrap(
                          children: radioItems
                              .map((item) => SizedBox(
                                    width: 185,
                                    child: RadioListTile(
                                      dense: true,
                                      title: Text(item),
                                      value: item,
                                      groupValue: selectedOTPType,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedOTPType = value ?? "";
                                        });
                                      },
                                    ),
                                  ))
                              .toList(),
                        ),
                        const VerticalSpace(30),
                        LargeButtonSecondaryColor(
                          title: Loc.alized.lbl_login.toUpperCase(),
                          onTap: () {
                            if (_allSignInValidation()) {
                              // if 2fa is is disable then 0 and if 2fa is active with
                              // generating the code it will be 1 and when comparing
                              // the code then it will be 2 with code key

                              // "otp_type"  it will be 'email' , 'sms' or a 'app'

                              //build loginMap
                              Map<String, dynamic> loginMap = {};
                              if (selectedOTPType == '') {
                                loginMap = {
                                  "email": _emailController.text,
                                  "password": _passwordController.text,
                                  "login_request_flag": "0",
                                };
                              } else {
                                loginMap = {
                                  "email": _emailController.text,
                                  "password": _passwordController.text,
                                  "login_request_flag": "1",
                                  "otp_type": getOtpTypeValue(selectedOTPType)
                                };
                              }

                              "validation passed $loginMap".log();

                              /// init Login event
                              context.read<LoginBloc>().add(
                                    PerformUserLogin(
                                      requestValueMap: loginMap,
                                      apiEndPoint: userLoginApi,
                                    ),
                                  );
                            } else {
                              //"_errorID is $_errorID".log();

                              "validation Not passed".log();
                            }
                          },
                        ),
                        Padding(
                          padding: getPadding(left: 15, top: 20),
                          child: const AgreeTermsText(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getOtpTypeValue(String val) {
    String value = "";

    if (val == "Email") {
      value = "email";
    }

    if (val == "SMS") {
      value = "sms";
    }

    if (val == "Authenticator") {
      value = "app";
    }

    return value;
  }

  bool _allSignInValidation() {
    bool isValid = true;
    if (_passwordController.text.trim().isEmpty) {
      _errorPassword = Loc.alized.msg_required;
      isValid = false;
    } else {
      _errorPassword = '';
    }

    if (_emailController.text.trim().isEmpty) {
      _errorEmail = Loc.alized.msg_required;
      isValid = false;
    } else if (!Validator.validateEmail(_emailController.text.trim())) {
      _errorEmail = Loc.alized.msg_valid_email;
      isValid = false;
    } else {
      _errorEmail = '';
    }

    setState(() {});
    return isValid;
  }
}
