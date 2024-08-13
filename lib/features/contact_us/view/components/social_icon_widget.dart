import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialIconWidget extends StatelessWidget {
  const SocialIconWidget({
    Key? key,
    required this.iconName,
    required this.onTap,
  }) : super(key: key);

  final String iconName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SvgPicture.asset('assets/icons/$iconName.svg'),
      ),
    );
  }
}
