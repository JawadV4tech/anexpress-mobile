import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class RedErrorText extends StatelessWidget {
  const RedErrorText({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(left: 20, top: 7),
      child: Text(
        message,
        style: TextStyle(color: Colors.red[900], fontSize: 12),
      ),
    );
  }
}
