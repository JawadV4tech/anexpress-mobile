import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class SideDrawerListTile extends StatelessWidget {
  const SideDrawerListTile({
    super.key,
    required this.title,
    required this.svgPath,
    required this.onTap,
  });

  final String title;
  final String svgPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(
        top: 31,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CustomImageView(
              svgPath: svgPath,
              height: getVerticalSize(
                32,
              ),
              width: getHorizontalSize(
                25,
              ),
              color: AppColors.gray60001,
            ),
            Padding(
              padding: getPadding(left: 34),
              child: Text20Medium(title),
            ),
          ],
        ),
      ),
    );
  }
}
