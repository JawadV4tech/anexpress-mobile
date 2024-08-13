import 'package:flutter/material.dart';
import 'package:anexpress/exports/core_export.dart';

class Text36SemiBoldOrange extends StatelessWidget {
  const Text36SemiBoldOrange(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: AppColors.secondary,
        fontSize: getFontSize(36),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
