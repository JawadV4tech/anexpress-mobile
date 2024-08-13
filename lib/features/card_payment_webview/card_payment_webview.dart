// ignore_for_file: use_build_context_synchronously

import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/home_screen/home_screen.dart';
import 'package:anexpress/features/payment_card_feature/data/payment_card_response_model.dart';
import 'package:anexpress/widgets/overlay_animated_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CardPaymentWebView extends StatefulWidget {
  const CardPaymentWebView({
    Key? key,
    required this.paymentData,
  }) : super(key: key);

  final PaymentCardResponseModel paymentData;

  @override
  State<CardPaymentWebView> createState() => _CardPaymentWebViewState();
}

class _CardPaymentWebViewState extends State<CardPaymentWebView> {
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Given map of values
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

// Constructing the HTML form
    String htmlForm = """
  <!DOCTYPE html>
  <html>
  <head>
      <title>Auto Submit Form</title>
  </head>
  <body>
      <form id="myForm" action="${widget.paymentData.url ?? ""}" method="POST">
          ${map.entries.map((entry) {
      return '<input type="hidden" name="${entry.key}" value="${entry.value}">';
    }).join()}
      </form>
      <script>
          document.addEventListener('DOMContentLoaded', function() {
              document.getElementById('myForm').submit();
          });
      </script>
  </body>
  </html>
""";

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
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialData: InAppWebViewInitialData(data: htmlForm),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                "onLoadStart $url".log();
                if (url.toString() == "***************" ||
                    url.toString().contains('order_Agree')) {
                  setState(() {
                    goBackHome = true;
                  });
                }
                if (url.toString() == "************" ||
                    url.toString() == "***********") {
                  goHome(context);
                }

                // After order cancel, so navigate back to home
                if (url.toString().contains('?orderID=')) {
                  goHome(context);
                }
              },
              onLoadStop: (controller, url) async {
                "onLoadStop url 🐶🐶🐶🐶🐶 $url".log();

                //https://mdepayments.epdq.co.uk/ncol/test/Order_Cancel.asp
                // if url contains ''Order_Cancel''  After order cancel,
                // so navigate back to home
                if (url.toString().contains('Order_Cancel')) {
                  await Future.delayed(const Duration(seconds: 5));
                  goHome(context);
                }
              },
              onLoadError: (controller, url, code, message) async {
                "onLoadError url 🐶🐶🐶🐶🐶 $url".log();
                "onLoadError code 🐶🐶🐶🐶🐶 $code".log();
                "onLoadError message 🐶🐶🐶🐶🐶 ${message.toString()}".log();
              },
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                return null;
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {}
                setState(() {
                  this.progress = progress / 100;
                  urlController.text = url;
                });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                ('🐶🐶🐶🐶🐶🐶🐶🐶🐶🐶inside consoleMessage:  $consoleMessage')
                    .log();
                String message = consoleMessage.message;
                String sourceURL = consoleMessage.messageLevel.toString();

                String logMessage = 'Console message: $message\n'
                    'Source URL: $sourceURL\n';

                (logMessage).log();
              },
            ),
            progress < 1.0
                ? const Center(child: OverLayAnimatedSpinner())
                : htmlContainsCode
                    ? const Center(child: OverLayAnimatedSpinner())
                    : const Stack(),
          ],
        ),
      ),
    );
  }

  void goHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
  }
}
