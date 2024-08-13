import 'package:anexpress/core/styles/app_style.dart';
import 'package:anexpress/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppbarSubtitle extends StatelessWidget {
  AppbarSubtitle({
    required this.text,
    this.margin,
    this.onTap,
  });

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: AppStyle.txtMontserratRomanSemiBold232.copyWith(
            color: AppColors.whiteA700,
          ),
        ),
      ),
    );
  }
}
