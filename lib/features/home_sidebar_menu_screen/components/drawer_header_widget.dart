import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/features/home_sidebar_menu_screen/components/drawer_shapes_bg.dart';
import 'package:anexpress/features/home_sidebar_menu_screen/components/profile_image_widget.dart';
import 'package:anexpress/features/login/bloc/login_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userData = (context.read<LoginBloc>().state as LoginLoaded).userInfo;
    return Container(
      color: AppColors.primaryDark,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: getPadding(left: 30, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              ProfileImageWidget(
                image: userData.photo ??
                    '***********',
              ),
              Text(
                "${userData.firstname} ${userData.lastname}",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtMontserratRomanSemiBold32,
              ),
              Text(
                "${userData.email}",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtMontserratRomanSemiBold20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
