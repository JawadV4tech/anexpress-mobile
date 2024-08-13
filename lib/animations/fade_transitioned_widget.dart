import 'package:flutter/material.dart';

class FadeTransitionedWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeTransitionedWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(
      milliseconds: 500,
    ),
  }) : super(key: key);

  @override
  State<FadeTransitionedWidget> createState() => _FadeTransitionedWidgetState();
}

class _FadeTransitionedWidgetState extends State<FadeTransitionedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void didUpdateWidget(FadeTransitionedWidget oldWidget) {
    if (widget.child != oldWidget.child) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: widget.child,
    );
  }
}
