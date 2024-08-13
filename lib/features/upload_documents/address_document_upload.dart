// ignore_for_file: depend_on_referenced_packages, undefined_hidden_name, use_build_context_synchronously, unused_local_variable

import 'dart:io';
import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/home_screen/home_screen.dart';
import 'package:anexpress/features/upload_documents/components/file_upload_button.dart';
import 'package:anexpress/features/upload_documents/components/upload_icon_large.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked_services/stacked_services.dart';

class AddressDocumentUpload extends StatefulWidget {
  const AddressDocumentUpload({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressDocumentUpload> createState() => _AddressDocumentUploadState();
}

class _AddressDocumentUploadState extends State<AddressDocumentUpload> {
  final SnackbarService _snackbarService = locator<SnackbarService>();

  File? _imageFile;
  final picker = ImagePicker();
  bool isBusy = false;
  String title = "Address Document";

  @override
  void initState() {
    super.initState();
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      _imageFile = File(pickedFile?.path ?? '');
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
      'addressProof': await MultipartFile.fromFile(_imageFile?.path ?? "",
          filename: "addressProof"),
    });

    try {
      // Set isBusy true to show progress indicator
      setState(() => isBusy = true);

      dio.options.headers["Authorization"] = "Bearer $token";
      response = await dio.post('/address-documents', data: formData);

      "$response".log();

      setState(() => isBusy = false);

      if (response.statusCode == 200) {
        _snackbarService.showSnackbar(
          title: "Success",
          message: "Image Uploaded Successfully",
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

      "Inside Dio error ${e.response} ${e.response?.statusCode}".log();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload $title"),
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
              _imageFile != null
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.primary.withOpacity(0.1),
                      child: Container(
                        padding: getPadding(all: 10),
                        height: 300,
                        child: Image.file(
                          _imageFile!,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : const UploadIconLarge(
                      headingText: "Image Upload", svgName: "id-card"),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    (_imageFile != null)
                        ? FileUploadButton(
                            isBusy: isBusy,
                            onPress:
                                !isBusy ? () => submitFileToBackend() : () {},
                            titleText: "Submit",
                            icon: Icons.autorenew_rounded,
                            noteText:
                                "Note: png/jpeg/jpg file types are allowed to upload",
                          )
                        : Container(),
                    const SizedBox(height: 30),
                    isBusy
                        ? const SizedBox.shrink()
                        : InkWell(
                            onTap: () {
                              pickImage();
                            },
                            child: SelectImageFromGalleryTextWithIcon(
                              title: title,
                            ),
                          ),
                    const SizedBox(height: 50),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectImageFromGalleryTextWithIcon extends StatelessWidget {
  const SelectImageFromGalleryTextWithIcon({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.image,
          size: 50,
          color: AppColors.primary,
        ),
        Text(
          "Select $title",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
