import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class Text16BoldWhite extends StatelessWidget {
  const Text16BoldWhite(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: getFontSize(16),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        color: AppColors.whiteA700,
      ),
    );
  }
}
