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
    final pillPadding = widget.style.pillPadding ?? widget.style.padding / 2;
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
			  onTap: () {
				animationCtrl.reverse();
			  },
			  child: Padding(
				padding: pillPadding,
				child: widget.optionLeft,
			  ),
			),
			SizedBox(width: widget.style.gap),
			GestureDetector(
			  onTap: () {
				animationCtrl.forward();
			  },
			  child: Padding(
				padding: pillPadding.flipped,
				child: widget.optionRight,
			  ),
			),
		  ],
		),
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

	final paint = Paint()
	  ..color = style.pillColor
	  ..style = PaintingStyle.fill
	  ..strokeWidth = 10;

	canvas.drawRRect(RRect.fromLTRBR(left, top, right, bottom,
	    style.pillRadius), paint);
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
