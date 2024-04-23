import 'package:flutter/material.dart';

class Bobble extends StatefulWidget {
  const Bobble({required this.child, super.key});

  final Widget child;

  @override
  BobbleState createState() => BobbleState();
}

class BobbleState extends State<Bobble> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> offset;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    offset = Tween<double>(begin: 0, end: 15).animate(controller);
    controller.addStatusListener((status) {
      if (controller.value == 1.0) {
        controller.reverse();
      } else if (controller.value == 0.0) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: offset,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, offset.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
