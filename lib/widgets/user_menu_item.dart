import 'package:anexpress/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class UserSearchItem extends StatelessWidget {
  const UserSearchItem({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: AppColors.gray5001),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black900,
                  fontSize: 18,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondary,
            )
          ],
        ),
      ),
    );
  }
}
