import 'package:flutter/material.dart';

class DashedBorderDivider extends StatelessWidget {
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final Color color;

  const DashedBorderDivider({
    super.key,
    this.strokeWidth = 1.0,
    this.dashWidth = 2.0,
    this.dashSpace = 2.0,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final dividerWidth = constraints.maxWidth;
            final dashCount =
                (dividerWidth / (dashWidth + dashSpace)).floorToDouble();

            return CustomPaint(
              painter: DashedBorderPainter(
                strokeWidth: strokeWidth,
                dashWidth: dashWidth,
                dashSpace: dashSpace,
                dashCount: dashCount,
                color: color,
              ),
              child: SizedBox(
                width: double.infinity,
                height: strokeWidth,
              ),
            );
          },
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double dashCount;
  final Color color;

  DashedBorderPainter({
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.dashCount,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    var startX = 0.0;
    var startY = size.height / 2;
    //var endX = size.width;
    var endY = size.height / 2;

    final path = Path();
    for (var i = 0; i < dashCount; i++) {
      path.moveTo(startX, startY);
      path.lineTo(startX + dashWidth, endY);
      startX += dashWidth + dashSpace;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.dashCount != dashCount ||
        oldDelegate.color != color;
  }
}
