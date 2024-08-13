import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final double size;
  final Color color;

  const CircleWidget({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: 2.0,
        ),
      ),
      child: Container(
        width: size,
        height: size,
        margin: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
