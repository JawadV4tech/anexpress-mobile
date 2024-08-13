import 'package:flutter/material.dart';

class CalculationValueListTile extends StatelessWidget {
  const CalculationValueListTile({
    super.key,
    required this.title,
    required this.value,
    this.isShowInColumn = false,
  });

  final String title;
  final String value;
  final bool isShowInColumn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isShowInColumn
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14, // Font size for the title
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(value),
                  ],
                ),
              )
            : ListTile(
                dense: true,
                title: Text(title),
                trailing: Text(value),
              ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
