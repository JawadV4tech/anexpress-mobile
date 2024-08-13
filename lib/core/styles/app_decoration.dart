import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class AppDecoration {
  static BoxDecoration get outlineGray60001 => BoxDecoration(
        color: AppColors.whiteA700,
        border: Border.all(
          color: AppColors.gray60001,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineWhiteA7002 => BoxDecoration(
        color: AppColors.deepPurple100,
        border: Border.all(
          color: AppColors.whiteA700,
          width: getHorizontalSize(
            3,
          ),
        ),
      );
  static BoxDecoration get fillIndigo50 => BoxDecoration(
        color: AppColors.indigo50,
      );
  static BoxDecoration get outlineWhiteA700 => BoxDecoration(
        color: AppColors.indigo200,
        border: Border.all(
          color: AppColors.whiteA700,
          width: getHorizontalSize(
            5,
          ),
        ),
      );
  static BoxDecoration get gradientIndigo700Indigo20001 => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(
            1,
            0.96,
          ),
          end: const Alignment(
            0,
            0.04,
          ),
          colors: [
            AppColors.primary,
            AppColors.indigo20001,
          ],
        ),
      );
  static BoxDecoration get txtFillWhiteA700 => BoxDecoration(
        color: AppColors.whiteA700,
      );
  static BoxDecoration get txtFillIndigo200 => BoxDecoration(
        color: AppColors.indigo200,
      );
  static BoxDecoration get txtFillIndigo100 => BoxDecoration(
        color: AppColors.indigo100,
      );
  static BoxDecoration get txtFillIndigo70087 => BoxDecoration(
        color: AppColors.indigo70087,
      );
  static BoxDecoration get fillIndigo300 => BoxDecoration(
        color: AppColors.indigo300,
      );
  static BoxDecoration get fillIndigo200 => BoxDecoration(
        color: AppColors.indigo200,
      );
  static BoxDecoration get outlineOrange700 => BoxDecoration(
        color: AppColors.whiteA700,
        border: Border.all(
          color: AppColors.secondary,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get fillOrange70063 => BoxDecoration(
        color: AppColors.orange70063,
      );
  static BoxDecoration get outlineWhiteA7001 => BoxDecoration(
        color: AppColors.indigo200,
        border: Border.all(
          color: AppColors.whiteA700,
          width: getHorizontalSize(
            3,
          ),
        ),
      );
  static BoxDecoration get txtOutlineGray60001 => BoxDecoration(
        color: AppColors.whiteA700,
        border: Border.all(
          color: AppColors.gray60001,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineBluegray100 => BoxDecoration(
        color: AppColors.gray50,
        border: Border.all(
          color: AppColors.blueGray100,
          width: getHorizontalSize(
            1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black90014,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              0,
              0,
            ),
          ),
        ],
      );
  static BoxDecoration get fillGray900 => BoxDecoration(
        color: AppColors.gray900,
      );
  static BoxDecoration get fillIndigo700 => BoxDecoration(
        color: AppColors.primary,
      );
  static BoxDecoration get outlineGray7001 => BoxDecoration(
        border: Border.all(
          color: AppColors.gray700,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
  static BoxDecoration get outlineGray40001 => BoxDecoration(
        color: AppColors.whiteA700,
      );
  static BoxDecoration get fillWhiteA70063 => BoxDecoration(
        color: AppColors.whiteA70063,
      );
  static BoxDecoration get fillIndigoA200 => BoxDecoration(
        color: AppColors.indigoA200,
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: AppColors.whiteA700,
      );
  static BoxDecoration get fillDeeppurple100 => BoxDecoration(
        color: AppColors.deepPurple100,
      );
  static BoxDecoration get outlineGray700 => BoxDecoration(
        color: AppColors.whiteA700,
        boxShadow: [
          BoxShadow(
            color: AppColors.gray700,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              3,
              3,
            ),
          ),
        ],
      );
  static BoxDecoration get gradientIndigo700Indigo900 => BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(1, 0.96),
          end: const Alignment(0, 0.04),
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
        ),
      );
  static BoxDecoration get fillOrange700 => BoxDecoration(
        color: AppColors.secondary,
      );
  static BoxDecoration get outlineBlack9003f => BoxDecoration(
        color: AppColors.whiteA700,
        boxShadow: [
          BoxShadow(
            color: AppColors.black9003f,
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      );
  static BoxDecoration get txtFillOrange7004c => BoxDecoration(
        color: AppColors.orange7004c,
      );
  static BoxDecoration get fillGray200 => BoxDecoration(
        color: AppColors.gray200,
      );
  static BoxDecoration get txtFillOrange700 => BoxDecoration(
        color: AppColors.secondary,
      );
  static BoxDecoration get txtFillBluegray10001 => BoxDecoration(
        color: AppColors.blueGray10001,
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorder5 = BorderRadius.circular(
    getHorizontalSize(
      5,
    ),
  );

  static BorderRadius circleBorder25 = BorderRadius.circular(
    getHorizontalSize(
      25,
    ),
  );

  static BorderRadius roundedBorder12 = BorderRadius.circular(
    getHorizontalSize(
      12,
    ),
  );

  static BorderRadius circleBorder30 = BorderRadius.circular(
    getHorizontalSize(
      30,
    ),
  );

  static BorderRadius txtRoundedBorder20 = BorderRadius.circular(
    getHorizontalSize(
      20,
    ),
  );

  static BorderRadius circleBorder65 = BorderRadius.circular(
    getHorizontalSize(
      65,
    ),
  );

  static BorderRadius circleBorder87 = BorderRadius.circular(
    getHorizontalSize(
      87,
    ),
  );

  static BorderRadius roundedBorder22 = BorderRadius.circular(
    getHorizontalSize(
      22,
    ),
  );

  static BorderRadius txtCircleBorder30 = BorderRadius.circular(
    getHorizontalSize(
      30,
    ),
  );

  static BorderRadius txtRoundedBorder10 = BorderRadius.circular(
    getHorizontalSize(
      10,
    ),
  );

  static BorderRadius txtRoundedBorder7 = BorderRadius.circular(
    getHorizontalSize(
      7,
    ),
  );

  static BorderRadius circleBorder50 = BorderRadius.circular(
    getHorizontalSize(
      50,
    ),
  );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
    