import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/utils/size_utils.dart';
import 'package:anexpress/features/countries_feature/data/country_info_model.dart';
import 'package:flutter/material.dart';

class CountryDropDown extends StatelessWidget {
  const CountryDropDown({
    super.key,
    this.shape,
    this.padding,
    this.variant,
    this.fontStyle,
    this.alignment,
    this.width,
    this.margin,
    this.focusNode,
    this.autofocus = false,
    this.icon,
    this.hintText,
    this.prefix,
    this.prefixConstraints,
    this.items,
    this.onChanged,
    this.validator,
  });

  final DropDownShape? shape;

  final DropDownPadding? padding;

  final DropDownVariant? variant;

  final DropDownFontStyle? fontStyle;

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final FocusNode? focusNode;

  final bool? autofocus;

  final Widget? icon;

  final String? hintText;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final List<CountryInfoModel>? items;

  final Function(CountryInfoModel)? onChanged;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildDropDownWidget(context),
          )
        : _buildDropDownWidget(context);
  }

  _buildDropDownWidget(BuildContext context) {
    return Container(
      width: width ?? double.maxFinite,
      margin: margin,
      child: DropdownButtonFormField(
        focusNode: focusNode,
        autofocus: autofocus!,
        icon: icon,
        style: _setFontStyle(),
        decoration: _buildDecoration(context),
        items: items!.map((CountryInfoModel item) {
          return DropdownMenuItem<CountryInfoModel>(
            value: item,
            child: Text(item.name ?? ""),
          );
        }).toList(),
        onChanged: (value) {
          onChanged!(value!);
        },
      ),
    );
  }

  _buildDecoration(BuildContext context) {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: _setFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      fillColor: Theme.of(context).cardColor,
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle() {
    switch (fontStyle) {
      case DropDownFontStyle.MontserratRomanMedium18:
        return TextStyle(
          color: AppColors.gray600,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        );
      default:
        return TextStyle(
          color: AppColors.gray700,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            5.00,
          ),
        );
    }
  }

  _setBorderStyle() {
    switch (variant) {
      case DropDownVariant.OutlineGray40001:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: AppColors.gray40001,
            width: 1,
          ),
        );
      case DropDownVariant.None:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: AppColors.gray60001,
            width: 1,
          ),
        );
    }
  }

  _setFillColor() {
    switch (variant) {
      case DropDownVariant.OutlineGray40001:
        return AppColors.whiteA700;
      default:
        return AppColors.whiteA700;
    }
  }

  _setFilled() {
    switch (variant) {
      case DropDownVariant.OutlineGray40001:
        return true;
      case DropDownVariant.None:
        return false;
      default:
        return true;
    }
  }

  _setPadding() {
    switch (padding) {
      case DropDownPadding.PaddingT19:
        return getPadding(
          left: 8,
          top: 19,
          bottom: 19,
        );
      default:
        return getPadding(
          left: 12,
          top: 15,
          bottom: 15,
        );
    }
  }
}

enum DropDownShape {
  RoundedBorder5,
}

enum DropDownPadding {
  PaddingT20,
  PaddingT19,
}

enum DropDownVariant {
  None,
  OutlineGray60001,
  OutlineGray40001,
}

enum DropDownFontStyle {
  InterMedium16,
  MontserratRomanMedium18,
}
