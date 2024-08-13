import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class Text14Medium extends StatelessWidget {
  const Text14Medium(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: getFontSize(16),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
