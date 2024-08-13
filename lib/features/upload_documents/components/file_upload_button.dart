import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class FileUploadButton extends StatelessWidget {
  const FileUploadButton({
    Key? key,
    required this.titleText,
    required this.icon,
    required this.noteText,
    required this.onPress,
    required this.isBusy,
  }) : super(key: key);

  final String titleText;
  final IconData icon;
  final String noteText;
  final VoidCallback onPress;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (isBusy) {
              return;
            } else {
              onPress();
            }
          },
          child: Container(
              width: MediaQuery.of(context).size.width * .7,
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 55,
              decoration: gradientBoxDecoration,
              child: isBusy
                  ? const Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white)))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(titleText,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Icon(icon, color: Colors.white, size: 30),
                      ],
                    )),
        ),
      ],
    );
  }
}

/// style variables

var gradientBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      AppColors.primary,
      AppColors.primary.withOpacity(0.4),
    ],
  ),
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(10),
);
