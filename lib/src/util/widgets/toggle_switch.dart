import 'dart:math';

import 'package:behmor_roast/src/util/models/toggle_switch_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ToggleSwitch extends StatefulWidget {
  const ToggleSwitch({
	required this.optionLeft,
	required this.optionRight,
	this.style = ToggleSwitchStyle.defaults,
	super.key,
  });

  final Widget optionLeft;
  final Widget optionRight;
  final ToggleSwitchStyle style;

  @override
  ToggleSwitchState createState() => ToggleSwitchState();
}

class ToggleSwitchState extends State<ToggleSwitch> with SingleTickerProviderStateMixin {

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
	return CustomPaint(
	  painter: ToggleSwitchPainter(
	    context: context,
		animation: animationCtrl,
		style: widget.style,
	  ),
	  child: Row(
		mainAxisSize: MainAxisSize.min,
		children: [
		  GestureDetector(
		    onTap: () {
			  animationCtrl.reverse();
			},
		    child: widget.optionLeft,
		  ),
		  GestureDetector(
		    onTap: () {
			  animationCtrl.forward();
			},
		    child: widget.optionRight,
		  ),
		]
	  ),
	);
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
	final leftBox = findWidgetLeftBox();
	final rightBox = findWidgetRightBox();

    final left = animation.value * (size.width - rightBox.paintBounds.right);
    final right = leftBox.paintBounds.right
	    + (size.width - leftBox.paintBounds.right) * animation.value;

    final height = max(leftBox.paintBounds.height, rightBox.paintBounds.height);

	final paint = Paint()
	  ..color = style.pillColor
	  ..style = PaintingStyle.fill
	  ..strokeWidth = 10;

	canvas.drawRRect(RRect.fromLTRBR(left, 0, right, height,
	    const Radius.circular(8)), paint);
  }

  void paintBackground(Canvas canvas, Size size) {
	final paint = Paint()
	  ..color = style.backgroundColor
	  ..style = PaintingStyle.fill
	  ..strokeWidth = 10;
	canvas.drawRRect(RRect.fromLTRBR(0, 0, size.width, size.height,
	    const Radius.circular(8)), paint);
  }

  @override
  bool shouldRepaint(ToggleSwitchPainter oldDelegate) {
    return oldDelegate.animation != animation || oldDelegate.context != context || oldDelegate.style != style;
  }

  RenderCustomPaint findRenderObject() => context.findRenderObject() as RenderCustomPaint;

  RenderBox findWidgetLeftBox() => (findRenderObject().child as RenderFlex).firstChild as RenderBox;
  RenderBox findWidgetRightBox() => (findRenderObject().child as RenderFlex).lastChild as RenderBox;

}
