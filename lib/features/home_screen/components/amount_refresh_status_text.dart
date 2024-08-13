import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class AmountRefreshStatusText extends StatelessWidget {
  const AmountRefreshStatusText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(
        left: 2,
        top: 3,
      ),
      child: Row(
        children: [
          CustomImageView(
            svgPath: LocalFiles.imgRefresh,
            height: getVerticalSize(11),
            width: getHorizontalSize(12),
            margin: getMargin(bottom: 2),
          ),
          Padding(
            padding: getPadding(
              left: 5,
            ),
            child: Text(
              "Last updated moments ago",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtMontserratRomanSemiBold12,
            ),
          ),
        ],
      ),
    );
  }
}
