import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NotificationListTile extends StatelessWidget {
  const NotificationListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: getPadding(
            all: 20,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.indigo200,
          ),
          child: const Text16BoldWhite("MT"),
        ),
        const HorizontalSpace(15),
        const SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text18SemiBold("Mobile Top-Up"),
                  Text16Regular("01:29 PM"),
                ],
              ),
              VerticalSpace(10),
              Text16Regular(
                "You have topped up R1,50 to+27 564 4643",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
