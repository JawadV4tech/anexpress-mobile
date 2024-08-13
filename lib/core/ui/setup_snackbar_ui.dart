import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/enums/snackbar_type.dart';
import 'package:anexpress/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerSnackbarConfig(SnackbarConfig(
    backgroundColor: AppColors.secondary,
    textColor: Colors.white,
    mainButtonTextColor: Colors.white,
    borderRadius: 10,
  ));

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.secondary,
    config: SnackbarConfig(
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: AppColors.secondary,
      textColor: AppColors.whiteA700,
      borderRadius: 1,
      dismissDirection: DismissDirection.horizontal,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.greenAndRed,
    config: SnackbarConfig(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      titleColor: Colors.green,
      messageColor: Colors.red,
      borderRadius: 1,
    ),
  );
}
