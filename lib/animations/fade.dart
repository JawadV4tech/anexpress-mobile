import 'package:flutter/material.dart';

/// Controls the fade effect.
enum FadeEffect {
  fadeIn,
  fadeOut,
}

/// A widget which fades its child(ren) based on the [FadeEffect].
class FadeWidget extends StatefulWidget {
  /// The item to fade.
  final Widget? child;

  /// The duration of the [fadeEffect].
  final Duration duration;

  /// Whether to fade-in or fade-out.
  final FadeEffect fadeEffect;

  const FadeWidget({
    Key? key,
    this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.fadeEffect = FadeEffect.fadeIn,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FadeWidgetState();
  }
}

class _FadeWidgetState extends State<FadeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeAnimation = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    widget.fadeEffect == FadeEffect.fadeIn
        ? _fadeAnimation.forward(from: 0.0).orCancel
        : _fadeAnimation.reverse(from: 1.0).orCancel;
  }

  @override
  void didUpdateWidget(FadeWidget oldWidget) {
    _fadeAnimation.reset();

    widget.fadeEffect == FadeEffect.fadeIn
        ? _fadeAnimation.forward(from: 0.0).orCancel
        : _fadeAnimation.reverse(from: 1.0).orCancel;

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _fadeAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _fadeAnimation.value,
      child: widget.child,
    );
  }
}
