import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/enums/dialog_type.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/core/helpers/loading/loading_screen.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/countries_feature/bloc/countries_bloc.dart';
import 'package:anexpress/features/countries_feature/data/country_info_model.dart';
import 'package:anexpress/features/register/bloc/register_bloc.dart';
import 'package:anexpress/features/register/view/components/register_progress_app_bar.dart';
import 'package:anexpress/widgets/common_text_field_view.dart';
import 'package:anexpress/widgets/overlay_animated_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterTwoEmailPassword extends StatelessWidget {
  const RegisterTwoEmailPassword({
    super.key,
    required this.fistName,
    required this.lastName,
    required this.userName,
  });

  final String fistName;
  final String lastName;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocBuilder<CountriesBloc, CountriesState>(
          builder: (context, state) {
            if (state is CountriesLoading) {
              return const OverLayAnimatedSpinner();
            }
            if (state is CountriesLoaded) {
              return RegisterTwoEmailPasswordChildWidget(
                fistName: fistName,
                lastName: lastName,
                userName: userName,
                countriesList: state.countries,
              );
            }

            if (state is CountriesError) {
              return Center(
                child: ErrorMessageWithRetryButton(
                  message: state.errorMessage,
                  onTap: () {
                    // call the CountriesGetEvent
                    context
                        .read<CountriesBloc>()
                        .add(const CountriesGetEvent());
                  },
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable
class RegisterTwoEmailPasswordChildWidget extends StatefulWidget {
  const RegisterTwoEmailPasswordChildWidget({
    super.key,
    required this.fistName,
    required this.lastName,
    required this.userName,
    required this.countriesList,
  });

  final String fistName;
  final String lastName;
  final String userName;
  final List<CountryInfoModel> countriesList;

  @override
  State<RegisterTwoEmailPasswordChildWidget> createState() =>
      _RegisterTwoEmailPasswordChildWidgetState();
}

class _RegisterTwoEmailPasswordChildWidgetState
    extends State<RegisterTwoEmailPasswordChildWidget> {
  final _snackBarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String userCountry = "Select Country";
  String _errorUserCountrySelection = "";
  int selectedCountryId = 0;

  bool _passwordVisible = false;

  String _errorEmail = '';
  late TextEditingController _emailController;

  String _errorPassword = '';
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
    //setValues();
  }

  setValues() {
    setState(() {
      _emailController.text = "antestdev4@gmail.com";
      _passwordController.text = "12345678";
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
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) async {
        if (state is RegisterLoading) {
          LoadingScreen().show(
            context: context,
            text: 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }

        if (state is RegisterLoaded) {
          _snackBarService.showSnackbar(
            title: "Success",
            message: "Account created Successfully",
          );

          await Future.delayed(const Duration(seconds: 2));

          _navigationService.pushNamedAndRemoveUntil(AppRoutes.loginScreen);
        }

        if (state is RegisterError) {
          await _dialogService.showCustomDialog(
            variant: DialogType.Generic,
            title: "Error",
            description: state.errorMessage.replaceAll('Exception:', ''),
          );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Container(
                width: double.maxFinite,
                padding: getPadding(left: 13, top: 23, right: 13, bottom: 23),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const RegisterProgressAppBar(progress: 0.9),
                      Padding(
                        padding: getPadding(left: 2, top: 30, bottom: 8),
                        child: const Text24SemiBold(
                          "Create Account",
                        ),
                      ),
                      const Text16Regular(
                          "Enter your Email, Password and Select Country to Register"),
                      Padding(
                        padding: getPadding(top: 22),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text20Medium("Your Email"),
                            // QuestionMarkIconRoundButton(),
                          ],
                        ),
                      ),
                      CommonTextFieldView(
                        controller: _emailController,
                        focusNode: FocusNode(),
                        errorText: _errorEmail,
                        labelText: "Enter Your Email",
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (String txt) {},
                        textCapitalization: TextCapitalization.none,
                      ),
                      Padding(
                        padding: getPadding(top: 22),
                        child: Text20Medium(Loc.alized.lbl_password),
                      ),
                      CommonTextFieldView(
                        controller: _passwordController,
                        focusNode: FocusNode(),
                        errorText: _errorPassword,
                        labelText: "Type your password here",
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (String txt) {},
                        textCapitalization: TextCapitalization.none,
                        toggleObscure: () {
                          setState(() => _passwordVisible = !_passwordVisible);
                        },
                        isObscureText: !_passwordVisible,
                      ),
                      Padding(
                        padding: getPadding(top: 22),
                        child: const Text20Medium("Select Your Country"),
                      ),
                      CustomDropDown(
                        width: size.width,
                        focusNode: FocusNode(),
                        autofocus: true,
                        icon: Container(
                            margin: getMargin(left: 21, right: 11),
                            child: CustomImageView(
                              svgPath: LocalFiles.imgArrowdown,
                            )),
                        hintText: userCountry,
                        margin: getMargin(top: 2),
                        items: getCountriesName(widget.countriesList),
                        onChanged: (value) {
                          //
                          setState(() {
                            userCountry = value;
                          });

                          final id = getSelectedCountryID(
                              widget.countriesList, userCountry);

                          setState(() {
                            selectedCountryId = id;
                          });

                          _allValidation();
                        },
                      ),
                      if (_errorUserCountrySelection != "")
                        RedErrorText(message: _errorUserCountrySelection),
                      const VerticalSpace(40),
                      LargeButtonSecondaryColor(
                        title: Loc.alized.lbl_next,
                        marginLeft: 0,
                        marginRight: 0,
                        onTap: () {
                          if (_allValidation()) {
                            final Map<String, dynamic> requestValueMap = {
                              "firstname": widget.fistName,
                              "lastname": widget.lastName,
                              "username": widget.userName,
                              "email": _emailController.text,
                              "country_id": "$selectedCountryId",
                              "password": _passwordController.text,
                            };

                            context.read<RegisterBloc>().add(
                                  PerformUserRegister(
                                    requestValueMap: requestValueMap,
                                  ),
                                );
                          } else {
                            "form error".log();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _allValidation() {
    bool isValid = true;

    if (_emailController.text.trim().isEmpty) {
      _errorEmail = StringValues.email_cannot_empty;
      isValid = false;
    } else {
      _errorEmail = '';
    }

    // Password Validation
    if (_passwordController.text.trim().isEmpty ||
        !isPasswordLengthValid(_passwordController.text.trim(), 8, 16)) {
      _errorPassword = StringValues.valid_password_login;
      isValid = false;
    } else {
      _errorPassword = "";
    }

    if (userCountry == "Select Country") {
      isValid = false;
      _errorUserCountrySelection = "Required";
    } else {
      _errorUserCountrySelection = "";
    }

    setState(() {});

    return isValid;
  }

  /// Checks if password length is between minLength and maxLength (inclusive)
  static bool isPasswordLengthValid(
      String password, int minLength, int maxLength) {
    return password.length >= minLength && password.length <= maxLength;
  }
}

class PassStrengthCheckPoint extends StatelessWidget {
  const PassStrengthCheckPoint({
    super.key,
    required this.isPassed,
    required this.text,
  });

  final bool isPassed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 16),
      child: Row(
        children: [
          isPassed ? const RoundedPassedIcon() : const RoundedFailedIcon(),
          Padding(
            padding: getPadding(left: 12, top: 1),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtMontserratRomanMedium14,
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedFailedIcon extends StatelessWidget {
  const RoundedFailedIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.red, // Customize the border color
          width: 1.0, // Customize the border width
        ),
        color:
            Colors.transparent, // Customize the background color of the circle
      ),
      child: const Icon(
        Icons.close,
        size: 20,
        color: Colors.red, // Customize the color of the close icon
      ),
    );
  }
}

class RoundedPassedIcon extends StatelessWidget {
  const RoundedPassedIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.green, // Customize the border color
          width: 1.0, // Customize the border width
        ),
        color:
            Colors.transparent, // Customize the background color of the circle
      ),
      child: const Icon(
        Icons.check,
        size: 20,
        color: Colors.green, // Customize the color of the close icon
      ),
    );
  }
}
