import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.titleColor,
    required this.onTap,
  });

  final String title;
  final Color bgColor;
  final Color titleColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: getMargin(left: 15),
        padding: getPadding(left: 40, top: 10, right: 40, bottom: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: titleColor,
              fontSize: getFontSize(16),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
