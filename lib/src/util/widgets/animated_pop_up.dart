import 'package:flutter/material.dart';

/// Animate a widget to pop up as it is shown and/or changes.
///
/// Statefully manages an SizeTransition widget plus the `child` widgets that
/// have been provided. When `child` changes, the animation is performed
/// (forwards, or backwards, or backwards and then forwards) such that the new
/// child "pops up."
///
/// Child changes are recognized via `runtimeType` and/or `key`, so use those
/// properly to ensure the switching is performed as desired.
///
/// Note: this implementation isn't entirely ideal. In order to correctly
/// handle stateful children, it regularly rebuilds, which could be expensive in
/// some circumstances.
class AnimatedPopUp extends StatefulWidget {
  const AnimatedPopUp({
	this.child,
	super.key,
  });

  final Widget? child;

  @override
  AnimatedPopUpState createState() => AnimatedPopUpState();
}

class AnimatedPopUpState extends State<AnimatedPopUp> with SingleTickerProviderStateMixin {

  Widget? showing;
  Widget? next;
  late final AnimationController animation;

  @override
  void initState() {
	super.initState();
	animation = AnimationController(
	  vsync: this,
	  duration: const Duration(milliseconds: 150),
	);

	showing = widget.child;
	if (showing != null) {
	  animation.forward();
	}
  }

  bool same(Widget? a, Widget? b) {
	dynamic id(Widget? widget)
		=> widget == null ? null : widget.key ?? widget.runtimeType;

    return id(a) == id(b);
  }

  @override
  void didUpdateWidget(AnimatedPopUp oldWidget) {
	super.didUpdateWidget(oldWidget);

    if (same(showing, widget.child)) {
	  // Handle case: widget being swapped, we reshow it.
	  if (animation.isAnimating) {
		animation.forward();
		next = null;
	  }

      // Handle case: Stateful child, must rebuild even though it IDs the same.
	  if (widget.child != null) {
		setState(() {
		  showing = widget.child;
		});
	  }
	  return;
	}

    if (showing == null) {
	  // Handle case: Appear from nothing.
	  setState(() {
		showing = widget.child;
	  });
	  animation.forward();
	} else {
	  // Handle case: Pull widget down to swap with a new one.
	  next = widget.child;
	  animation.reverse().then(reverseAnimationComplete);
	}
  }

  void reverseAnimationComplete(void _) {
	setState(() {
	  showing = next;
	  next = null;
	});

	if (showing != null) {
	  animation.forward();
    }
  }

  @override
  void dispose() {
	animation.dispose();
	super.dispose();
  }

  @override
  Widget build(BuildContext context) {
	return SizeTransition(
	  sizeFactor: animation,
	  child: showing,
	);
  }
}
