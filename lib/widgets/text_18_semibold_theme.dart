import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class Text18SemiBoldTheme extends StatelessWidget {
  const Text18SemiBoldTheme(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.primary,
        fontSize: getFontSize(18),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
