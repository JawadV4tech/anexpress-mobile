// ignore_for_file: constant_identifier_names

import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.padding,
    this.variant,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.validator,
    this.onValueChange,
    this.textFieldBoxHeight = 55,
    this.onEditingComplete,
  });

  final TextFormFieldPadding? padding;

  final TextFormFieldVariant? variant;

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? isObscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final FormFieldValidator<String>? validator;
  final Function(String)? onValueChange;
  final double textFieldBoxHeight;
  final VoidCallback? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(context),
          )
        : _buildTextFormFieldWidget(context);
  }

  _buildTextFormFieldWidget(BuildContext context) {
    return Container(
      width: width ?? double.maxFinite,
      margin: margin,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        style: _setFontStyle(),
        obscureText: isObscureText!,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        validator: validator,
        onChanged: onValueChange,
        onEditingComplete: onEditingComplete ??
            () {
              FocusScope.of(context).nextFocus();
            },
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: _setFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle() {
    return TextStyle(
      color: AppColors.gray60001,
      fontSize: getFontSize(16),
      fontWeight: FontWeight.w400,
    );
  }

  _setBorderStyle() {
    switch (variant) {
      case TextFormFieldVariant.OutlineGray60028:
        return const OutlineInputBorder(
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.OutlineBluegray900:
        return OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.gray60001,
            width: 1,
          ),
        );
      case TextFormFieldVariant.FillGray90002:
        return const OutlineInputBorder(
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.None:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.gray60001,
            width: 1,
          ),
        );
    }
  }

  _setFillColor() {
    switch (variant) {
      case TextFormFieldVariant.OutlineGray60028:
        return AppColors.whiteA700;
      case TextFormFieldVariant.FillGray90002:
        return AppColors.gray60001;
      default:
        return null;
    }
  }

  _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.OutlineGray300:
        return false;
      case TextFormFieldVariant.OutlineGray60028:
        return true;
      case TextFormFieldVariant.OutlineBluegray900:
        return false;
      case TextFormFieldVariant.FillGray90002:
        return true;
      case TextFormFieldVariant.None:
        return false;
      default:
        return false;
    }
  }

  _setPadding() {
    switch (padding) {
      case TextFormFieldPadding.PaddingT17:
        return getPadding(
          left: 12,
          top: 17,
          right: 12,
          bottom: 17,
        );
      case TextFormFieldPadding.PaddingT90:
        return getPadding(
          left: 20,
          top: 90,
          right: 20,
          bottom: 90,
        );
      case TextFormFieldPadding.PaddingT16:
        return getPadding(
          top: 16,
          bottom: 16,
        );
      case TextFormFieldPadding.PaddingAll14:
        return getPadding(
          all: 14,
        );
      default:
        return getPadding(
          all: 18,
        );
    }
  }
}

enum TextFormFieldPadding {
  PaddingAll17,
  PaddingT17,
  PaddingT90,
  PaddingT16,
  PaddingAll14,
}

enum TextFormFieldVariant {
  None,
  OutlineGray300,
  OutlineGray60028,
  OutlineBluegray900,
  FillGray90002,
}
