import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      color: AppColors.deepPurple100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.circleBorder50,
      ),
      child: Container(
        height: getSize(
          100,
        ),
        width: getSize(
          100,
        ),
        decoration: AppDecoration.fillDeeppurple100.copyWith(
          borderRadius: BorderRadiusStyle.circleBorder50,
        ),
        child: Stack(
          children: [
            CustomImageView(
              url: image,
              height: getVerticalSize(
                97,
              ),
              width: getHorizontalSize(
                100,
              ),
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
