import 'package:anexpress/exports/common_export.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:flutter/material.dart';

class PaymentListTile extends StatelessWidget {
  const PaymentListTile({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            const SizedBox(width: 10),
            Text16Regular(
              value,
            ),
          ],
        ),
        Padding(
          padding: getPadding(top: 20, bottom: 20),
          child: const Divider(height: 1, thickness: 1),
        ),
      ],
    );
  }
}
