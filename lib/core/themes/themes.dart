import 'package:anexpress/core/controllers/theme_controller.dart';
import 'package:anexpress/core/enums/enums.dart';
import 'package:anexpress/core/styles/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static bool get isLightMode {
    try {
      return Get.find<ThemeController>().isLightMode;
    } catch (e) {
      return true;
    }
  }

  // colors
  static Color get primaryColor => AppColors.primary;
  static Color get secondaryColor => AppColors.secondary;

  static Color get scaffoldBackgroundColor =>
      isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF141A21);

  static Color get backIconColor =>
      isLightMode ? const Color(0xFF000000) : const Color(0xFFFFFFFF);

  static Color get redErrorColor =>
      isLightMode ? const Color(0xFFAC0000) : const Color(0xFFAC0000);

  // static Color get productCardImageBg =>
  //     isLightMode ? AppColors.gray100 : AppColors.gray90002;

  // static Color get bottomNavigationBarBg =>
  //     isLightMode ? ColorConstant.whiteA700 : AppColors.gray90002;

  static Color get backgroundColor =>
      isLightMode ? const Color(0xFFFFFFFF) : const Color(0xFF2C2C2C);

  static Color get primaryTextColor =>
      isLightMode ? const Color(0xFF262626) : const Color(0xFFFFFFFF);

  static Color get secondaryTextColor =>
      isLightMode ? const Color(0xFFADADAD) : const Color(0xFF6D6D6D);

  static Color get whiteColor => const Color(0xFFFFFFFF);
  static Color get backColor => const Color(0xFF262626);

  static Color get fontColor =>
      isLightMode ? const Color(0xFF1A1A1A) : const Color(0xFFF7F7F7);

  // static Color get borderColor =>
  //     isLightMode ? AppColors.gray300 : AppColors.blueGray900;

  static ThemeData get getThemeData =>
      isLightMode ? _buildLightTheme() : _buildDarkTheme();

  static TextTheme _buildTextTheme(TextTheme base) {
    FontFamilyType fontType = FontFamilyType.poppins;
    try {
      fontType = Get.find<ThemeController>().fontType;
    } catch (_) {}

    return base.copyWith(
      displayLarge: getTextStyle(fontType, base.displayLarge!), //f-size 96
      displayMedium: getTextStyle(fontType, base.displayMedium!), //f-size 60
      displaySmall: getTextStyle(fontType, base.displaySmall!), //f-size 48
      headlineMedium: getTextStyle(fontType, base.headlineMedium!), //f-size 34
      headlineSmall: getTextStyle(fontType, base.headlineSmall!), //f-size 24
      titleLarge: getTextStyle(
        fontType,
        base.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ), //f-size 20
      labelLarge: getTextStyle(fontType, base.labelLarge!), //f-size 14
      bodySmall: getTextStyle(fontType, base.bodySmall!), //f-size 12
      bodyLarge: getTextStyle(fontType, base.bodyLarge!), //f-size 16
      bodyMedium: getTextStyle(fontType, base.bodyMedium!), //f-size 14
      titleMedium: getTextStyle(
        fontType,
        base.titleMedium!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ), //f-size 16
      titleSmall: getTextStyle(fontType, base.titleSmall!), //f-size 14
      labelSmall: getTextStyle(fontType, base.labelSmall!), //f-size 10
    );
  }

// we also get some Light and Dark color variants
  static Color getColor(ColorType colorData) {
    switch (colorData) {
      case ColorType.verdigris:
        return isLightMode ? const Color(0xFF4FBE9F) : const Color(0xFF4FBE9F);
      case ColorType.malibu:
        return isLightMode ? const Color(0xFF5DCAEC) : const Color(0xFF5DCAEC);
      case ColorType.darkSkyBlue:
        return isLightMode ? const Color(0xFF458CEA) : const Color(0xFF458CEA);
      case ColorType.bilobaFlower:
        return isLightMode ? const Color(0xFFff5f5f) : const Color(0xFFff5f5f);
      case ColorType.maroon:
        return isLightMode ? const Color(0xFFF13005) : const Color(0xFFF13005);
    }
  }

  static TextStyle getTextStyle(
      FontFamilyType fontFamilyType, TextStyle textStyle) {
    switch (fontFamilyType) {
      case FontFamilyType.montserrat:
        return GoogleFonts.montserrat(textStyle: textStyle);
      case FontFamilyType.workSans:
        return GoogleFonts.workSans(textStyle: textStyle);
      case FontFamilyType.varela:
        return GoogleFonts.varela(textStyle: textStyle);
      case FontFamilyType.roboto:
        return GoogleFonts.roboto(textStyle: textStyle);
      case FontFamilyType.openSans:
        return GoogleFonts.openSans(textStyle: textStyle);
      case FontFamilyType.lato:
        return GoogleFonts.lato(textStyle: textStyle);
      case FontFamilyType.oswald:
        return GoogleFonts.oswald(textStyle: textStyle);
      case FontFamilyType.sourceSansPro:
        return GoogleFonts.sourceSansPro(textStyle: textStyle);
      case FontFamilyType.raleway:
        return GoogleFonts.raleway(textStyle: textStyle);
      case FontFamilyType.pTSans:
        return GoogleFonts.ptSans(textStyle: textStyle);
      case FontFamilyType.poppins:
        return GoogleFonts.poppins(textStyle: textStyle);
      case FontFamilyType.beVietnamPro:
        return GoogleFonts.beVietnamPro(textStyle: textStyle);
      default:
        return GoogleFonts.beVietnamPro(textStyle: textStyle);
    }
  }

  static ThemeData _buildLightTheme() {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );

    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      canvasColor: scaffoldBackgroundColor,
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: colorScheme.copyWith(background: backgroundColor),
    );
  }

  static ThemeData _buildDarkTheme() {
    final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      canvasColor: scaffoldBackgroundColor,
      buttonTheme: _buttonThemeData(colorScheme),
      dialogTheme: _dialogTheme(),
      cardTheme: _cardTheme(),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: colorScheme.copyWith(background: backgroundColor),
    );
  }

  static ButtonThemeData _buttonThemeData(ColorScheme colorScheme) {
    return ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    );
  }

  static DialogTheme _dialogTheme() {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0,
      backgroundColor: backgroundColor,
    );
  }

  static CardTheme _cardTheme() {
    return CardTheme(
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      shadowColor: secondaryTextColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(0),
    );
  }

  static get mapCardDecoration => BoxDecoration(
        color: AppTheme.backIconColor,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppTheme.getThemeData.dividerColor,
              offset: const Offset(4, 4),
              blurRadius: 8.0),
        ],
      );
  static get buttonDecoration => BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.getThemeData.dividerColor,
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      );
  static get searchBarDecoration => BoxDecoration(
        color: AppTheme.backIconColor,
        borderRadius: const BorderRadius.all(Radius.circular(38)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.getThemeData.dividerColor,
            blurRadius: 8,
            // offset: Offset(4, 4),
          ),
        ],
      );

  static get boxDecoration => BoxDecoration(
        color: AppTheme.backIconColor,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.getThemeData.dividerColor,
            //   offset: Offset(2, 2),
            blurRadius: 8,
          ),
        ],
      );
}

enum ThemeModeType {
  system,
  dark,
  light,
}
