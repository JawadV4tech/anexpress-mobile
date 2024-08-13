import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/controllers/theme_controller.dart';
import 'package:anexpress/core/models/language_model.dart';
import 'package:anexpress/core/themes/themes.dart';

import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/settings_screen/widgets/setting_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Get.find<ThemeController>();

    return Scaffold(
      appBar: MyWalletAppBar(titleText: Loc.alized.lbl_setting),
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: getPadding(left: 19, top: 33, right: 19, bottom: 33),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SettingListTile(
                iconPath: LocalFiles.imgUserGray600,
                title: Loc.alized.msg_account_and_privacy,
                subTitle: Loc.alized.msg_privacy_and_security,
                onTap: () {},
              ),
              SettingListTile(
                iconPath: LocalFiles.imgAlarm,
                title: Loc.alized.msg_notifications_settings,
                subTitle: Loc.alized.msg_payments_chats_and,
                onTap: () {},
              ),
              SettingListTile(
                iconPath: LocalFiles.imgChatIcon,
                title: Loc.alized.lbl_chat_settings,
                subTitle: Loc.alized.msg_history_and_backup,
                onTap: () {},
              ),
              SettingListTile(
                iconPath: LocalFiles.imgComputerGray600,
                title: Loc.alized.msg_manage_trusted_devices,
                subTitle: Loc.alized.msg_logged_in_devices,
                onTap: () {},
              ),
              SettingListTile(
                iconPath: LocalFiles.imgLightbulb,
                title: Loc.alized.lbl_appearance,
                subTitle: Loc.alized.msg_light_dark_mode,
                onTap: () {
                  if (themeProvider.isLightMode) {
                    themeProvider.updateThemeMode(ThemeModeType.dark);
                  } else {
                    themeProvider.updateThemeMode(ThemeModeType.light);
                  }
                },
              ),
              SettingListTile(
                iconPath: LocalFiles.languageIcon,
                title: Loc.alized.lbl_language,
                subTitle: Loc.alized.msg_language,
                onTap: () {
                  _getLanguageUI(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getLanguageUI(BuildContext context) {
    final List<Widget> languageArray = [];
    final list = getLocalesFromLanguageModels();
    List<String> languageTexts = getLanguageNamesFromLanguageModels();

    for (var i = 0; i < list.length; i++) {
      final element = list[i];
      languageArray.add(
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            Get.find<Loc>().localeLanguage(element);
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, bottom: 16, top: 16, right: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Get.find<Loc>().locale == element
                    ? const Icon(Icons.radio_button_checked)
                    : const Icon(Icons.radio_button_off),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(languageTexts[i]),
                      const SizedBox(width: 10),
                      Text(
                        getFlagFromLanguageTitle(languageTexts[i]),
                        style: TextStyle(fontSize: getFontSize(18)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 240,
            child: CommonCard(
              color: AppTheme.backgroundColor,
              radius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                    child: Text(
                      Loc.alized.selected_language,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 22,
                            color: AppTheme.primaryTextColor,
                          ),
                    ),
                  ),
                  const Divider(
                    height: 16,
                  ),
                  for (var item in languageArray) item,
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
