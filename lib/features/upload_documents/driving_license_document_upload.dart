// ignore_for_file: depend_on_referenced_packages, undefined_hidden_name, use_build_context_synchronously, unused_local_variable

import 'dart:io';
import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/core/helpers/loading/loading_screen.dart';
import 'package:anexpress/core/values/string_values.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/home_screen/home_screen.dart';
import 'package:anexpress/features/upload_documents/components/image_selection_box.dart';
import 'package:anexpress/widgets/common_text_field_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked_services/stacked_services.dart';

class DrivingDocumentUpload extends StatefulWidget {
  const DrivingDocumentUpload({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<DrivingDocumentUpload> createState() => _DrivingDocumentUploadState();
}

class _DrivingDocumentUploadState extends State<DrivingDocumentUpload> {
  final SnackbarService _snackbarService = locator<SnackbarService>();

  String _errorPassport = '';
  late TextEditingController _passportController;

  String _errorAddress = '';
  late TextEditingController _addressController;

  @override
  void initState() {
    _passportController = TextEditingController();
    _addressController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _passportController.dispose();
    _addressController.dispose();

    super.dispose();
  }

  File? _imageFile1;
  String _errorImage1 = "";
  File? _imageFile2;
  String _errorImage2 = "";
  final picker = ImagePicker();
  bool isBusy = false;

  Future pickImage1() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      _imageFile1 = File(pickedFile?.path ?? '');
    });
  }

  Future pickImage2() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      _imageFile2 = File(pickedFile?.path ?? '');
    });
  }

  /// Submit File/Image to backend API

  Future<void> submitFileToBackend() async {
    "submitFileToBackend".log();
    final token = await SharedPreferencesHelpers()
        .getStringData(key: PrefKeys.authTokenPrefKey);

    Response response;
    var dio = Dio(BaseOptions(
      baseUrl: apiBaseUrl,
      responseType: ResponseType.json,
      contentType: 'multipart/form-data',
    ));

    var formData = FormData.fromMap({
      'identity_type': 'driving-license',
      'PassportNumber': _passportController.text.trim(),
      'Address': _addressController.text.trim(),
      'FrontPage': await MultipartFile.fromFile(
        _imageFile1?.path ?? "",
        filename: "FrontPage",
      ),
      'RearPage': await MultipartFile.fromFile(
        _imageFile2?.path ?? "",
        filename: "RearPageRearPage",
      ),
    });

    try {
      // Set isBusy true to show progress indicator
      setState(() => isBusy = true);
      LoadingScreen().show(context: context, text: "");

      dio.options.headers["Authorization"] = "Bearer $token";
      response = await dio.post('/documents', data: formData);

      "$response".log();

      setState(() => isBusy = false);
      LoadingScreen().hide();

      if (response.statusCode == 200) {
        _snackbarService.showSnackbar(
          title: "Success",
          message: "KYC request has been submitted.",
        );

        // Wait 3 seconds before navigating back to the upload Selection Screen
        await Future.delayed(const Duration(seconds: 3));
        // Navigate back to Home Screen
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false, // Remove all routes from the stack
        );
      } else {
        _snackbarService.showSnackbar(
          title: "error_messages.error",
          message: 'Error Uploading Image',
        );
      }
    } on DioException catch (e) {
      setState(() => isBusy = false);
      LoadingScreen().hide();

      "Inside Dio error ${e.response} ${e.response?.statusCode}".log();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ImageSelectionBox(
                  title: "Upload\nFront Image",
                  imageFile: _imageFile1,
                  errorImage: _errorImage1,
                  onTap: () async {
                    await pickImage1();
                  },
                ),
                const SizedBox(width: 10),
                ImageSelectionBox(
                  title: "Upload\nRear Image",
                  imageFile: _imageFile2,
                  errorImage: _errorImage2,
                  onTap: () async {
                    await pickImage2();
                  },
                ),
              ]),
              Padding(
                padding: getPadding(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Padding(
                      padding: getPadding(top: 22),
                      child: const Text20Medium("Passport Number"),
                    ),
                    CommonTextFieldView(
                      controller: _passportController,
                      focusNode: FocusNode(),
                      errorText: _errorPassport,
                      labelText: "",
                      keyboardType: TextInputType.text,
                      onChanged: (String txt) {},
                      textCapitalization: TextCapitalization.none,
                    ),
                    Padding(
                      padding: getPadding(top: 22),
                      child: const Text20Medium("Address"),
                    ),
                    CommonTextFieldView(
                      controller: _addressController,
                      focusNode: FocusNode(),
                      errorText: _errorAddress,
                      labelText: "",
                      keyboardType: TextInputType.text,
                      onChanged: (String txt) {},
                      textCapitalization: TextCapitalization.none,
                    ),
                    const VerticalSpace(40),
                    LargeButtonSecondaryColor(
                      marginLeft: 0,
                      marginRight: 0,
                      title: "Submit",
                      onTap: () {
                        if (_allValidation()) {
                          if (!isBusy) submitFileToBackend();
                        } else {
                          "form error".log();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _allValidation() {
    bool isValid = true;

    if (_imageFile1 == null) {
      isValid = false;
      _errorImage1 = "Required";
    } else {
      _errorImage1 = "";
    }

    if (_imageFile2 == null) {
      isValid = false;
      _errorImage2 = "Required";
    } else {
      _errorImage2 = "";
    }

    if (_passportController.text.trim().isEmpty) {
      _errorPassport = StringValues.required_text;
      isValid = false;
    } else {
      _errorPassport = '';
    }

    if (_addressController.text.trim().isEmpty) {
      _errorAddress = StringValues.required_text;
      isValid = false;
    } else {
      _errorAddress = '';
    }

    setState(() {});
    return isValid;
  }
}
