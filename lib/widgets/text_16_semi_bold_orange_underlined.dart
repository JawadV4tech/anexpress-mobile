import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class Text16SemiBoldOrangeUnderLined extends StatelessWidget {
  const Text16SemiBoldOrangeUnderLined(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: AppColors.secondary,
        fontSize: getFontSize(16),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
