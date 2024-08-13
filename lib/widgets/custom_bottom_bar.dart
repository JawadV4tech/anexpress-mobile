// ignore_for_file: constant_identifier_names

import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key, this.onChanged});

  final Function(BottomBarEnum)? onChanged;

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      iconSelected: LocalFiles.imgHome,
      iconUnSelected: LocalFiles.imgHomeGray700,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      iconSelected: LocalFiles.imgTicket,
      iconUnSelected: LocalFiles.imgTicket,
      type: BottomBarEnum.Cards,
    ),
    BottomMenuModel(
      iconSelected: LocalFiles.imgMaximize,
      iconUnSelected: LocalFiles.imgMaximize,
      type: BottomBarEnum.Transactions,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.indigo50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            getHorizontalSize(
              30,
            ),
          ),
          topRight: Radius.circular(
            getHorizontalSize(
              30,
            ),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black9003f,
            spreadRadius: getHorizontalSize(2),
            blurRadius: getHorizontalSize(2),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              svgPath: bottomMenuList[index].iconUnSelected,
              height: getSize(26),
              width: getSize(26),
            ),
            activeIcon: CustomImageView(
              svgPath: bottomMenuList[index].iconSelected,
              height: getVerticalSize(23),
              width: getHorizontalSize(24),
              color: AppColors.secondary,
            ),
            label: getLabel(bottomMenuList[index].type),
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Home,
  Cards,
  Transactions,
}

String getLabel(BottomBarEnum type) {
  String label = "";

  if (type == BottomBarEnum.Home) {
    label = "Home";
  }

  if (type == BottomBarEnum.Cards) {
    label = "Cards";
  }

  if (type == BottomBarEnum.Transactions) {
    label = "Transactions";
  }

  return label;
}

class BottomMenuModel {
  BottomMenuModel({
    required this.iconSelected,
    required this.iconUnSelected,
    required this.type,
  });

  final String iconSelected;
  final String iconUnSelected;
  final BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
