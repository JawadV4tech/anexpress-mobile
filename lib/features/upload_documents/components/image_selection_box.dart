import 'dart:io';

import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class ImageSelectionBox extends StatelessWidget {
  const ImageSelectionBox({
    super.key,
    required this.imageFile,
    required this.errorImage,
    required this.onTap,
    required this.title,
  });

  final String title;
  final File? imageFile;
  final String errorImage;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: getPadding(all: 10),
              height: 300,
              width: MediaQuery.of(context).size.width * 0.40,
              child: imageFile != null
                  ? Image.file(
                      imageFile!,
                      fit: BoxFit.contain,
                    )
                  : Center(
                      child: Text(
                      title,
                      textAlign: TextAlign.center,
                    )),
            ),
          ),
          if (errorImage != "") RedErrorText(message: errorImage),
        ],
      ),
    );
  }
}
