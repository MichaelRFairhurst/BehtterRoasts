import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedBlurOut extends StatelessWidget {
  const AnimatedBlurOut({
    required this.blur,
    required this.child,
    required this.duration,
    super.key,
  });

  final double blur;
  final Duration duration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0, end: blur),
      duration: duration,
      builder: (context, value, child) {
        return ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: value, sigmaY: value),
          child: child,
        );
      },
      child: child,
    );
  }
}
