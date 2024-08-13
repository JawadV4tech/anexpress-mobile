import 'package:anexpress/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class LargeYellowHeading extends StatelessWidget {
  const LargeYellowHeading({
    Key? key,
    required this.headingText,
    required this.fontSize,
  }) : super(key: key);

  final String headingText;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        headingText,
        style: TextStyle(
          color: AppColors.orange7006c,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
