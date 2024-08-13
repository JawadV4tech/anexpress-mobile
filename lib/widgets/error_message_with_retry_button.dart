import 'package:anexpress/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class ErrorMessageWithRetryButton extends StatelessWidget {
  const ErrorMessageWithRetryButton({
    Key? key,
    required this.message,
    required this.onTap,
  }) : super(key: key);

  final String message;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
