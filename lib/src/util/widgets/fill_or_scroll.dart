import 'package:flutter/material.dart';

class FillOrScroll extends StatelessWidget {
  final Widget child;

  const FillOrScroll({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        ),
      ],
    );
  }
}
