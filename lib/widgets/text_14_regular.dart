import 'package:flutter/material.dart';
import 'package:anexpress/exports/core_export.dart';

class Text14Regular extends StatelessWidget {
  const Text14Regular(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: getFontSize(14),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
