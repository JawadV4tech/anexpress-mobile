import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/utils/size_utils.dart';
import 'package:anexpress/widgets/app_bar/appbar_subtitle.dart';
import 'package:anexpress/widgets/back_arrow_button.dart';
import 'package:flutter/material.dart';

class MyWalletAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyWalletAppBar({Key? key, required this.titleText, this.actions})
      : super(key: key);

  final String titleText;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryDark,
      toolbarHeight: getVerticalSize(77),
      leadingWidth: 37,
      leading: const BackArrowButton(),
      title: AppbarSubtitle(
        text: titleText,
        margin: getMargin(left: 22),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(getVerticalSize(77));
}
