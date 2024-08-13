import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class Text14MediumBlack extends StatelessWidget {
  const Text14MediumBlack(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: getFontSize(14),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        color: AppColors.black90001,
      ),
    );
  }
}
