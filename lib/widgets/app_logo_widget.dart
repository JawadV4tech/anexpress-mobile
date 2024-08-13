import 'package:anexpress/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
    required this.height,
    required this.width,
    this.logoColor = Colors.white,
  });

  final double height;
  final double width;
  final Color logoColor;

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: LocalFiles.imgAnExpressLogo,
      height: getSize(height),
      width: getSize(width),
    );
  }
}
