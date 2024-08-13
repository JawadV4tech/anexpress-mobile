import 'package:anexpress/core/extensions/string_hardcoded.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class CurveShapeHeader extends StatelessWidget {
  const CurveShapeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getVerticalSize(
        215,
      ),
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.maxFinite,
              margin: getMargin(
                bottom: 47,
              ),
              padding: getPadding(
                left: 24,
                top: 18,
                right: 24,
                bottom: 18,
              ),
              decoration: AppDecoration.gradientIndigo700Indigo900,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLogoWidget(height: 45, width: 45),
                  const SizedBox(width: 10),
                  const Text32SemiBoldWhite("A N Express"),
                  const Spacer(),
                  Padding(
                    padding: getPadding(
                      bottom: 84,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel".hardcoded,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: AppStyle.txtMontserratRomanMedium16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const CurveShape(),
        ],
      ),
    );
  }
}
