import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/widgets/text_18_semibold_theme.dart';
import 'package:flutter/material.dart';

class HomeBalanceInfoWidget extends StatefulWidget {
  const HomeBalanceInfoWidget({
    super.key,
  });

  @override
  State<HomeBalanceInfoWidget> createState() => _HomeBalanceInfoWidgetState();
}

class _HomeBalanceInfoWidgetState extends State<HomeBalanceInfoWidget> {
  bool isAmountVisible = true;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 110,
            margin: getMargin(left: 16, top: 100, right: 17),
            padding: getPadding(left: 19, top: 10, right: 19, bottom: 10),
            decoration: AppDecoration.outlineBlack9003f.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: getPadding(top: 7),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text18SemiBoldTheme("Locked In Rate"),
                        Text36SemiBoldOrange("556.37 INR"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 120,
            left: 30,
            child: Text(
              "🇮🇳",
              style: TextStyle(fontSize: 40),
            ),
          )
        ],
      ),
    );
  }
}
