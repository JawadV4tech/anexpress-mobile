import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.margin,
      this.onTap,
      this.width,
      this.height,
      this.text,
      this.prefixWidget,
      this.suffixWidget});

  final ButtonShape? shape;

  final ButtonPadding? padding;

  final ButtonVariant? variant;

  final ButtonFontStyle? fontStyle;

  final Alignment? alignment;

  final EdgeInsetsGeometry? margin;

  final VoidCallback? onTap;

  final double? width;

  final double? height;

  final String? text;

  final Widget? prefixWidget;

  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: TextButton(
        onPressed: onTap,
        style: _buildTextButtonStyle(),
        child: _buildButtonWithOrWithoutIcon(),
      ),
    );
  }

  _buildButtonWithOrWithoutIcon() {
    if (prefixWidget != null || suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixWidget ?? const SizedBox(),
          Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: _setFontStyle(),
          ),
          suffixWidget ?? const SizedBox(),
        ],
      );
    } else {
      return Text(
        text ?? "",
        textAlign: TextAlign.center,
        style: _setFontStyle(),
      );
    }
  }

  _buildTextButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(
        width ?? double.maxFinite,
        height ?? getVerticalSize(40),
      ),
      padding: _setPadding(),
      backgroundColor: _setColor(),
      side: _setTextButtonBorder(),
      shape: RoundedRectangleBorder(
        borderRadius: _setBorderRadius(),
      ),
    );
  }

  _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingAll8:
        return getPadding(
          all: 8,
        );
      case ButtonPadding.PaddingAll12:
        return getPadding(
          all: 12,
        );
      case ButtonPadding.PaddingAll17:
        return getPadding(
          all: 17,
        );
      case ButtonPadding.PaddingT12:
        return getPadding(
          top: 12,
          right: 12,
          bottom: 12,
        );
      default:
        return getPadding(
          left: 14,
          top: 15,
          right: 14,
          bottom: 15,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.FillSecondary:
        return AppColors.secondary;
      case ButtonVariant.FillGray400:
        return AppColors.gray400;
      case ButtonVariant.FillOrange7006c:
        return AppColors.orange7006c;
      case ButtonVariant.OutlineOrange700_1:
        return AppColors.whiteA700;
      case ButtonVariant.FillIndigo70087:
        return AppColors.indigo70087;
      case ButtonVariant.FillIndigo100:
        return AppColors.indigo100;
      case ButtonVariant.OutlineOrange700:
        return null;
      default:
        return AppColors.primary;
    }
  }

  _setTextButtonBorder() {
    switch (variant) {
      case ButtonVariant.OutlineOrange700:
        return BorderSide(
          color: AppColors.secondary,
          width: getHorizontalSize(
            1.00,
          ),
        );
      case ButtonVariant.OutlineOrange700_1:
        return BorderSide(
          color: AppColors.secondary,
          width: getHorizontalSize(
            2.00,
          ),
        );
      case ButtonVariant.FillSecondary:
      case ButtonVariant.FillOrange700:
      case ButtonVariant.FillGray400:
      case ButtonVariant.FillOrange7006c:
      case ButtonVariant.FillIndigo70087:
      case ButtonVariant.FillIndigo100:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.CircleBorder30:
        return BorderRadius.circular(
          getHorizontalSize(
            30.00,
          ),
        );
      case ButtonShape.RoundedBorder10:
        return BorderRadius.circular(
          getHorizontalSize(
            10.00,
          ),
        );
      case ButtonShape.RoundedBorder2:
        return BorderRadius.circular(
          getHorizontalSize(
            2.00,
          ),
        );
      case ButtonShape.RoundedBorder20:
        return BorderRadius.circular(
          getHorizontalSize(
            20.00,
          ),
        );
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            7.00,
          ),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.Bold16:
        return TextStyle(
          color: AppColors.whiteA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.Bold16Gray60001:
        return TextStyle(
          color: AppColors.gray60001,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.Bold16Orange700:
        return TextStyle(
          color: AppColors.secondary,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        );
      case ButtonFontStyle.SemiBold20:
        return TextStyle(
          color: AppColors.secondary,
          fontSize: getFontSize(
            20,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.SemiBold16:
        return TextStyle(
          color: AppColors.whiteA700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.Medium232:
        return TextStyle(
          color: AppColors.secondary,
          fontSize: getFontSize(
            23.2,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        );
      case ButtonFontStyle.Medium16:
        return TextStyle(
          color: AppColors.gray90001,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        );
      default:
        return TextStyle(
          color: AppColors.whiteA700,
          fontSize: getFontSize(
            23.2,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        );
    }
  }
}

enum ButtonShape {
  Square,
  CircleBorder30,
  RoundedBorder7,
  RoundedBorder10,
  RoundedBorder2,
  RoundedBorder20,
}

enum ButtonPadding {
  PaddingT15,
  PaddingAll8,
  PaddingAll12,
  PaddingAll17,
  PaddingT12,
}

enum ButtonVariant {
  FillSecondary,
  FillOrange700,
  FillGray400,
  OutlineOrange700,
  FillOrange7006c,
  OutlineOrange700_1,
  FillIndigo70087,
  FillIndigo100,
}

enum ButtonFontStyle {
  SemiBold24,
  Bold16,
  Bold16Gray60001,
  Bold16Orange700,
  SemiBold20,
  SemiBold16,
  Medium232,
  Medium16,
}
