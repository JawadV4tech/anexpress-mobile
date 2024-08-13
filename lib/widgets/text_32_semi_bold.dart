import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class Text32SemiBold extends StatelessWidget {
  const Text32SemiBold(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: getFontSize(32),
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
