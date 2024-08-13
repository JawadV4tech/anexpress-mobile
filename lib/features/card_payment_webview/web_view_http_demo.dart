import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/home_screen/home_screen.dart';
import 'package:anexpress/features/payment_card_feature/data/payment_card_response_model.dart';
import 'package:anexpress/widgets/overlay_animated_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:http/http.dart' as http;

class WebViewHttpDemo extends StatefulWidget {
  const WebViewHttpDemo({
    super.key,
    required this.paymentData,
  });

  final PaymentCardResponseModel paymentData;

  @override
  State<WebViewHttpDemo> createState() => _WebViewHttpDemoState();
}

class _WebViewHttpDemoState extends State<WebViewHttpDemo> {
  bool goBackHome = false;
  bool isLoading = true;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  String url = "";
  bool htmlContainsCode = false;
  double progress = 0;
  int infoCount = 0;
  final urlController = TextEditingController();

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      displayZoomControls: true,
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: getPadding(left: 10, top: 10),
          child: IconButton(
            onPressed: () {
              if (goBackHome) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
              } else {
                Navigator.pop(context);
              }
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.whiteA700,
            ),
          ),
        ),
        title: const Text(
          "Credit/Debit Card Payment",
        ),
      ),
      body: FutureBuilder(
        future: fetchResponse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: OverLayAnimatedSpinner());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return InAppWebView(
              key: webViewKey,
              initialData: InAppWebViewInitialData(
                data: snapshot.data ?? "",
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                "💻💻💻💻💻💻onLoadStart $url".log();

                if (url.toString() == "************" ||
                    url.toString().contains('order_Agree')) {
                  setState(() {
                    goBackHome = true;
                  });
                }

                if (url.toString() == "************") {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false,
                  );
                }
              },
              onLoadStop: (controller, url) async {
                "onLoadStop url $url".log();
              },
              onLoadError: (controller, url, code, message) async {
                "onLoadError url $url".log();
                "onLoadError code $code".log();
                "onLoadError message ${message.toString()}".log();
              },
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              onConsoleMessage: (controller, consoleMessage) {
                ('inside consoleMessage:  $consoleMessage').log();
                String message = consoleMessage.message;
                String sourceURL = consoleMessage.messageLevel.toString();

                String logMessage = 'Console message: $message\n'
                    'Source URL: $sourceURL\n';

                (logMessage).log();
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Future<String> fetchResponse() async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var request = http.Request('POST', Uri.parse(widget.paymentData.url ?? ""));

    // final amount = double.parse(widget.paymentCardResponseModel.totalAmount!)
    //     .toStringAsFixed(2);

    Map<String, String> map = {
      'AMOUNT': "${widget.paymentData.totalAmount}",
      'CURRENCY': '${(widget.paymentData.currency)?.trim()}',
      'LANGUAGE': 'en_US',
      'ORDERID': '${(widget.paymentData.transaction)?.trim()}',
      'PSPID': '${(widget.paymentData.pspid)?.trim()}',
      'SHASIGN': '${(widget.paymentData.shasign)?.trim()}',
      'CN': '${(widget.paymentData.cn)?.trim()}',
      'EMAIL': '${(widget.paymentData.email)?.trim()}',
      'RECIPIENTDOB': '${(widget.paymentData.dob)?.trim()}',
    };


    "$map".log();

    request.bodyFields = map;

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return response.reasonPhrase ?? "";
    }
  }
}
