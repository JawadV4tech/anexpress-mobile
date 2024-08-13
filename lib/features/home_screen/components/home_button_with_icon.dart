import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class HomeButtonWithIcon extends StatelessWidget {
  const HomeButtonWithIcon({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: getMargin(
            right: 8,
          ),
          padding: getPadding(
            all: 12,
          ),
          decoration: AppDecoration.fillOrange700.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                svgPath: LocalFiles.imgPlus,
                height: getSize(
                  16,
                ),
                width: getSize(
                  16,
                ),
                margin: getMargin(
                  top: 1,
                  bottom: 2,
                ),
              ),
              Padding(
                padding: getPadding(
                  left: 10,
                ),
                child: Text16BoldWhite(title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
