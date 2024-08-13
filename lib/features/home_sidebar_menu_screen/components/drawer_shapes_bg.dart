import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class DrawerShapesBg extends StatelessWidget {
  const DrawerShapesBg({
    super.key,
    required this.widget,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          //height: 200,
          margin: getMargin(
            right: 0,
          ),
          padding: getPadding(
            left: 8,
            top: 10,
            right: 8,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Padding(
                  padding: getPadding(
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: getPadding(
                          right: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: getVerticalSize(
                                          109,
                                        ),
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            CustomImageView(
                                              svgPath: LocalFiles.imgComputer,
                                              height: getSize(
                                                20,
                                              ),
                                              width: getSize(
                                                20,
                                              ),
                                              alignment: Alignment.bottomLeft,
                                            ),
                                          ],
                                        ),
                                      ),
                                      CustomImageView(
                                        svgPath: LocalFiles.imgGrid,
                                        height: getSize(
                                          20,
                                        ),
                                        width: getSize(
                                          20,
                                        ),
                                        margin: getMargin(
                                          left: 4,
                                          top: 75,
                                          bottom: 14,
                                        ),
                                      ),
                                      CustomImageView(
                                        svgPath: LocalFiles.imgVolume,
                                        height: getVerticalSize(
                                          18,
                                        ),
                                        width: getHorizontalSize(
                                          20,
                                        ),
                                        margin: getMargin(
                                          left: 18,
                                          top: 34,
                                          bottom: 56,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: getPadding(
                                left: 5,
                                top: 13,
                                bottom: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomImageView(
                                        svgPath: LocalFiles.imgUserGray40001,
                                        height: getVerticalSize(
                                          22,
                                        ),
                                        width: getHorizontalSize(
                                          20,
                                        ),
                                        margin: getMargin(
                                          bottom: 23,
                                        ),
                                      ),
                                      CustomImageView(
                                        svgPath: LocalFiles.imgSave,
                                        height: getVerticalSize(
                                          32,
                                        ),
                                        width: getHorizontalSize(
                                          38,
                                        ),
                                        margin: getMargin(
                                          left: 31,
                                          top: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomImageView(
                                    svgPath: LocalFiles.imgCart,
                                    height: getSize(
                                      20,
                                    ),
                                    width: getSize(
                                      20,
                                    ),
                                    alignment: Alignment.centerRight,
                                    margin: getMargin(
                                      top: 8,
                                      right: 15,
                                    ),
                                  ),
                                  CustomImageView(
                                    svgPath: LocalFiles.imgComputer,
                                    height: getSize(
                                      20,
                                    ),
                                    width: getSize(
                                      20,
                                    ),
                                    margin: getMargin(
                                      left: 7,
                                      top: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //newMethod(),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: widget,
        )
      ],
    );
  }
}
