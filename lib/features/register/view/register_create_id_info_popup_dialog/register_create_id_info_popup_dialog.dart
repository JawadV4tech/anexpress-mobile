import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

import '../../../../core/controllers/localization_controller.dart';

class RegisterCreateIdInfoPopupDialog extends StatelessWidget {
  const RegisterCreateIdInfoPopupDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getHorizontalSize(378),
      padding: getPadding(left: 12, top: 26, right: 12, bottom: 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.roundedBorder5,
        color: Theme.of(context).canvasColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomImageView(
                svgPath: LocalFiles.imgCloseOrange700,
                height: getSize(15),
                width: getSize(15),
                alignment: Alignment.centerRight,
                margin: getMargin(right: 11),
              ),
            ),
          ),
          Padding(
            padding: getPadding(left: 21, bottom: 20),
            child: const Text20Medium(
              "Password guideline",
            ),
          ),
          Padding(
            padding: getPadding(top: 5),
            child: Divider(
              height: getVerticalSize(1),
              thickness: getVerticalSize(1),
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: getPadding(left: 12, top: 39),
            child: Text18SemiBold(
              Loc.alized.msg_how_to_create_your,
            ),
          ),
          Padding(
            padding: getPadding(left: 10, top: 18),
            child: Text16Regular(
              Loc.alized.msg_you_can_use_alphabets,
            ),
          ),
          Padding(
            padding: getPadding(left: 10, top: 12),
            child: Text16Regular(
              Loc.alized.msg_keep_it_between,
            ),
          ),
          Padding(
            padding: getPadding(left: 10, top: 12),
            child: Text16Regular(
              Loc.alized.msg_avoid_using_names,
            ),
          ),
          Padding(
            padding: getPadding(left: 10, top: 12),
            child: const Text16Regular(
              "Loc.alized.msg_make_sure_your",
            ),
          ),
          Padding(
            padding: getPadding(left: 10, top: 12),
            child: const Text16Regular(
              "Loc.alized.msg_make_sure_your",
            ),
          ),
          Padding(
            padding: getPadding(left: 10, top: 12),
            child: Text16Regular(
              Loc.alized.msg_we_can_also_generate,
            ),
          ),
          CustomButton(
            height: getVerticalSize(36),
            width: getHorizontalSize(166),
            text: "Generate ID",
            margin: getMargin(top: 25),
            padding: ButtonPadding.PaddingAll8,
            fontStyle: ButtonFontStyle.Bold16,
            alignment: Alignment.center,
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  onTapImgClose(BuildContext context) {
    Navigator.pop(context);
  }
}
