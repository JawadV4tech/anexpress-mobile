import 'package:flutter/material.dart';
import 'package:anexpress/exports/core_export.dart';

class Text16SemiBoldBlack extends StatelessWidget {
  const Text16SemiBoldBlack(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: AppColors.black90001,
        fontSize: getFontSize(16),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
