// ignore_for_file: depend_on_referenced_packages, undefined_hidden_name, use_build_context_synchronously, unused_local_variable

import 'dart:convert';

import 'package:anexpress/core/config/api_constants.dart';
import 'package:anexpress/core/config/shared_preferences_helpers.dart';
import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/upload_documents/components/document_upoad_status_widget.dart';
import 'package:anexpress/widgets/overlay_animated_spinner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UploadDocumentsView extends StatefulWidget {
  const UploadDocumentsView({
    super.key,
  });

  @override
  State<UploadDocumentsView> createState() => _UploadDocumentsViewState();
}

class _UploadDocumentsViewState extends State<UploadDocumentsView> {
  // final String url =
  //     'https://mdepayments.epdq.co.uk/ncol/test/orderstandard.asp';

  @override
  void didUpdateWidget(UploadDocumentsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    fetchResponse(); // Run the code every time the widget is updated
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme();
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: fetchResponse(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: OverLayAnimatedSpinner(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              "${json.decode(snapshot.data ?? "")}".log();
              final data = json.decode(snapshot.data ?? "");

              return UploadDocumentsChildView(
                addressVerifyStatus: data!['address_verify'],
                identityVerifyStatus: data!['identity_verify'],
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }

  Future<String> fetchResponse() async {
    final token = await SharedPreferencesHelpers()
        .getStringData(key: PrefKeys.authTokenPrefKey);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse(getDocumentStatusApi));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    "${response.stream}".log();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return response.reasonPhrase ?? "";
    }
  }
}

class UploadDocumentsChildView extends StatelessWidget {
  const UploadDocumentsChildView({
    super.key,
    required this.identityVerifyStatus,
    required this.addressVerifyStatus,
  });

  final int identityVerifyStatus;
  final int addressVerifyStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.maxFinite,
          padding: getPadding(left: 13, top: 23, right: 13, bottom: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BackArrowButton(arrowColor: AppColors.gray60001),
              Padding(
                padding: getPadding(left: 2, top: 10, bottom: 8),
                child: const Text24SemiBold("Upload Documents"),
              ),
              Padding(
                padding: getPadding(bottom: 30),
                child: const Text16Regular(
                    "Upload Documents to verify your Identity"),
              ),
              DocumentUploadStatusWidget(
                uploadStatus: addressVerifyStatus,
                isAddressUpload: true,
              ),
              DocumentUploadStatusWidget(
                uploadStatus: identityVerifyStatus,
                isAddressUpload: false,
              ),
            ],
          )),
    );
  }
}
