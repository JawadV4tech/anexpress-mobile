import 'package:flutter/material.dart';

class RemoveFocus extends StatelessWidget {
  const RemoveFocus({Key? key, required this.child, this.onClick})
      : super(key: key);
  final Widget child;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onClick,
      child: child,
    );
  }
}
