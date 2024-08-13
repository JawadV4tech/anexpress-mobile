import 'package:anexpress/core/styles/app_colors.dart';
import 'package:anexpress/core/styles/text_styles.dart';
import 'package:anexpress/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class PagePopup extends StatelessWidget {
  final PageViewData imageData;

  const PagePopup({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 8,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 120,
              child: AspectRatio(
                aspectRatio: 1,
                child: CustomImageView(
                  imagePath: imageData.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            imageData.titleText,
            textAlign: TextAlign.center,
            style: TextStyles(context).getTitleStyle().copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              imageData.subText,
              textAlign: TextAlign.center,
              style: TextStyles(context).getDescriptionStyle(),
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
      ],
    );
  }
}

class PageViewData {
  final String titleText;
  final String subText;
  final String imagePath;

  PageViewData({
    required this.titleText,
    required this.subText,
    required this.imagePath,
  });
}
