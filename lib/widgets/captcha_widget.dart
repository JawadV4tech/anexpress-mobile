import 'package:anexpress/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';

class CaptchaWidget extends StatelessWidget {
  const CaptchaWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: getMargin(top: 27),
      padding: getPadding(all: 7),
      decoration: AppDecoration.outlineBluegray100
          .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            svgPath: LocalFiles.imgRobot,
            height: getVerticalSize(28),
            width: getHorizontalSize(130),
            margin: getMargin(
              left: 6,
              top: 16,
              bottom: 18,
            ),
          ),
          CustomImageView(
            svgPath: LocalFiles.imgReply,
            height: getVerticalSize(62),
            width: getHorizontalSize(66),
          )
        ],
      ),
    );
  }
}
