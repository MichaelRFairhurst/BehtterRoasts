import 'dart:math';

import 'package:behmor_roast/src/util/models/toggle_switch_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ToggleSwitch<T> extends StatefulWidget {
  const ToggleSwitch({
	required this.widgetLeft,
	required this.valueLeft,
	required this.widgetRight,
	required this.valueRight,
	required this.onToggle,
	this.style = ToggleSwitchStyle.defaults,
	super.key,
  });

  final Widget widgetLeft;
  final Widget widgetRight;
  final T valueLeft;
  final T valueRight;
  final ToggleSwitchStyle style;
  final void Function(T) onToggle;

  @override
  ToggleSwitchState<T> createState() => ToggleSwitchState<T>();
}

class ToggleSwitchState<T> extends State<ToggleSwitch<T>> with SingleTickerProviderStateMixin {

  late AnimationController animationCtrl;

  @override
  void initState() {
	super.initState();

    animationCtrl = AnimationController(
	  vsync: this,
	  duration: const Duration(milliseconds: 150),
	);
  }

  @override
  Widget build(BuildContext context) {
    final pillPadding = widget.style.pillPadding;
	return CustomPaint(
	  painter: ToggleSwitchPainter(
		context: context,
		animation: animationCtrl,
		style: widget.style,
	  ),
	  child: Padding(
		padding: widget.style.padding,
		child: Row(
		  mainAxisSize: MainAxisSize.min,
		  children: [
			GestureDetector(
			  onTap: chooseLeft,
			  onHorizontalDragUpdate: onHorizontalDragUpdate,
			  onHorizontalDragEnd: onHorizontalDragEnd,
			  child: Padding(
				padding: pillPadding,
				child: widget.widgetLeft,
			  ),
			),
			SizedBox(width: widget.style.gap),
			GestureDetector(
			  onTap: chooseRight,
			  onHorizontalDragUpdate: onHorizontalDragUpdate,
			  onHorizontalDragEnd: onHorizontalDragEnd,
			  child: Padding(
				padding: pillPadding.flipped,
				child: widget.widgetRight,
			  ),
			),
		  ],
		),
	  ),
	);
  }

  void chooseLeft() {
	animationCtrl.reverse();
	widget.onToggle(widget.valueLeft);
  }

  void chooseRight() {
	animationCtrl.forward();
	widget.onToggle(widget.valueRight);
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

  void onHorizontalDragUpdate(DragUpdateDetails details) {
	final leftObject = (((context.findRenderObject() as RenderCustomPaint).child as RenderPadding).child as RenderFlex).firstChild!;
	animationCtrl.value += details.primaryDelta! / leftObject.size.width;
  }

  void onHorizontalDragEnd(DragEndDetails details) {
	final leftObject = (((context.findRenderObject() as RenderCustomPaint).child as RenderPadding).child as RenderFlex).firstChild!;

	final flicked = animationCtrl.value + details.primaryVelocity! / leftObject.size.width;
	if (flicked < 0.5) {
	  chooseLeft();
	} else {
	  chooseRight();
	}
  }
}

class ToggleSwitchPainter extends CustomPainter {
  ToggleSwitchPainter({
	required this.context,
	required this.animation,
	required this.style,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final BuildContext context;
  final ToggleSwitchStyle style;

  @override
  void paint(Canvas canvas, Size size) {
    paintBackground(canvas, size);
    paintPill(canvas, size);
  }

  void paintPill(Canvas canvas, Size size) {
	final leftBox = findWidgetLeftObj();
	final rightBox = findWidgetRightObj();

    final left = animation.value * (size.width - rightBox.paintBounds.right - style.padding.right - style.padding.left)
	    + style.padding.left;
    final right = leftBox.paintBounds.right
	    + (size.width - leftBox.paintBounds.right - style.padding.left - style.padding.right) * animation.value
	    + style.padding.left;

	final top = style.padding.top;
    final bottom = max(leftBox.paintBounds.height, rightBox.paintBounds.height)
	    + style.padding.top;

    final rect = RRect.fromLTRBR(left, top, right, bottom, style.pillRadius);

    final shadowPath = Path()..addRRect(rect);
    canvas.drawShadow(shadowPath, style.pillShadowColor, style.pillElevation, false);

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
	canvas.drawRRect(RRect.fromLTRBR(0, 0, size.width, size.height,
	    style.backgroundRadius), paint);
  }

  @override
  bool shouldRepaint(ToggleSwitchPainter oldDelegate) {
    return oldDelegate.animation != animation || oldDelegate.context != context || oldDelegate.style != style;
  }

  RenderCustomPaint findRenderObject() => context.findRenderObject() as RenderCustomPaint;
  RenderPadding findPaddingObj() => findRenderObject().child as RenderPadding;
  RenderFlex findFlexObj() => findPaddingObj().child as RenderFlex;

  RenderBox findWidgetLeftObj() => findFlexObj().firstChild as RenderBox;
  RenderBox findWidgetRightObj() => findFlexObj().lastChild as RenderBox;

}
