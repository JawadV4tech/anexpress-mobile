import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/notifications_screen/notifications_screen.dart';
import 'package:flutter/material.dart';

class AppBarActionsRow extends StatelessWidget {
  const AppBarActionsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImageView(
          svgPath: LocalFiles.supportIcon,
          height: getVerticalSize(28),
          width: getHorizontalSize(40),
          //margin: getMargin(top: 1, right: 1, bottom: 107),
          onTap: () {},
        ),
        CustomImageView(
          svgPath: LocalFiles.notificationIcon,
          height: getVerticalSize(28),
          width: getHorizontalSize(40),
          //margin: getMargin(top: 1, right: 1, bottom: 107),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NotificationsScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}
