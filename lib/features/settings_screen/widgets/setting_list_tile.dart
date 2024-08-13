import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  final String iconPath;
  final String title;
  final String subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: getPadding(left: 7, bottom: 20, top: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              svgPath: iconPath,
              height: getVerticalSize(27),
              width: getHorizontalSize(35),
              margin: getMargin(top: 7, bottom: 9),
              color: AppColors.gray600,
            ),
            Expanded(
              child: Padding(
                padding: getPadding(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text18SemiBold(title),
                    Padding(
                      padding: getPadding(top: 1),
                      child: Text16Regular(subTitle),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
