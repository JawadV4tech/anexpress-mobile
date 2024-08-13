import 'package:flutter/material.dart';
import 'package:anexpress/exports/core_export.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: getVerticalSize(1),
      thickness: getVerticalSize(1),
      color: Colors.grey,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
