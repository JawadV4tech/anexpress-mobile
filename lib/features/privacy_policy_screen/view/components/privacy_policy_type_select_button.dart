import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/styles/app_style.dart';
import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyTypeSelectButton extends StatelessWidget {
  const PrivacyPolicyTypeSelectButton({
    Key? key,
    required this.isSelected,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: getMargin(right: 15),
        height: 60,
        width: size.width * 0.40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: isSelected ? AppColors.secondary : Colors.white, width: 2),
        ),
        child: Center(
          child: Text(
            title,
            maxLines: null,
            textAlign: TextAlign.center,
            style: AppStyle.txtMontserratRomanMedium16Orange700,
          ),
        ),
      ),
    );
  }
}
