import 'package:behmor_roast/src/util/models/toggle_switch_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ToggleSwitch<T> extends StatefulWidget {
  const ToggleSwitch({
    required this.children,
    required this.onToggle,
    this.style = ToggleSwitchStyle.defaults,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.value,
    super.key,
  });

  final List<ToggleSwitchOption<T>> children;
  final ToggleSwitchStyle style;
  final void Function(T) onToggle;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final T? value;

  @override
  ToggleSwitchState<T> createState() => ToggleSwitchState<T>();
}

class ToggleSwitchOption<T> {
  const ToggleSwitchOption({
    required this.value,
    required this.child,
  });
  final Widget child;
  final T value;
}

class ToggleSwitchState<T> extends State<ToggleSwitch<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController animationCtrl;

  final sizeTween = Tween<double>(begin: 0, end: 0);
  late Animation<double> sizeAnimation;

  final positionTween = Tween<double>(begin: 0, end: 0);
  late Animation<double> positionAnimation;

  int selectedIdx = 0;
  ToggleSwitchDragState? dragState;

  @override
  void initState() {
    super.initState();

    animationCtrl = AnimationController(
      value: 1.0,
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    sizeAnimation = animationCtrl.drive(sizeTween);
    positionAnimation = animationCtrl.drive(positionTween);

    if (widget.value != null) {
      selectedIdx =
          widget.children.indexWhere((option) => option.value == widget.value);
    }
  }

  @override
  void didUpdateWidget(ToggleSwitch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      final newSelectedIdx =
          widget.children.indexWhere((option) => option.value == widget.value);
      if (newSelectedIdx != selectedIdx) {
        chooseValue(newSelectedIdx);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pillPadding = widget.style.pillPadding;
    return CustomPaint(
      painter: buildPainter(context),
      child: Padding(
        padding: widget.style.padding,
        child: Row(
          mainAxisSize: widget.mainAxisSize,
          mainAxisAlignment: widget.mainAxisAlignment,
          children: [
            for (var i = 0; i < widget.children.length; ++i)
              GestureDetector(
                onTap: () => widget.onToggle(widget.children[i].value),
                onHorizontalDragStart: (details) =>
                    onHorizontalDragStart(i, details),
                onHorizontalDragUpdate: onHorizontalDragUpdate,
                onHorizontalDragEnd: onHorizontalDragEnd,
                child: Padding(
                  padding: pillPadding,
                  child: widget.children[i].child,
                ),
              ),
            //SizedBox(width: widget.style.gap),
          ],
        ),
      ),
    );
  }

  CustomPainter buildPainter(BuildContext context) {
    if (dragState != null) {
      return ToggleSwitchPainterDragging(
          dragState: dragState!, style: widget.style, context: context);
    }
    return ToggleSwitchPainterNormal(
      context: context,
      selectedIdx: selectedIdx,
      animation: animationCtrl,
      sizeAnimation: sizeAnimation,
      sizeTween: sizeTween,
      positionAnimation: positionAnimation,
      positionTween: positionTween,
      style: widget.style,
    );
  }

  void chooseValue(int i, {double? beginSize, double? beginLeft}) {
    final renderRow = _getRenderRow();
    var renderChild = renderRow.getChildrenAsList()[i];

    sizeTween.begin = beginSize ?? sizeAnimation.value;
    positionTween.begin = beginLeft ?? positionAnimation.value;

    animationCtrl.reset();

    final offset = (renderChild.parentData as FlexParentData).offset.dx;
    sizeTween.end = renderChild.size.width;
    positionTween.end = offset;
    animationCtrl.forward();

    selectedIdx = i;
  }

  Widget background() => Container(
        decoration: BoxDecoration(
          color: widget.style.backgroundColor,
        ),
      );

  Widget pill() => Container(
        decoration: BoxDecoration(
          color: widget.style.pillColor,
        ),
      );

  RenderFlex _getRenderRow() =>
      (((context.findRenderObject() as RenderCustomPaint).child
              as RenderPadding)
          .child as RenderFlex);

  void onHorizontalDragStart(int i, DragStartDetails details) {
    if (i != selectedIdx) {
      return;
    }

    final dragState = ToggleSwitchDragState(
      context: context,
      draggedIdx: i,
    );

    dragState.addListener(() {
      if (dragState.selectedIdx != selectedIdx) {
        setState(() {
          selectedIdx = dragState.selectedIdx;
        });
        widget.onToggle(widget.children[selectedIdx].value);
      }
    });

    setState(() {
      this.dragState = dragState;
    });
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    dragState?.dragAmount += details.primaryDelta ?? 0;
    dragState?.update();
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    if (dragState == null) {
      return;
    }

    try {
      //dragState!.dragAmount += details.primaryVelocity!;
      dragState!.update();
    } finally {
      chooseValue(
        dragState!.selectedIdx,
        beginSize: dragState!.pillWidth,
        beginLeft: dragState!.pillLeft,
      );
      animationCtrl.forward();
      widget.onToggle(widget.children[selectedIdx].value);

      dragState = null;
    }
  }
}

class ToggleSwitchDragState extends ChangeNotifier {
  ToggleSwitchDragState({
    required this.draggedIdx,
    required this.context,
  }) : selectedIdx = draggedIdx;

  final BuildContext context;
  int draggedIdx;
  double dragAmount = 0.0;
  int selectedIdx;

  double pillLeft = 0;
  double pillWidth = 0;

  int? targetLeftIdx;
  int? targetRightIdx;
  double targetDragProgress = 0.0;

  void findTargets() {
    final renderRow = _getRenderRow();
    final renderChildren = renderRow.getChildrenAsList();

    final Iterable<int> targetIndexes;
    if (dragAmount.isNegative) {
      targetIndexes = Iterable.generate(draggedIdx + 1, (i) => draggedIdx - i);
    } else {
      targetIndexes = Iterable.generate(
          renderChildren.length - draggedIdx, (i) => i + draggedIdx);
    }

    var remainingDrag = dragAmount.abs();
    int prevIdx = targetIndexes.first;
    int lastIdx = targetIndexes.first;
    for (final targetIdx in targetIndexes) {
      prevIdx = lastIdx;
      lastIdx = targetIdx;
      final target = renderChildren[targetIdx];

      if (remainingDrag > 0 && targetIdx != targetIndexes.last) {
        remainingDrag -= target.size.width;
      } else {
        break;
      }
    }

    if (dragAmount.isNegative) {
      targetLeftIdx = lastIdx;
      targetRightIdx = prevIdx;
      targetDragProgress = remainingDrag > 0 ? 0 : remainingDrag;
    } else {
      targetLeftIdx = prevIdx;
      targetRightIdx = lastIdx;
      targetDragProgress = renderChildren[lastIdx].size.width + remainingDrag;
    }
  }

  void update() {
    findTargets();

    final renderRow = _getRenderRow();
    final renderChildren = renderRow.getChildrenAsList();

    final targetLeft = renderChildren[targetLeftIdx!];
    final targetRight = renderChildren[targetRightIdx!];

    final position = Tween<double>(
        begin: (targetLeft.parentData as FlexParentData).offset.dx,
        end: (targetRight.parentData as FlexParentData).offset.dx);
    final size = Tween<double>(
        begin: targetLeft.size.width, end: targetRight.size.width);

    final dragWidth = (targetLeft.size.width + targetRight.size.width) / 2;
    final rawProgress = (targetDragProgress / dragWidth);
    final progress = rawProgress.abs().clamp(0.0, 1.0);

    pillLeft = position.transform(progress);
    pillWidth = size.transform(progress);
    selectedIdx = progress < 0.5 ? targetLeftIdx! : targetRightIdx!;

    notifyListeners();
  }

  RenderFlex _getRenderRow() =>
      (((context.findRenderObject() as RenderCustomPaint).child
              as RenderPadding)
          .child as RenderFlex);
}

abstract class ToggleSwitchPainterBase extends CustomPainter {
  ToggleSwitchPainterBase({
    required this.context,
    required this.style,
    super.repaint,
  });

  final BuildContext context;
  final ToggleSwitchStyle style;

  double get pillLeft;
  double get pillWidth;

  @override
  void paint(Canvas canvas, Size size) {
    paintBackground(canvas, size);
    paintPill(canvas, size);
  }

  void paintPill(Canvas canvas, Size size) {
    final renderRow = findFlexObj();

    final top = style.padding.top;
    final bottom = renderRow.size.height + style.padding.top;

    final left = pillLeft + style.padding.left;
    final right = left + pillWidth;

    final rect = RRect.fromLTRBR(left, top, right, bottom, style.pillRadius);

    final shadowPath = Path()..addRRect(rect);
    canvas.drawShadow(
        shadowPath, style.pillShadowColor, style.pillElevation, false);

    final paint = Paint()
      ..color = style.pillColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    canvas.drawRRect(rect, paint);
  }

  void paintBackground(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = style.backgroundColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;
    canvas.drawRRect(
        RRect.fromLTRBR(0, 0, size.width, size.height, style.backgroundRadius),
        paint);
  }

  RenderCustomPaint findRenderObject() =>
      context.findRenderObject() as RenderCustomPaint;
  RenderPadding findPaddingObj() => findRenderObject().child as RenderPadding;
  RenderFlex findFlexObj() => findPaddingObj().child as RenderFlex;
}

class ToggleSwitchPainterNormal extends ToggleSwitchPainterBase {
  ToggleSwitchPainterNormal({
    required super.context,
    required this.selectedIdx,
    required this.animation,
    required this.sizeAnimation,
    required this.sizeTween,
    required this.positionAnimation,
    required this.positionTween,
    required super.style,
  }) : super(repaint: animation);

  final int selectedIdx;
  final Animation<double> animation;
  final Animation<double> sizeAnimation;
  final Tween<double> sizeTween;
  final Animation<double> positionAnimation;
  final Tween<double> positionTween;

  @override
  double get pillLeft {
    final renderRow = findFlexObj();
    var renderChildren = renderRow.getChildrenAsList();
    var renderChild = renderChildren[selectedIdx];

    final offset = (renderChild.parentData as FlexParentData).offset.dx;
    sizeTween.end = renderChild.size.width;
    positionTween.end = offset;

    return positionAnimation.value;
  }

  @override
  double get pillWidth => sizeAnimation.value;

  @override
  bool shouldRepaint(ToggleSwitchPainterBase oldDelegate) {
    return oldDelegate is! ToggleSwitchPainterNormal ||
        oldDelegate.animation != animation ||
        oldDelegate.sizeAnimation != sizeAnimation ||
        oldDelegate.positionAnimation != positionAnimation ||
        oldDelegate.context != context ||
        oldDelegate.style != style;
  }
}

class ToggleSwitchPainterDragging extends ToggleSwitchPainterBase {
  ToggleSwitchPainterDragging({
    required super.context,
    required this.dragState,
    required super.style,
  }) : super(repaint: dragState);

  final ToggleSwitchDragState dragState;

  @override
  double get pillLeft => dragState.pillLeft;

  @override
  double get pillWidth => dragState.pillWidth;

  @override
  bool shouldRepaint(ToggleSwitchPainterBase oldDelegate) {
    return oldDelegate is! ToggleSwitchPainterDragging ||
        oldDelegate.dragState != dragState ||
        oldDelegate.context != context ||
        oldDelegate.style != style;
  }
}
