// ignore_for_file: use_build_context_synchronously

import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/core/utils/validator.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/recipient_feature/bloc/recipient_bloc.dart';
import 'package:anexpress/features/recipient_feature/data/send_money_recipient_model.dart';
import 'package:anexpress/features/send_money/bloc/send_money_bloc.dart';
import 'package:anexpress/features/send_money/view/components/search_info_text.dart';
import 'package:anexpress/features/sendmoney_data_feature/bloc/send_money_data_bloc.dart';
import 'package:anexpress/features/user_data_feature/bloc/user_data_bloc.dart';
import 'package:anexpress/features/user_data_feature/data/search_user_data_model.dart';
import 'package:anexpress/features/user_search_feature/bloc/user_search_bloc.dart';
import 'package:anexpress/features/user_search_feature/data/user_search.dart';
import 'package:anexpress/widgets/city_drop_down.dart';
import 'package:anexpress/widgets/common_text_field_view.dart';
import 'package:anexpress/widgets/sending_purpose_drop_down.dart';
import 'package:anexpress/widgets/source_of_fund_drop_down.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

class RecipientInfoInPutView extends StatefulWidget {
  const RecipientInfoInPutView({super.key, required this.sendMoneyState});

  final SendMoneyState sendMoneyState;

  @override
  State<RecipientInfoInPutView> createState() => _RecipientInfoInPutViewState();
}

class _RecipientInfoInPutViewState extends State<RecipientInfoInPutView> {
  @override
  Widget build(BuildContext context) {
    //
    return Column(
      children: [
        Padding(
          padding: getPadding(left: 2, top: 15),
          child: const Text24SemiBold("Add Recipient"),
        ),
        // ========== Start  Service Selection
        // =================================
        BlocBuilder<RecipientBloc, RecipientState>(
          builder: (context, state) {
            if (state is RecipientLoaded) {
              return AddRecipientForm(
                recipInfo: state.sendMoneyRecipientModel,
                sendMoneyState: widget.sendMoneyState,
              );
            }

            if (state is RecipientError) {
              return Center(
                child: ErrorMessageWithRetryButton(
                  message:
                      "Unable to communicate, Try again", //state.errorMessage,
                  onTap: () {
                    // call the CountriesGetEvent
                    // navigate back to previous tab
                    context
                        .read<SendMoneyBloc>()
                        .add(const UpdateTabEvent(activeTabIndex: 2));
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class AddRecipientForm extends StatefulWidget {
  const AddRecipientForm(
      {super.key, required this.recipInfo, required this.sendMoneyState});

  final SendMoneyRecipientModel recipInfo;
  final SendMoneyState sendMoneyState;

  @override
  State<AddRecipientForm> createState() => _AddRecipientFormState();
}

class _AddRecipientFormState extends State<AddRecipientForm> {
  //
  //final DialogService _dialogService = locator<DialogService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  int searchedUserId = 0;

  String birthDate = "Date of Birth";
  String _birthDateError = "";
  DateTime selectedDate = DateTime.now();

  String _errorGenderSelection = "";
  List<String> genders = ["Male", "Female"];
  String recipientGender = "Select Gender";

  String _errorCitySelection = "";
  String recipientCity = "";
  int recipientCityId = 0;
  late RecipientCity selectedRecipientCity;

  String _errorSourceOfFund = "";
  String sourceOfFund = "";

  String _errorPurpose = "";
  String purpose = "";

  String _errorRelation = "";
  String relation = "";

  List<String> seniorPosition = ["No", "Yes"];
  List<String> relations = [
    "Father",
    "Mother",
    "Brother",
    "Sister",
    "Friend",
    "Relative",
    "My Self"
  ];

  String recipientRelationship = "Select Relationship";
  String seniorPositionAnswer = "Select";

  String _errorRecipientName = '';
  late TextEditingController _recipientNameController;

  String _errorPhoneInput = '';
  late TextEditingController _phoneController;

  final String _errorEmail = '';
  late TextEditingController _emailController;

  final String _errorAccount = '';
  late TextEditingController _accountController;

  final String _errorIsGovtEmployeeText = '';
  late TextEditingController _isGovtEmployeeTextController;

  //isGovtEmployeeText

  String _errorAddress = '';
  late TextEditingController _addressController;
  late TextEditingController _referenceController;

  final String _errorSortingCode = '';
  late TextEditingController _sortingCodeController;

  final String _errorSwift = '';
  late TextEditingController _swiftController;

  final String _errorRouting = '';
  late TextEditingController _routingController;

  final String _errorIban = '';
  late TextEditingController _ibanController;

  late FocusNode _recipientFocusNode;
  late FocusNode _phoneFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _addressFocusNode;
  late FocusNode _accountFocusNode;
  late FocusNode _referenceFocusNode;
  late FocusNode _isGovtEmployeeTextFocusNode;
  late FocusNode _sortingCodeFocusNode;
  late FocusNode _swiftFocusNode;
  late FocusNode _routingFocusNode;
  late FocusNode _ibanFocusNode;

  @override
  void initState() {
    _recipientNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _accountController = TextEditingController();
    _referenceController = TextEditingController();
    _isGovtEmployeeTextController = TextEditingController();
    _sortingCodeController = TextEditingController();
    _swiftController = TextEditingController();
    _routingController = TextEditingController();
    _ibanController = TextEditingController();

    _recipientFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _accountFocusNode = FocusNode();
    _referenceFocusNode = FocusNode();
    _isGovtEmployeeTextFocusNode = FocusNode();
    _sortingCodeFocusNode = FocusNode();
    _swiftFocusNode = FocusNode();
    _routingFocusNode = FocusNode();
    _ibanFocusNode = FocusNode();

    super.initState();
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final f = DateFormat('yyyy-MM-dd');

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930, 01),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        birthDate = f.format(picked);
      });
    }
  }

  @override
  void dispose() {
    _recipientNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _accountController.dispose();
    _referenceController.dispose();
    _isGovtEmployeeTextController.dispose();
    _sortingCodeController.dispose();
    _swiftController.dispose();
    _routingController.dispose();
    _ibanController.dispose();

    super.dispose();
  }

  void setRecipientValues({required SearchUserDataModel searchUserDataModel}) {
    final matchedCity = widget.recipInfo.cities!.firstWhereOrNull(
      (city) => city.id == searchUserDataModel.recipientCityId,
    );

    setState(() {
      // this.recipientContactNo,
      // this.recipientEmail,
      // this.recipientDob,
      // this.recipientGender,
      // this.recipientCityId,
      // this.recipientAddress,
      // this.recipientIban,
      // this.recipientAccountNumber,
      // this.routingNumber,
      // this.swiftNumber,
      // this.sortingCode,
      _phoneController.text = searchUserDataModel.recipientContactNo ?? "";
      _recipientNameController.text = searchUserDataModel.recipientName ?? "";
      _emailController.text = searchUserDataModel.recipientEmail ?? "";
      birthDate = searchUserDataModel.recipientDob ?? "";
      recipientGender = searchUserDataModel.recipientGender ?? "";
      recipientCityId = searchUserDataModel.recipientCityId ?? 0;
      recipientCity = matchedCity?.name ?? "";
      selectedRecipientCity = matchedCity!;
      _addressController.text = searchUserDataModel.recipientAddress ?? "";
      _ibanController.text = searchUserDataModel.recipientIban ?? "";
      _accountController.text =
          searchUserDataModel.recipientAccountNumber ?? "";
      _swiftController.text = searchUserDataModel.swiftNumber ?? "";
      _sortingCodeController.text = searchUserDataModel.sortingCode ?? "";
    });
  }

  @override
  void didUpdateWidget(covariant AddRecipientForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.sendMoneyState != oldWidget.sendMoneyState) {
      if (widget.sendMoneyState.searchUserData.id != null) {
        setRecipientValues(
          searchUserDataModel: widget.sendMoneyState.searchUserData,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMoneyBloc, SendMoneyState>(
      builder: (context, sendMoneyState) {
        return Container(
          height: MediaQuery.of(context).size.height - 164,
          padding: getPadding(left: 13, top: 0, right: 13, bottom: 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Align(
                    alignment: Alignment.bottomRight, child: SearchInfoText()),
                const TextFieldLabelTextWidget("Recipient Name *"),
                Stack(
                  children: [
                    CommonTextFieldView(
                      controller: _recipientNameController,
                      focusNode: _recipientFocusNode,
                      errorText: _errorRecipientName,
                      labelText: "Name",
                      keyboardType: TextInputType.text,
                      onChanged: (String txt) {},
                      textCapitalization: TextCapitalization.none,
                      onEditingComplete: () {
                        if (FocusScope.of(context).canRequestFocus) {
                          FocusScope.of(context).requestFocus(_phoneFocusNode);
                        }
                      },
                    ),
                    Positioned(
                      top: 13,
                      right: 20,
                      child: CustomImageView(
                        svgPath: LocalFiles.imgSearch,
                        color: AppColors.secondary.withOpacity(0.7),
                        onTap: () async {
                          final result = await showSearch(
                            context: context,
                            delegate: UserSearch(
                              BlocProvider.of<UserSearchBloc>(context),
                              widget.sendMoneyState.sendToCountryInfo.id ?? 0,
                              widget.sendMoneyState.serviceInfo.id ?? 0,
                              _recipientNameController.text.trim(),
                            ),
                          );

                          "search rec: $result".log();
                          setState(() {
                            searchedUserId = result!;
                          });

                          if (result != null && result != 0) {
                            context.read<UserDataBloc>().add(
                                  GetUsersDataEvent(userId: result),
                                );
                          }
                        },
                      ),
                    )
                  ],
                ),
                const TextFieldLabelTextWidget("Recipient Contact No. *"),
                CommonTextFieldView(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  errorText: _errorPhoneInput,
                  labelText: "Contact No.",
                  keyboardType: TextInputType.text,
                  onChanged: (String txt) {},
                  textCapitalization: TextCapitalization.none,
                  onEditingComplete: () {
                    if (FocusScope.of(context).canRequestFocus) {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    }
                  },
                ),
                const TextFieldLabelTextWidget("Recipient Email Address"),
                CommonTextFieldView(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  errorText: _errorEmail,
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String txt) {},
                  textCapitalization: TextCapitalization.none,
                  onEditingComplete: () {
                    if (FocusScope.of(context).canRequestFocus) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
                const TextFieldLabelTextWidget("Recipient DOB *"),
                GestureDetector(
                  onTap: () => _selectBirthDate(context),
                  child: Container(
                    height: 50,
                    padding: getPadding(left: 10, top: 0, right: 10, bottom: 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          birthDate,
                          style: TextStyle(
                            color: AppColors.gray60001,
                            fontSize: getFontSize(16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                if (_birthDateError != "")
                  RedErrorText(message: _birthDateError),
                const TextFieldLabelTextWidget("Recipient Gender *"),
                CustomDropDown(
                  width: size.width,
                  icon: Container(
                      margin: getMargin(left: 21, right: 11),
                      child: CustomImageView(
                        svgPath: LocalFiles.imgArrowdown,
                      )),
                  hintText: recipientGender,
                  margin: getMargin(top: 2),
                  items: genders,
                  onChanged: (value) {
                    //
                    setState(() {
                      recipientGender = value;
                      _errorGenderSelection = "";
                    });
                  },
                ),
                if (_errorGenderSelection != "")
                  RedErrorText(message: _errorGenderSelection),
                //
                const TextFieldLabelTextWidget("Recipient City *"),
                CityDropDown(
                  width: size.width,
                  icon: Container(
                      margin: getMargin(left: 21, right: 11),
                      child: CustomImageView(
                        svgPath: LocalFiles.imgArrowdown,
                      )),
                  hintText: "Select Recipient City",
                  margin: getMargin(top: 0),
                  items: widget.recipInfo.cities,
                  selectedCity:
                      recipientCityId != 0 ? selectedRecipientCity : null,
                  onChanged: (val) {
                    setState(() {
                      recipientCity = val.name ?? "";
                      recipientCityId = val.id ?? 0;
                      _errorCitySelection = "";
                      selectedRecipientCity = val;
                    });
                  },
                ),
                if (_errorCitySelection != "")
                  RedErrorText(message: _errorCitySelection),
                //
                const TextFieldLabelTextWidget("Recipient Address *"),
                CommonTextFieldView(
                  controller: _addressController,
                  focusNode: _addressFocusNode,
                  errorText: _errorAddress,
                  labelText: "Address",
                  keyboardType: TextInputType.text,
                  onChanged: (String txt) {},
                  textCapitalization: TextCapitalization.none,
                  onEditingComplete: () {
                    if (FocusScope.of(context).canRequestFocus) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
                const TextFieldLabelTextWidget("Source Of Fund *"),
                SourceOfFundDropDown(
                  width: size.width,
                  icon: Container(
                      margin: getMargin(left: 21, right: 11),
                      child: CustomImageView(
                        svgPath: LocalFiles.imgArrowdown,
                      )),
                  hintText: "Select Source Of Fund",
                  margin: getMargin(top: 0),
                  items: widget.recipInfo.sourceFunds,
                  onChanged: (source) {
                    "value received $source".log();

                    setState(() {
                      sourceOfFund = source.title ?? "";
                      _errorSourceOfFund = "";
                    });
                  },
                ),
                if (_errorSourceOfFund != "")
                  RedErrorText(message: _errorSourceOfFund),
                const TextFieldLabelTextWidget("Sending Purpose *"),
                SendingPurposeDropDown(
                  width: size.width,
                  icon: Container(
                      margin: getMargin(left: 21, right: 11),
                      child: CustomImageView(
                        svgPath: LocalFiles.imgArrowdown,
                      )),
                  hintText: "Select Sending Purposes",
                  margin: getMargin(top: 0),
                  items: widget.recipInfo.sendingPurpose,
                  onChanged: (val) {
                    "value received $val".log();

                    setState(() {
                      purpose = val.title ?? "";
                      _errorPurpose = "";
                    });
                  },
                ),
                if (_errorPurpose != "") RedErrorText(message: _errorPurpose),
                const TextFieldLabelTextWidget("Relationship with Recipient *"),
                CustomDropDown(
                  width: size.width,
                  icon: Container(
                      margin: getMargin(left: 21, right: 11),
                      child: CustomImageView(
                        svgPath: LocalFiles.imgArrowdown,
                      )),
                  hintText: recipientRelationship,
                  margin: getMargin(top: 2),
                  items: relations,
                  onChanged: (value) {
                    //
                    setState(() {
                      relation = value;
                      _errorRelation = "";
                    });
                  },
                ),
                if (_errorRelation != "") RedErrorText(message: _errorRelation),
                if (sendMoneyState.serviceInfo.id == 3)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextFieldLabelTextWidget("Sorting Code"),
                      CommonTextFieldView(
                        controller: _sortingCodeController,
                        focusNode: _sortingCodeFocusNode,
                        errorText: _errorSortingCode,
                        labelText: "Code",
                        keyboardType: TextInputType.text,
                        onChanged: (String txt) {},
                        textCapitalization: TextCapitalization.none,
                        onEditingComplete: () {
                          if (FocusScope.of(context).canRequestFocus) {
                            FocusScope.of(context)
                                .requestFocus(_accountFocusNode);
                          }
                        },
                      ),
                      const TextFieldLabelTextWidget(
                          "Recipient Account Number *"),
                      CommonTextFieldView(
                        controller: _accountController,
                        focusNode: _accountFocusNode,
                        errorText: _errorAccount,
                        labelText: "Account",
                        keyboardType: TextInputType.text,
                        onChanged: (String txt) {},
                        textCapitalization: TextCapitalization.none,
                        onEditingComplete: () {
                          if (FocusScope.of(context).canRequestFocus) {
                            FocusScope.of(context)
                                .requestFocus(_swiftFocusNode);
                          }
                        },
                      ),
                      const TextFieldLabelTextWidget("Swift/BIC Number"),
                      CommonTextFieldView(
                        controller: _swiftController,
                        focusNode: _swiftFocusNode,
                        errorText: _errorSwift,
                        labelText: "Swift/BIC",
                        keyboardType: TextInputType.text,
                        onChanged: (String txt) {},
                        textCapitalization: TextCapitalization.none,
                        onEditingComplete: () {
                          if (FocusScope.of(context).canRequestFocus) {
                            FocusScope.of(context)
                                .requestFocus(_routingFocusNode);
                          }
                        },
                      ),
                      const TextFieldLabelTextWidget("Routing Number"),
                      CommonTextFieldView(
                        controller: _routingController,
                        focusNode: _routingFocusNode,
                        errorText: _errorRouting,
                        labelText: "Routing Number",
                        keyboardType: TextInputType.text,
                        onChanged: (String txt) {},
                        textCapitalization: TextCapitalization.none,
                        onEditingComplete: () {
                          if (FocusScope.of(context).canRequestFocus) {
                            FocusScope.of(context).requestFocus(_ibanFocusNode);
                          }
                        },
                      ),
                      const TextFieldLabelTextWidget("Recipient IBAN"),
                      CommonTextFieldView(
                        controller: _ibanController,
                        focusNode: _ibanFocusNode,
                        errorText: _errorIban,
                        labelText: "IBAN",
                        keyboardType: TextInputType.text,
                        onChanged: (String txt) {},
                        textCapitalization: TextCapitalization.none,
                        onEditingComplete: () {
                          if (FocusScope.of(context).canRequestFocus) {
                            FocusScope.of(context).unfocus();
                          }
                        },
                      ),
                    ],
                  ),

                const TextFieldLabelTextWidget(
                    "Is any member of your extended family holding senior governmental position within the UK or outside of the UK?"),
                CustomDropDown(
                  width: size.width,
                  icon: Container(
                      margin: getMargin(left: 21, right: 11),
                      child: CustomImageView(
                        svgPath: LocalFiles.imgArrowdown,
                      )),
                  hintText: seniorPositionAnswer,
                  margin: getMargin(top: 2),
                  items: seniorPosition,
                  onChanged: (value) {
                    //
                    setState(() {
                      seniorPositionAnswer = value;
                    });
                  },
                ),
                if (seniorPositionAnswer == "Yes")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextFieldLabelTextWidget("Please provide details"),
                      CommonTextFieldView(
                        controller: _isGovtEmployeeTextController,
                        focusNode: _isGovtEmployeeTextFocusNode,
                        errorText: _errorIsGovtEmployeeText,
                        labelText: "detail",
                        keyboardType: TextInputType.text,
                        onChanged: (String txt) {},
                        textCapitalization: TextCapitalization.none,
                        onEditingComplete: () {
                          if (FocusScope.of(context).canRequestFocus) {
                            FocusScope.of(context).unfocus();
                          }
                        },
                      ),
                    ],
                  ),
                const TextFieldLabelTextWidget("Payment Reference"),
                SizedBox(
                  height: 150,
                  child: CustomTextFormField(
                    focusNode: _referenceFocusNode,
                    controller: _referenceController,
                    hintText: "",
                    margin: getMargin(top: 7),
                    textInputAction: TextInputAction.done,
                    maxLines: 6,
                    onValueChange: (value) {
                      "on value change".log();
                      _allValidation();
                    },
                    validator: (value) {
                      return null;
                    },
                    onEditingComplete: () {
                      if (FocusScope.of(context).canRequestFocus) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: getPadding(top: 20, bottom: 50),
                  child: LargeButtonSecondaryColor(
                    marginLeft: 0,
                    marginRight: 0,
                    title: Loc.alized.lbl_next,
                    onTap: () {
                      if (context.read<SendMoneyBloc>().state.serviceInfo.id ==
                          3) {
                        if (_allValidation()) {
                          // call the SendMoneyData Event
                          Map<String, dynamic> requestMap = {
                            "send_money":
                                sendMoneyState.storeCalculationModel.invoice,
                            "recipient_name":
                                _recipientNameController.text.trim(),
                            "recipient_email": _emailController.text.trim(),
                            "recipient_contact_no":
                                _phoneController.text.trim(),
                            "fund_source": sourceOfFund,
                            "purpose": purpose,
                            "recipient_dob": birthDate,
                            "recipient_gender": recipientGender,
                            "recipient_city": recipientCityId,
                            "recipient_address": _addressController.text.trim(),
                            "relationship_with_receipient": relation,
                            "payment_reference":
                                _referenceController.text.trim(),
                            "is_govt_employee_outside":
                                (seniorPositionAnswer == "Yes") ? 1 : 0,
                            "sorting_code": _sortingCodeController.text.trim(),
                            "recipient_account_number":
                                _accountController.text.trim(),
                            "swift_number": _swiftController.text.trim(),
                            "routing_number": _routingController.text.trim(),
                            "recipient_iban": _ibanController.text.trim(),
                            "govt_employee_detail":
                                _isGovtEmployeeTextController.text.trim()
                          };
                          //
                          "requestMap: $requestMap".log();
                          context.read<SendMoneyDataBloc>().add(
                              GetSendMoneyDataEvent(requestMap: requestMap));
                        } else {
                          "form error".log();
                          _snackbarService.showSnackbar(
                            duration: const Duration(seconds: 2),
                            message: "Please Fill the Required info",
                          );
                        }
                      } else {
                        if (_otherServiceValidation()) {
                          // call the SendMoneyData Event
                          Map<String, dynamic> requestMap = {
                            "send_money":
                                sendMoneyState.storeCalculationModel.invoice,
                            "recipient_name":
                                _recipientNameController.text.trim(),
                            "recipient_email": _emailController.text.trim(),
                            "recipient_contact_no":
                                _phoneController.text.trim(),
                            "fund_source": sourceOfFund,
                            "purpose": purpose,
                            "recipient_dob": birthDate,
                            "recipient_gender": recipientGender,
                            "recipient_city": recipientCityId,
                            "recipient_address": _addressController.text.trim(),
                            "relationship_with_receipient": relation,
                            "payment_reference":
                                _referenceController.text.trim(),
                            "is_govt_employee_outside":
                                (seniorPositionAnswer == "Yes") ? 1 : 0,
                            "govt_employee_detail":
                                _isGovtEmployeeTextController.text.trim()
                          };
                          //

                          context.read<SendMoneyDataBloc>().add(
                              GetSendMoneyDataEvent(requestMap: requestMap));
                        } else {
                          "form error".log();
                          _snackbarService.showSnackbar(
                            duration: const Duration(seconds: 2),
                            message: "Please Fill the Required info",
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _allValidation() {
    bool isValid = true;

    if (_recipientNameController.text.trim().isEmpty) {
      _errorRecipientName = StringValues.full_name_cannot_empty;
      isValid = false;
    } else {
      _errorRecipientName = '';
    }

    // Phone Validation
    if (_phoneController.text.trim().isEmpty) {
      _errorPhoneInput = StringValues.phone_cannot_empty;
      isValid = false;
    } else if (!Validator.validatePhone(_phoneController.text.trim())) {
      _errorPhoneInput = StringValues.valid_phone;
      isValid = false;
    } else {
      _errorPhoneInput = '';
    }

    // if (_emailController.text.trim().isEmpty) {
    //   _errorEmail = StringValues.email_cannot_empty;
    //   isValid = false;
    // } else {
    //   _errorEmail = '';
    // }

    if (birthDate == "Date of Birth") {
      isValid = false;
      _birthDateError = "Required";
    } else {
      _birthDateError = "";
    }

    if (recipientGender == "Select Gender") {
      isValid = false;
      _errorGenderSelection = "Required";
    } else {
      _errorGenderSelection = "";
    }

    if (recipientCity == "") {
      isValid = false;
      _errorCitySelection = "Required";
    } else {
      _errorCitySelection = "";
    }

    if (sourceOfFund == "") {
      isValid = false;
      _errorSourceOfFund = "Required";
    } else {
      _errorSourceOfFund = "";
    }

    if (purpose == "") {
      isValid = false;
      _errorPurpose = "Required";
    } else {
      _errorSourceOfFund = "";
    }

    if (relation == "") {
      isValid = false;
      _errorRelation = "Required";
    } else {
      _errorRelation = "";
    }

    if (_addressController.text.trim().isEmpty) {
      _errorAddress = StringValues.address_cannot_empty;
      isValid = false;
    } else {
      _errorAddress = '';
    }

    //

    // if (_sortingCodeController.text.trim().isEmpty) {
    //   _errorSortingCode = StringValues.required_text;
    //   isValid = false;
    // } else {
    //   _errorAccount = '';
    // }

    // if (_accountController.text.trim().isEmpty) {
    //   _errorAccount = StringValues.account_cannot_empty;
    //   isValid = false;
    // } else {
    //   _errorAccount = '';
    // }

    // if (_swiftController.text.trim().isEmpty) {
    //   _errorSwift = StringValues.required_text;
    //   isValid = false;
    // } else {
    //   _errorAccount = '';
    // }

    // if (_routingController.text.trim().isEmpty) {
    //   _errorRouting = StringValues.required_text;
    //   isValid = false;
    // } else {
    //   _errorAccount = '';
    // }

    // if (_ibanController.text.trim().isEmpty) {
    //   _errorIban = StringValues.required_text;
    //   isValid = false;
    // } else {
    //   _errorAccount = '';
    // }

    setState(() {});
    return isValid;
  }

  bool _otherServiceValidation() {
    bool isValid = true;

    if (_recipientNameController.text.trim().isEmpty) {
      _errorRecipientName = StringValues.full_name_cannot_empty;
      isValid = false;
    } else {
      _errorRecipientName = '';
    }

    // Phone Validation
    if (_phoneController.text.trim().isEmpty) {
      _errorPhoneInput = StringValues.phone_cannot_empty;
      isValid = false;
    } else if (!Validator.validatePhone(_phoneController.text.trim())) {
      _errorPhoneInput = StringValues.valid_phone;
      isValid = false;
    } else {
      _errorPhoneInput = '';
    }

    // if (_emailController.text.trim().isEmpty) {
    //   _errorEmail = StringValues.email_cannot_empty;
    //   isValid = false;
    // } else {
    //   _errorEmail = '';
    // }

    if (birthDate == "Date of Birth") {
      isValid = false;
      _birthDateError = "Required";
    } else {
      _birthDateError = "";
    }

    if (recipientGender == "Select Gender") {
      isValid = false;
      _errorGenderSelection = "Required";
    } else {
      _errorGenderSelection = "";
    }

    if (recipientCity == "") {
      isValid = false;
      _errorCitySelection = "Required";
    } else {
      _errorCitySelection = "";
    }

    if (sourceOfFund == "") {
      isValid = false;
      _errorSourceOfFund = "Required";
    } else {
      _errorSourceOfFund = "";
    }

    if (purpose == "") {
      isValid = false;
      _errorPurpose = "Required";
    } else {
      _errorSourceOfFund = "";
    }

    if (relation == "") {
      isValid = false;
      _errorRelation = "Required";
    } else {
      _errorRelation = "";
    }

    if (_addressController.text.trim().isEmpty) {
      _errorAddress = StringValues.address_cannot_empty;
      isValid = false;
    } else {
      _errorAddress = '';
    }

    setState(() {});
    return isValid;
  }
}
