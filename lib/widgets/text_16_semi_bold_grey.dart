import 'package:flutter/material.dart';
import 'package:anexpress/exports/core_export.dart';

class Text16SemiBoldGrey extends StatelessWidget {
  const Text16SemiBoldGrey(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: isLightMode() ? AppColors.gray700 : Colors.grey,
        fontSize: getFontSize(
          16,
        ),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
