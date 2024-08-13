import 'package:anexpress/core/controllers/localization_controller.dart';

import 'components/notifications_list_tile.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWalletAppBar(titleText: Loc.alized.lbl_notifications),
      body: SafeArea(
        child: Padding(
          padding: getPadding(left: 16, top: 22, right: 23),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(height: getVerticalSize(24));
            },
            itemCount: 7,
            itemBuilder: (context, index) {
              return const NotificationListTile();
            },
          ),
        ),
      ),
    );
  }
}
