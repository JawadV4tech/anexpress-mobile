import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class SearchInfoText extends StatelessWidget {
  const SearchInfoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.secondary,
            size: 16.0,
          ),
          const SizedBox(width: 4.0),
          const Text(
            "For existing recipients, click search icon",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
