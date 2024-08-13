import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/enums/dialog_type.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/core/helpers/loading/loading_screen.dart';
import 'package:anexpress/core/utils/validator.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/contact_us/bloc/contact_bloc.dart';
import 'package:anexpress/widgets/common_text_field_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stacked_services/stacked_services.dart';

class SendUsAMessageFormWidget extends StatefulWidget {
  const SendUsAMessageFormWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<SendUsAMessageFormWidget> createState() =>
      _SendUsAMessageFormWidgetState();
}

class _SendUsAMessageFormWidgetState extends State<SendUsAMessageFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final DialogService _dialogService = locator<DialogService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  String _errorEmail = '';
  late TextEditingController _emailController;
  String _errorName = '';
  late TextEditingController _nameController;
  String _errorSubject = '';
  late TextEditingController _subjectController;
  String _errorMessage = '';
  late TextEditingController _messageController;

  late FocusNode _messageFocusNode;

  @override
  void initState() {
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _subjectController = TextEditingController();
    _messageController = TextEditingController();

    _messageFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) async {
          if (state is ContactLoading) {
            LoadingScreen().show(
              context: context,
              text: 'Please wait a moment',
            );
          } else {
            LoadingScreen().hide();
          }

          if (state is ContactLoaded) {
            // show a success for email sent snackbar
            //
            _snackbarService.showSnackbar(
              duration: const Duration(seconds: 2),
              title: "Success",
              message: state.successMessage,
            );

            // clear input values

            _emailController.clear();
            _nameController.clear();
            _subjectController.clear();
            _messageController.clear();
          }

          if (state is ContactError) {
            await _dialogService.showCustomDialog(
              variant: DialogType.Generic,
              title: "Error",
              description: state.errorMessage,
            );
          }
        },
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text20MediumOrange(widget.title),
              ),
              Padding(
                padding: getPadding(top: 22),
                child: const Text20Medium("Your Name"),
              ),
              CommonTextFieldView(
                controller: _nameController,
                focusNode: FocusNode(),
                errorText: _errorName,
                labelText: "Enter Your Name",
                keyboardType: TextInputType.text,
                onChanged: (String txt) {},
                textCapitalization: TextCapitalization.none,
              ),
              Padding(
                padding: getPadding(top: 22),
                child: const Text20Medium("Email"),
              ),
              CommonTextFieldView(
                focusNode: FocusNode(),
                controller: _emailController,
                errorText: _errorEmail,
                labelText: "Enter Your Email",
                keyboardType: TextInputType.emailAddress,
                onChanged: (String txt) {},
                textCapitalization: TextCapitalization.none,
              ),
              Padding(
                padding: getPadding(top: 22),
                child: const Text20Medium("Your Subject"),
              ),
              CommonTextFieldView(
                controller: _subjectController,
                focusNode: FocusNode(),
                errorText: _errorSubject,
                labelText: "Enter Your Subject",
                keyboardType: TextInputType.text,
                onChanged: (String txt) {},
                textCapitalization: TextCapitalization.none,
              ),
              Padding(
                padding: getPadding(top: 22),
                child: const Text20Medium("Message"),
              ),
              CustomTextFormField(
                focusNode: _messageFocusNode,
                controller: _messageController,
                hintText: Loc.alized.msg_tell_us_what_s_on,
                margin: getMargin(top: 7),
                textInputAction: TextInputAction.done,
                maxLines: 6,
                onValueChange: (value) {
                  "on value change".log();
                  _allValidation();
                },
                validator: (value) {
                  if (_errorMessage != "") {
                    return _errorMessage;
                  }
                  return null;
                },
              ),
              const VerticalSpace(20),
              LargeButtonSecondaryColor(
                marginLeft: 0,
                marginRight: 0,
                title: Loc.alized.lbl_submit,
                onTap: () {
                  if (_allValidation()) {
                    "all validations passed".log();

                    Map<String, dynamic> requestValues = {
                      "name": _nameController.text.trim(),
                      "email": _emailController.text.trim(),
                      "subject": _subjectController.text.trim(),
                      "message": _messageController.text.trim()
                    };

                    context.read<ContactBloc>().add(
                        SubmitContactFormEvent(requestValueMap: requestValues));
                  } else {
                    "all validations NOT passed".log();
                  }
                },
              ),
              const VerticalSpace(10),
            ],
          ),
        ),
      ),
    );
  }

  bool _allValidation() {
    bool isValid = true;

    // email Validation
    if (_emailController.text.trim().isEmpty) {
      _errorEmail = StringValues.email_cannot_empty;
      isValid = false;
    } else if (!Validator.validateEmail(_emailController.text.trim())) {
      _errorEmail = StringValues.enter_valid_email;
      isValid = false;
    } else {
      _errorEmail = '';
    }

    // Name Validation
    if (_nameController.text.trim().isEmpty) {
      _errorName = StringValues.name_cannot_empty;
      isValid = false;
    } else {
      _errorName = '';
    }

    // Subject Validation
    if (_subjectController.text.trim().isEmpty) {
      _errorSubject = StringValues.subject_cannot_empty;
      isValid = false;
    } else {
      _errorSubject = '';
    }

    // Message Validation
    if (_messageController.text.trim().isEmpty ||
        _messageController.text.trim().length < 10) {
      _errorMessage = StringValues.message_min_length_error;
      isValid = false;
    } else {
      _errorMessage = '';
    }

    setState(() {});
    return isValid;
  }
}
