import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/countries_feature/bloc/countries_bloc.dart';
import 'package:anexpress/features/register/view/register_two_email_password.dart';
import 'package:anexpress/widgets/common_text_field_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked_services/stacked_services.dart';

// ignore_for_file: must_be_immutable
class RegisterOneNameScreen extends StatefulWidget {
  const RegisterOneNameScreen({super.key});

  @override
  State<RegisterOneNameScreen> createState() => _RegisterOneNameScreenState();
}

class _RegisterOneNameScreenState extends State<RegisterOneNameScreen> {
  final _navigationService = locator<NavigationService>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _errorFirstName = '';
  late TextEditingController _firstNameController;

  String _errorLastName = '';
  late TextEditingController _lastNameController;

  String _errorUserName = '';
  late TextEditingController _userNameController;

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _userNameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Form(
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
                  BackArrowButton(arrowColor: AppColors.gray60001),
                  Padding(
                    padding: getPadding(left: 2, top: 10, bottom: 8),
                    child: const Text24SemiBold("Create Your Account"),
                  ),
                  const Text16Regular(
                      "Sign Up to get convenient way of sending money"),
                  Padding(
                    padding: getPadding(top: 22),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text20Medium("First Name"),
                        // QuestionMarkIconRoundButton(),
                      ],
                    ),
                  ),
                  CommonTextFieldView(
                    controller: _firstNameController,
                    focusNode: FocusNode(),
                    errorText: _errorFirstName,
                    labelText: "Your First Name",
                    keyboardType: TextInputType.text,
                    onChanged: (String txt) {},
                    textCapitalization: TextCapitalization.none,
                  ),
                  Padding(
                    padding: getPadding(top: 22),
                    child: const Text20Medium("Last Name"),
                  ),
                  CommonTextFieldView(
                    controller: _lastNameController,
                    focusNode: FocusNode(),
                    errorText: _errorLastName,
                    labelText: "Your Last Name",
                    keyboardType: TextInputType.text,
                    onChanged: (String txt) {},
                    textCapitalization: TextCapitalization.none,
                  ),
                  Padding(
                    padding: getPadding(top: 22),
                    child: const Text20Medium("User Name"),
                  ),
                  CommonTextFieldView(
                    controller: _userNameController,
                    focusNode: FocusNode(),
                    errorText: _errorUserName,
                    labelText: "Your User Name",
                    keyboardType: TextInputType.text,
                    onChanged: (String txt) {},
                    textCapitalization: TextCapitalization.none,
                  ),
                  const VerticalSpace(37),
                  const VerticalSpace(40),
                  LargeButtonSecondaryColor(
                    marginLeft: 0,
                    marginRight: 0,
                    title: Loc.alized.lbl_next,
                    onTap: () {
                      if (_allValidation()) {
                        // call the CountriesGetEvent
                        context
                            .read<CountriesBloc>()
                            .add(const CountriesGetEvent());

                        _navigationService
                            .navigateToView(RegisterTwoEmailPassword(
                          fistName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          userName: _userNameController.text.trim(),
                        ));
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
      ),
    );
  }

  bool _allValidation() {
    bool isValid = true;

    if (_firstNameController.text.trim().isEmpty) {
      _errorFirstName = StringValues.first_name_cannot_empty;
      isValid = false;
    } else {
      _errorFirstName = '';
    }

    if (_lastNameController.text.trim().isEmpty) {
      _errorLastName = StringValues.last_name_cannot_empty;
      isValid = false;
    } else {
      _errorLastName = '';
    }

    if (_userNameController.text.trim().isEmpty) {
      _errorUserName = StringValues.user_name_cannot_empty;
      isValid = false;
    } else {
      _errorUserName = '';
    }

    setState(() {});
    return isValid;
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
