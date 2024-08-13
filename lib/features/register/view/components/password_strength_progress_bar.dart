import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class PasswordStrengthProgressBar extends StatelessWidget {
  const PasswordStrengthProgressBar({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getVerticalSize(5),
      width: getHorizontalSize(MediaQuery.of(context).size.width * 0.5),
      decoration: BoxDecoration(
          color: AppColors.blueGray10001,
          borderRadius: BorderRadius.circular(getHorizontalSize(5))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(getHorizontalSize(5)),
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.blueGray10001,
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.secondary,
          ),
        ),
      ),
    );
  }
}
