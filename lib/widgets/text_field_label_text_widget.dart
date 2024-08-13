import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/widgets/text_20_medium.dart';
import 'package:flutter/material.dart';

class TextFieldLabelTextWidget extends StatelessWidget {
  const TextFieldLabelTextWidget(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 12),
      child: Text20Medium(title),
    );
  }
}
