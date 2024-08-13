import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class Text18SemiBold extends StatelessWidget {
  const Text18SemiBold(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: getFontSize(18),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
