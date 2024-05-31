import 'package:behmor_roast/src/util/widgets/animated_blur_out.dart';
import 'package:flutter/material.dart';

class FloatingPart {
  const FloatingPart({
    required this.child,
    required this.height,
    required this.overlap,
  });

  final Widget child;
  final double height;
  final double overlap;

  double get obscuredHeight => height - overlap;
}

class TimerScaffold extends StatelessWidget {
  const TimerScaffold({
    required this.appBar,
    required this.topPart,
    required this.floatingTopPart,
    required this.bottomPart,
    required this.floatingBottomPart,
    required this.floatingActionButton,
    required this.toast,
    required this.popup,
    required this.body,
    required this.scrollable,
    super.key,
  });

  final bool scrollable;
  final PreferredSizeWidget appBar;
  final Widget topPart;
  final FloatingPart? floatingTopPart;
  final Widget bottomPart;
  final FloatingPart? floatingBottomPart;
  final Widget? floatingActionButton;
  final Widget? popup;
  final Widget? toast;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final Widget body;
    if (scrollable) {
      body = SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: floatingTopPart?.obscuredHeight),
            this.body,
            if (floatingBottomPart != null)
              SizedBox(height: floatingBottomPart?.obscuredHeight),
          ],
        ),
      );
    } else {
      body = this.body;
    }
    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          topPart,
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: AnimatedBlurOut(
                    duration: const Duration(milliseconds: 250),
                    blur: popup != null ? 1.0 : 0.0,
                    child: body,
                  ),
                ),
                Positioned.fill(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 150),
                    child: popup,
                  ),
                ),
                if (floatingBottomPart != null)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: floatingBottomPart!.height,
                    child: floatingBottomPart!.child,
                  ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: floatingTopPart!.height,
                  child: floatingTopPart!.child,
                ),
                if (toast != null)
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 150),
                    left: 0,
                    right: 0,
                    bottom: floatingBottomPart?.obscuredHeight ?? 0,
                    child: toast!,
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: bottomPart,
      ),
    );
  }
}
