import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/core/utils/validator.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class PhoneNumberInputScreen extends StatefulWidget {
  final String title;
  final String subTitle;

  const PhoneNumberInputScreen({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  State<PhoneNumberInputScreen> createState() => _PhoneNumberInputScreenState();
}

class _PhoneNumberInputScreenState extends State<PhoneNumberInputScreen> {
  List<String> dropdownItemList1 = ["Item One", "Item Two", "Item Three"];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _errorPhoneInput = "";
  late TextEditingController _phoneController;
  late FocusNode _phoneFocusNode;

  bool nextButtonEnable = false;

  @override
  void initState() {
    _phoneController = TextEditingController();

    _phoneFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyWalletAppBar(titleText: widget.title),
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: getPadding(left: 13, top: 23, right: 13, bottom: 23),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: getPadding(left: 3),
                    child: Text16Regular(widget.subTitle),
                  ),
                  Padding(
                    padding: getPadding(left: 3, top: 34),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: getPadding(top: 2, right: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text20Medium(Loc.alized.lbl_country_code),
                                CustomDropDown(
                                  width: getHorizontalSize(196),
                                  focusNode: FocusNode(),
                                  autofocus: true,
                                  icon: Container(
                                      margin: getMargin(left: 21, right: 11),
                                      decoration: const BoxDecoration(
                                          // color:
                                          //     AppColors.gray700,
                                          ),
                                      child: CustomImageView(
                                        svgPath: LocalFiles.imgArrowdown,
                                      )),
                                  hintText: "South Africa(+27)",
                                  margin: getMargin(top: 2),
                                  items: getCountriesList(),
                                  onChanged: (value) {},
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: getPadding(left: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text20Medium(Loc.alized.msg_service_provider),
                                CustomDropDown(
                                  width: getHorizontalSize(196),
                                  focusNode: FocusNode(),
                                  autofocus: true,
                                  icon: Container(
                                    margin: getMargin(left: 30, right: 11),
                                    decoration: const BoxDecoration(),
                                    child: CustomImageView(
                                      svgPath: LocalFiles.imgArrowdown,
                                    ),
                                  ),
                                  hintText: Loc.alized.lbl_choose_provider,
                                  margin: getMargin(top: 4),
                                  items: dropdownItemList1,
                                  onChanged: (value) {},
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: getPadding(top: 22),
                    child: Text20Medium(Loc.alized.lbl_phone_number),
                  ),
                  CustomTextFormField(
                    focusNode: _phoneFocusNode,
                    controller: _phoneController,
                    hintText: "0XX XXX  XXX",
                    margin: getMargin(top: 7),
                    textInputType: TextInputType.phone,
                    prefixConstraints: BoxConstraints(
                      maxHeight: getVerticalSize(64),
                    ),
                    onValueChange: (value) {
                      _allValidation();
                    },
                    validator: (value) {
                      if (_errorPhoneInput != "") {
                        return _errorPhoneInput;
                      }
                      return null;
                    },
                  ),
                  const CaptchaWidget(),
                  const VerticalSpace(30),
                  LargeButtonSecondaryColor(
                    title: Loc.alized.lbl_next,
                    marginLeft: 0,
                    marginRight: 0,
                    onTap: () {
                      if (_allValidation()) {
                      } else {
                        "_errorID is $_errorPhoneInput".log();
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

  onTapArrowleft1(BuildContext context) {
    Navigator.pop(context);
  }

  bool _allValidation() {
    bool isValid = true;

    // Phone Validation
    if (_phoneController.text.trim().isEmpty) {
      _errorPhoneInput = Loc.alized.phone_cannot_empty;
      isValid = false;
    } else if (!Validator.validatePhone(_phoneController.text.trim())) {
      _errorPhoneInput = Loc.alized.valid_phone;
      isValid = false;
    } else {
      _errorPhoneInput = '';
    }

    setState(() {});
    return isValid;
  }
}
