import 'dart:math';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OversizedCircle extends SingleChildRenderObjectWidget {
  const OversizedCircle({
    required super.child,
    required this.color,
    required this.borderColor,
    required this.borderWidth,
    required this.alignment,
    required this.oversize,
    this.bottomBorder = true,
    super.key,
  });

  final Color color;
  final Color borderColor;
  final double borderWidth;
  final AlignmentGeometry alignment;
  final EdgeInsets oversize;
  final bool bottomBorder;

  @override
  RenderOversizedCircle createRenderObject(BuildContext context) =>
      RenderOversizedCircle(
        color: color,
        borderColor: borderColor,
        borderWidth: borderWidth,
        alignment: alignment,
        oversize: oversize,
        bottomBorder: bottomBorder,
      );

  @override
  void updateRenderObject(
      BuildContext context, RenderOversizedCircle renderObject) {
    renderObject.color = color;
    renderObject.borderColor = borderColor;
    renderObject.borderWidth = borderWidth;
    renderObject.alignment = alignment;
    renderObject.oversize = oversize;
    renderObject.bottomBorder = bottomBorder;
    renderObject.markNeedsPaint();
  }
}

class RenderOversizedCircle extends RenderBox with RenderObjectWithChildMixin {
  RenderOversizedCircle({
    required this.color,
    required this.borderColor,
    required this.borderWidth,
    required this.alignment,
    required this.oversize,
    required this.bottomBorder,
  });

  Color color;
  Color borderColor;
  double borderWidth;
  AlignmentGeometry alignment;
  EdgeInsets oversize;
  bool bottomBorder;

  @override
  bool sizedByParent = true;

  @override
  void performLayout() {
    child?.layout(constraints.loosen());
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final childSize = (child as RenderBox).size;
    final childOffset = offset +
        alignment.resolve(null).alongOffset(size - childSize as Offset);

    final canvas = context.canvas;

    final width = childSize.width + oversize.left + oversize.right;
    final height = childSize.height + oversize.top + oversize.bottom;
    final diameter = max(width, height);
    final radius = diameter / 2;

    final center =
        childOffset + Offset(radius - oversize.left, radius - oversize.top);

    // Shadow
    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = RoastAppTheme.metal
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3));

    // Border
    canvas.drawCircle(center, radius, Paint()..color = borderColor);

    // Body, preserving bottom border
    if (bottomBorder) {
      final insidePath = Path.combine(
        PathOperation.intersect,
        Path()
          ..addOval(
              Rect.fromCircle(center: center, radius: radius - borderWidth)),
        Path()
          ..addRect(
            Rect.fromLTWH(
                offset.dx, offset.dy, size.width, size.height - borderWidth),
          ),
      );

      canvas.drawPath(insidePath, Paint()..color = color);
    } else {
      canvas.drawCircle(center, radius - borderWidth, Paint()..color = color);
    }

    child?.paint(context, childOffset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final childSize = (child as RenderBox).size;
    final childOffset =
        alignment.resolve(null).alongOffset(size - childSize as Offset);
    return result.addWithPaintOffset(
        offset: childOffset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          return (child as RenderBox).hitTest(result, position: transformed);
        });
  }
}
