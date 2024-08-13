import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class Text24SemiBoldWhite extends StatelessWidget {
  const Text24SemiBoldWhite(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: getFontSize(24),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}
