import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/contact_us/view/components/send_us_message_form_widget.dart';
import 'package:anexpress/features/settings_screen/widgets/setting_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MyWalletAppBar(
        titleText: "Contact Us",
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: getPadding(top: 20, left: 10, right: 35, bottom: 10),
                  child: const Text20MediumOrange(
                      "Your message means a world to us"),
                ),
                SettingListTile(
                  iconPath: LocalFiles.iconLocation,
                  title: "Office Address",
                  subTitle: "208a Whitechapel Road, London, E1 1BJ",
                  onTap: () {},
                ),
                SettingListTile(
                  iconPath: LocalFiles.iconEmail,
                  title: "Email Address",
                  subTitle: "info@anexpress.com",
                  onTap: () async {
                    final Uri params = Uri(
                      scheme: 'mailto',
                      path: 'info@anexpress.com',
                      query:
                          'subject=A N Express App Contact Us&body=App Version 1.0.0', //add subject and body here
                    );

                    var url = params.toString();

                    await _launchUrl(url);
                  },
                ),
                SettingListTile(
                  iconPath: LocalFiles.supportIcon,
                  title: "Phone Number",
                  subTitle: "+44 20 7426 0113",
                  onTap: () async {
                    await _launchUrl("tel://+44 20 7426 0113");
                  },
                ),
                SettingListTile(
                  iconPath: LocalFiles.iconWhatsApp,
                  title: "WhatsApp",
                  subTitle: "Tap here to speak with our customer care dept",
                  onTap: () async {
                    var whatsappUrl = "whatsapp://send?phone=+44748 329516"
                        "&text=${Uri.encodeComponent("Write your message")}";
                    await _launchUrl(whatsappUrl);
                  },
                ),
                const VerticalSpace(30),
                const SendUsAMessageFormWidget(title: 'Get In Touch'),
                const VerticalSpace(30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlToShare) async {
    final Uri url = Uri.parse(urlToShare);

    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
