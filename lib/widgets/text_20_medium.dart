import 'package:flutter/material.dart';
import 'package:anexpress/exports/core_export.dart';

class Text20Medium extends StatelessWidget {
  const Text20Medium(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: getFontSize(20),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
