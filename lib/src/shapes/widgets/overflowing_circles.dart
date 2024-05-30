import 'package:behmor_roast/src/config/theme.dart';
import 'package:flutter/material.dart';

class OverflowingCircles extends StatelessWidget {
  const OverflowingCircles({
    required this.children,
    required this.centers,
    required this.childSize,
    required this.overflowSize,
    super.key,
  });

  final List<Widget> children;
  final List<Offset> centers;
  final double childSize;
  final double overflowSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: OverflowingCirclesBackgroundPainter(
              centers: centers,
              childSize: overflowSize,
            ),
            child: const SizedBox.expand(),
          ),
        ),
        for (int i = 0; i < children.length; ++i)
          Positioned(
            left: centers[i].dx - childSize / 2,
            top: centers[i].dy - childSize / 2,
            width: childSize,
            height: childSize,
            child: children[i],
          ),
      ],
    );
  }

  static List<Offset> centeredZigZag({
    required int count,
    required double childSize,
    required double spacing,
    required Size containerSize,
  }) {
    return [
      for (int i = (count / 2).floor(); i > -(count / 2).ceil(); --i)
        Offset(
          containerSize.width / 2 - (childSize + spacing) * i,
          i % 2 == 0 ? childSize / 2 : containerSize.height - childSize / 2,
        ),
    ];
  }
}

class OverflowingCirclesBackgroundPainter extends CustomPainter {
  const OverflowingCirclesBackgroundPainter({
    required this.centers,
    required this.childSize,
  });

  final List<Offset> centers;
  final double childSize;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addOval(Rect.fromLTRB(-800, 10, size.width + 800, size.height + 800));
    for (final offset in centers) {
      path.addOval(Rect.fromCircle(center: offset, radius: childSize / 2));
    }

    final clipped = Path.combine(
      PathOperation.intersect,
      path,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    canvas.drawPath(
      clipped,
      Paint()
        ..color = Colors.black.withOpacity(0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
    );
    canvas.drawPath(clipped, Paint()..color = RoastAppTheme.capuccinoLight);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
