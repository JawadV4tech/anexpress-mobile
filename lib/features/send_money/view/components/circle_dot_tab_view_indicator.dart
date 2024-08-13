import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/send_money/view/components/circle_widget.dart';
import 'package:anexpress/features/send_money/view/components/dashed_border_divider.dart';
import 'package:flutter/material.dart';

class CircleDotTabViewIndicator extends StatelessWidget {
  const CircleDotTabViewIndicator({
    super.key,
    required this.activeTabIndex,
  });

  final int activeTabIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: getMargin(
        top: 10,
        bottom: 3,
        left: 25,
        right: 25,
      ),
      child: Row(
        children: [
          CircleWidget(
            size: 12,
            color: activeTabIndex >= 0
                ? AppColors.secondary
                : Theme.of(context).dividerColor,
          ),
          DashedBorderDivider(
            color: activeTabIndex >= 1
                ? AppColors.secondary
                : Theme.of(context).dividerColor,
          ),
          CircleWidget(
            size: 12,
            color: activeTabIndex >= 1
                ? AppColors.secondary
                : Theme.of(context).dividerColor,
          ),
          DashedBorderDivider(
            color: activeTabIndex >= 2
                ? AppColors.secondary
                : Theme.of(context).dividerColor,
          ),
          CircleWidget(
            size: 12,
            color: activeTabIndex >= 2
                ? AppColors.secondary
                : Theme.of(context).dividerColor,
          ),
          DashedBorderDivider(
            color: activeTabIndex >= 3
                ? AppColors.secondary
                : Theme.of(context).dividerColor,
          ),
          CircleWidget(
            size: 12,
            color: activeTabIndex >= 3
                ? AppColors.secondary
                : Theme.of(context).dividerColor,
          ),
          DashedBorderDivider(
            color: activeTabIndex >= 4
                ? AppColors.secondary
                : Theme.of(context).dividerColor,
          ),
          CircleWidget(
            size: 12,
            color: activeTabIndex >= 4
                ? AppColors.secondary
                : Theme.of(context).dividerColor,
          ),
        ],
      ),
    );
  }
}
