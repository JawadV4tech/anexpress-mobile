import 'package:flutter/material.dart';
import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({
    Key? key,
    required this.titleText,
    this.actions,
    required this.subTitle,
    required this.avatar,
  }) : super(key: key);

  final String titleText;
  final String subTitle;
  final String avatar;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      height: getVerticalSize(77),
      leadingWidth: 37,
      leading: const BackArrowButton(),
      title: Row(
        children: [
          const HorizontalSpace(20),
          const HorizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text24SemiBoldWhite(titleText),
              Text16BoldWhite(subTitle),
            ],
          ),
        ],
      ),
      styleType: Style.bgGradientIndigo700Indigo900,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(getVerticalSize(77));
}
