import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CommonTextFieldView extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? errorText;
  final bool isObscureText, isAllowTopTitleView;
  final EdgeInsetsGeometry padding;
  final Function(String)? onChanged;
  final VoidCallback? toggleObscure;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final double textFieldBoxHeight;
  final TextCapitalization textCapitalization;
  final FocusNode focusNode;
  final VoidCallback? onEditingComplete;

  const CommonTextFieldView({
    Key? key,
    this.hintText = '',
    this.isObscureText = false,
    this.padding = const EdgeInsets.only(),
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.isAllowTopTitleView = true,
    this.errorText,
    required this.labelText,
    required this.controller,
    required this.focusNode,
    this.toggleObscure,
    this.textFieldBoxHeight = 50,
    this.textCapitalization = TextCapitalization.words,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: textFieldBoxHeight,
            child: Center(
              child: TextField(
                focusNode: focusNode,
                controller: controller,
                textCapitalization: textCapitalization,
                maxLines: 1,
                onChanged: onChanged,
                style: TextStyle(color: AppColors.gray60001),
                obscureText: isObscureText,
                cursorColor: Theme.of(context).primaryColor,
                textInputAction: TextInputAction.next,
                onEditingComplete: onEditingComplete ??
                    () {
                      FocusScope.of(context).nextFocus();
                    },
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: toggleObscure != null
                      ? isObscureText
                          ? IconButton(
                              icon: Icon(Icons.visibility_off,
                                  color: AppColors.gray60001, size: 25),
                              onPressed: toggleObscure,
                            )
                          : IconButton(
                              icon: Icon(Icons.visibility,
                                  color: AppColors.gray60001, size: 25),
                              onPressed: toggleObscure,
                            )
                      : null,
                  //labelText: labelText,
                  hintText: labelText,
                  labelStyle: TextStyle(color: AppColors.gray60001),
                  hintStyle: TextStyle(
                    color: AppColors.gray60001,
                    fontSize: getFontSize(16),
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gray60001),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gray60001),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),

                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gray60001),
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                keyboardType: keyboardType,
              ),
            ),
          ),
          if (errorText != null && errorText != '')
            Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 16, top: 4, bottom: 4),
              child: Text(
                errorText ?? "",
                style: TextStyle(
                  color: Colors.red.shade900,
                  fontSize: 12,
                ),
              ),
            )
        ],
      ),
    );
  }
}
