import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch(
      {super.key, this.alignment, this.margin, this.value, this.onChanged});

  final Alignment? alignment;

  final EdgeInsetsGeometry? margin;

  final bool? value;

  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildSwitchWidget(),
          )
        : _buildSwitchWidget();
  }

  _buildSwitchWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: FlutterSwitch(
        value: value ?? false,
        height: getHorizontalSize(20),
        width: getHorizontalSize(41),
        toggleSize: 14,
        borderRadius: getHorizontalSize(
          10.00,
        ),
        activeColor: AppColors.secondary,
        activeToggleColor: AppColors.gray5001,
        inactiveColor: AppColors.gray40001,
        inactiveToggleColor: AppColors.gray5001,
        onToggle: (value) {
          onChanged!(value);
        },
      ),
    );
  }
}
