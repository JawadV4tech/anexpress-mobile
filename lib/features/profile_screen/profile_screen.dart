import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/controllers/theme_controller.dart';
import 'package:anexpress/core/models/language_model.dart';
import 'package:anexpress/core/themes/themes.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/profile_screen/components/my_account_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  bool isNotificationsSelected = false;

  bool isDarkMode = false;
  var country = 'Australia';
  var currency = '\$ AUD';
  int selectedRadioTile = 0;

  @override
  void initState() {
    super.initState();
    checkIsDarkMode();
  }

  checkIsDarkMode() {
    bool isThemeSetToLightMode = Get.find<ThemeController>().isLightMode;

    setState(() {
      isDarkMode = !isThemeSetToLightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Get.find<ThemeController>();
    return Scaffold(
      appBar: CustomAppBar(
        height: getVerticalSize(88),
        leadingWidth: 40,
        centerTitle: true,
        title: Text(
          "text: Loc.alized.lbl_my_account",
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: getPadding(top: 5, bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyAccountListTile(
                  title: "dark_mode",
                  leadingWidget: CustomSwitch(
                    margin: getMargin(top: 3, bottom: 1),
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                      if (value) {
                        themeProvider.updateThemeMode(ThemeModeType.dark);
                      }

                      if (!value) {
                        themeProvider.updateThemeMode(ThemeModeType.light);
                      }
                    },
                  ),
                ),
                MyAccountListTile(
                  title: "language",
                  leadingWidget: InkWell(
                    onTap: () {
                      _getLanguageUI();
                    },
                    child: Row(
                      children: [
                        Text(Get.find<Loc>().locale.languageCode),
                        const SizedBox(width: 7),
                        Icon(
                          Icons.translate_outlined,
                          color: AppTheme.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: getPadding(left: 30, top: 31, bottom: 5),
                    child: const Text(
                      "title: Loc.alized.log_out",
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildArrowImageRight() {
    return Icon(Icons.arrow_forward, color: Theme.of(context).hintColor);
  }

  onTapBtnEditicon(BuildContext context) {}

  onTapArrowleft12(BuildContext context) {
    Navigator.pop(context);
  }

  _getLanguageUI() {
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
            child: Card(
              color: AppTheme.backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 8),
                    child: Text(
                      "Loc.alized.selected_language",
                      // style: TextStyle(context)
                      //     .getBoldStyle()
                      //     .copyWith(fontSize: 22),
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
