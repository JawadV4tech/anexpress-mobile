import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/contact_us/view/components/send_us_message_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountDeleteRequestView extends StatefulWidget {
  const AccountDeleteRequestView({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountDeleteRequestView> createState() =>
      _AccountDeleteRequestViewState();
}

class _AccountDeleteRequestViewState extends State<AccountDeleteRequestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MyWalletAppBar(
        titleText: "Request to Delete Account",
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: getVerticalSize(77),
              padding: getPadding(right: 20),
              child: Center(
                child: Text(
                  Loc.alized.lbl_cancel,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtMontserratRomanMedium16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                VerticalSpace(30),
                SendUsAMessageFormWidget(
                  title: "Send us message to delete account",
                ),
                VerticalSpace(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
