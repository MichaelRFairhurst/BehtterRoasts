import 'package:flutter/widgets.dart';

class SlidingSwitcher extends StatelessWidget {
  const SlidingSwitcher({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: child,
        transitionBuilder: (child, animation) {
          final position = Tween<Offset>(
              begin: Offset(child.key == this.child.key ? 1.0 : -1.0, 0),
              end: const Offset(0, 0));
          return SlideTransition(
              position: position.animate(animation), child: child);
        });
  }
}
