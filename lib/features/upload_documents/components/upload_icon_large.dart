import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UploadIconLarge extends StatelessWidget {
  const UploadIconLarge({
    Key? key,
    required this.headingText,
    required this.svgName,
  }) : super(key: key);

  final String headingText;
  final String svgName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.3),
          ],
        ),
      ),
      width: double.maxFinite,
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  "assets/svg/$svgName.svg",
                  width: size.width * 0.4,
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 20,
                    child: Icon(
                      Icons.upload_sharp,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              headingText,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
