import 'package:anexpress/core/utils/size_utils.dart';
import 'package:anexpress/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LargeButtonSecondaryColor extends StatelessWidget {
  const LargeButtonSecondaryColor({
    super.key,
    required this.title,
    required this.onTap,
    this.marginLeft = 15,
    this.marginRight = 15,
  });

  final String title;
  final VoidCallback onTap;
  final double marginLeft;
  final double marginRight;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      height: getVerticalSize(50),
      text: title,
      margin: getMargin(left: marginLeft, right: marginRight),
      fontStyle: ButtonFontStyle.Bold16,
      variant: ButtonVariant.FillSecondary,
      onTap: onTap,
    );
  }
}
