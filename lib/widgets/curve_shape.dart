import 'package:anexpress/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class CurveShape extends StatelessWidget {
  const CurveShape({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CurvePath(
          marginTop: 0,
          bg: AppColors.secondary,
        ),
        CurvePath(
          marginTop: 10,
          bg: AppColors.whiteA700,
        ),
        CurvePath(
          marginTop: 10,
          bg: AppColors.orange7006c,
        ),
        CurvePath(
          marginTop: 20,
          bg: Theme.of(context).canvasColor,
        ),
      ],
    );
  }
}

class CurvePath extends StatelessWidget {
  const CurvePath({
    Key? key,
    required this.bg,
    required this.marginTop,
  }) : super(key: key);

  final Color bg;
  final double marginTop;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: ClipPath(
        clipper: ProsteBezierCurve(
          position: ClipPosition.top,
          list: [
            BezierCurveSection(
              start: Offset(screenWidth, 15),
              top: Offset(screenWidth / 2, 40),
              end: const Offset(0, 20),
            ),
          ],
        ),
        child: Container(
          color: bg,
          height: 90,
        ),
      ),
    );
  }
}
