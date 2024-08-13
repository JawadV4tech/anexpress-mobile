import 'package:anexpress/core/utils/size_utils.dart';
import 'package:anexpress/core/values/local_files.dart';
import 'package:anexpress/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class QuestionMarkIconRoundButton extends StatelessWidget {
  const QuestionMarkIconRoundButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      svgPath: LocalFiles.imgQuestion,
      height: getSize(30),
      width: getSize(30),
      alignment: Alignment.topRight,
      margin: getMargin(right: 10),
      onTap: onTap,
    );
  }
}
