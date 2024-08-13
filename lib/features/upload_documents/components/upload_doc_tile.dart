import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class UploadDocTile extends StatelessWidget {
  const UploadDocTile({
    super.key,
    required this.iconPath,
    required this.uploadStatus,
    required this.title,
    required this.onTapUpload,
  });

  final String title;
  final String iconPath;
  final int uploadStatus;
  final VoidCallback onTapUpload;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(bottom: 30),
      child: Row(
        children: [
          Row(
            children: [
              CustomImageView(
                svgPath: iconPath,
                height: getVerticalSize(32),
                width: getHorizontalSize(25),
                color: AppColors.gray60001,
              ),
              const SizedBox(width: 10),
              Text20SemiBold(title)
            ],
          ),
          const Spacer(),
          if (uploadStatus == 0 || uploadStatus == 3)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.secondary,
                backgroundColor: Colors.white,
                side: BorderSide(
                  color: AppColors.secondary,
                  width: 2.0,
                ),
              ),
              onPressed: onTapUpload,
              child: const Text(
                'Upload',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
