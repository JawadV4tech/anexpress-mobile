import 'package:flutter/material.dart';
import 'package:anexpress/exports/core_export.dart';

class Text16Regular extends StatelessWidget {
  const Text16Regular(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: getFontSize(16),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
