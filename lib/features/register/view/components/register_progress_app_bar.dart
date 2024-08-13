import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class RegisterProgressAppBar extends StatelessWidget {
  const RegisterProgressAppBar({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackArrowButton(arrowColor: AppColors.gray60001),
        // QuestionMarkIconRoundButton(
        //   onTap: () {
        //     showDialog(
        //       context: context,
        //       builder: (_) => const AlertDialog(
        //         content: RegisterCreateIdInfoPopupDialog(),
        //         backgroundColor: Colors.transparent,
        //         contentPadding: EdgeInsets.zero,
        //         insetPadding: EdgeInsets.only(left: 0),
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
