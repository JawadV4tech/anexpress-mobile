import 'dart:async';
import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/controllers/theme_controller.dart';
import 'package:anexpress/core/helpers/double_back_to_close_app.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/login/view/login_screen.dart';
import 'package:anexpress/features/register/view/register_one_name.dart';
import 'package:anexpress/features/welcome/components/page_pop_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final themeProvider = Get.find<ThemeController>();
  var pageController = PageController(initialPage: 0);
  List<PageViewData> pageViewModelData = [];

  late Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.add(
      PageViewData(
        titleText: Loc.alized.title_send_money,
        subText: Loc.alized.msg_send_money,
        imagePath: themeProvider.isLightMode
            ? LocalFiles.sendMoneyIllustration
            : LocalFiles.sendMoneyIllustration,
      ),
    );

    pageViewModelData.add(
      PageViewData(
        titleText: Loc.alized.convenient_transfers,
        subText: Loc.alized.msg_convenient_transfers,
        imagePath: themeProvider.isLightMode
            ? LocalFiles.reliableIllustration
            : LocalFiles.reliableIllustration,
      ),
    );

    pageViewModelData.add(
      PageViewData(
        titleText: Loc.alized.exceptionally_reliable,
        subText: Loc.alized.msg_reliable,
        imagePath: themeProvider.isLightMode
            ? LocalFiles.exceptionalIllustration
            : LocalFiles.exceptionalIllustration,
      ),
    );

    sliderTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(MediaQuery.of(context).size.width,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 1) {
        pageController.animateTo(MediaQuery.of(context).size.width * 2,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 2) {
        pageController.animateTo(0,
            duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarTheme();
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: Stack(
          children: [
            Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    pageSnapping: true,
                    onPageChanged: (index) {
                      currentShowIndex = index;
                    },
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      PagePopup(imageData: pageViewModelData[0]),
                      PagePopup(imageData: pageViewModelData[1]),
                      PagePopup(imageData: pageViewModelData[2]),
                    ],
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController, // PageController
                  count: 3,
                  effect: WormEffect(
                      activeDotColor: Theme.of(context).colorScheme.secondary,
                      dotColor: Theme.of(context).dividerColor,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      spacing: 5.0), // your preferred effect
                  onDotClicked: (index) {},
                ),
                const VerticalSpace(30),
                LargeButtonSecondaryColor(
                  title: Loc.alized.lbl_login,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
                const VerticalSpace(20),
                //fcmTest(),
                LargeButtonOutLined(
                  title: "Create a New Profile",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterOneNameScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom + 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
