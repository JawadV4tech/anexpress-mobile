import 'package:anexpress/core/utils/size_utils.dart';
import 'package:anexpress/widgets/text_16_regular.dart';
import 'package:anexpress/widgets/text_18_semibold.dart';
import 'package:flutter/material.dart';

class PrivacyTextSection extends StatelessWidget {
  const PrivacyTextSection({
    super.key,
    required this.title,
    required this.detailText,
  });

  final String title;
  final String detailText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: getPadding(left: 18, top: 24),
          child: Text18SemiBold(title),
        ),
        Container(
          margin: getMargin(left: 18, top: 12, right: 37),
          child: Text16Regular(
            detailText,
          ),
        ),
      ],
    );
  }
}
