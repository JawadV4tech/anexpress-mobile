import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
    required this.openDrawer,
  });


  final VoidCallback openDrawer;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Container(
            height: getSize(120),
            width: double.maxFinite,
            padding: getPadding(left: 13, top: 25, right: 13, bottom: 25),
            decoration: AppDecoration.gradientIndigo700Indigo900,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLogoWidget(height: getSize(45), width: getSize(45)),
                    SizedBox(width: getSize(10)),
                    const Text32SemiBoldWhite("A N Express"),
                  ],
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              openDrawer();
            },
            child: Padding(
              padding: getPadding(all: 30),
              child: CustomImageView(
                svgPath: LocalFiles.imgMenu,
                height: getSize(21),
                width: getSize(21),
                onTap: () {
                  openDrawer();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
