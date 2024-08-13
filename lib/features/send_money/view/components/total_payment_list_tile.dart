import 'package:anexpress/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class TotalPaymentValueListTile extends StatelessWidget {
  const TotalPaymentValueListTile({
    super.key,
    required this.title,
    required this.value,
    required this.discountedValue,
  });

  final String title;
  final String value;
  final String discountedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          title: Text(title),
          trailing: SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors.secondary,
                    decorationThickness: 1.0,
                  ),
                ),
                const SizedBox(width: 5),
                Text(discountedValue),
              ],
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
