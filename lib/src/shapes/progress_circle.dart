import 'dart:math';

import 'package:behmor_roast/src/config/theme.dart';
import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  const ProgressCircle({
    required this.progress,
    required this.barWidth,
    required this.fillColor,
    required this.overfillColor,
    required this.emptyColor,
    required this.innerColor,
    this.child,
    super.key,
  });

  final double progress;
  final double barWidth;
  final Widget? child;
  final Color fillColor;
  final Color overfillColor;
  final Color emptyColor;
  final Color innerColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ProgressPainter(
        progress: progress,
        barWidth: barWidth,
        fillColor: fillColor,
        overfillColor: overfillColor,
        emptyColor: emptyColor,
        innerColor: innerColor,
      ),
      child: child,
    );
  }
}

class ProgressPainter extends CustomPainter {
  ProgressPainter({
    required this.progress,
    required this.barWidth,
    required this.fillColor,
    required this.overfillColor,
    required this.emptyColor,
    required this.innerColor,
  });

  final double progress;
  final double barWidth;
  final Color fillColor;
  final Color overfillColor;
  final Color emptyColor;
  final Color innerColor;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final emptyPaint = Paint();
    final fillPaint = Paint();
    if (progress < 1.0) {
      emptyPaint.color = emptyColor;
      fillPaint.color = fillColor;
    } else if (progress < 2.0) {
      emptyPaint.color = fillColor;
      fillPaint.color = overfillColor;
    } else {
      emptyPaint.color = overfillColor;
    }

    // Complete circle, inner color
    canvas.drawCircle(Offset(size.width / 2, size.height / 2),
        radius - barWidth, Paint()..color = innerColor);

    // Shadow of filled in portion of ring
    if (progress > 0) {
      canvas.drawPath(
          _progressPath(center, radius, progress.clamp(0.0, 1.0)),
          Paint()
            ..color = RoastAppTheme.metal
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5));
    }

    // Complete ring, color of empty bar
    canvas.drawPath(_progressPath(center, radius, 1.0), emptyPaint);

    // Partial ring, color of filled bar
    if (progress > 0 && progress < 2.0) {
      canvas.drawPath(
        _progressPath(center, radius, progress % 1.0),
        fillPaint,
      );
    }
  }

  Path _progressPath(Offset center, double radius, double progress) {
    final arcPath = Path();
    if (progress < 1.0) {
      arcPath
        ..arcTo(Rect.fromCircle(center: center, radius: radius), pi / 2,
            2 * pi * progress, true)
        ..lineTo(center.dx, center.dy)
        ..close();
    } else {
      arcPath.addOval(Rect.fromCircle(center: center, radius: radius));
    }
    return Path.combine(
      PathOperation.difference,
      arcPath,
      Path()
        ..addOval(Rect.fromCircle(center: center, radius: radius - barWidth)),
    );
  }

  @override
  bool shouldRepaint(ProgressPainter oldDelegate) {
    return true;
  }
}
