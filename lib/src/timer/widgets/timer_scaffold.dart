import 'package:behmor_roast/src/util/widgets/animated_blur_out.dart';
import 'package:behmor_roast/src/util/widgets/animated_pop_up.dart';
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

  Key get keyOrType => child.key ?? ValueKey(child.runtimeType);
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
  final Widget? bottomPart;
  final FloatingPart? floatingBottomPart;
  final Widget? floatingActionButton;
  final Widget? popup;
  final Widget? toast;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    print('here ${MediaQuery.of(context).padding}');
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            topPart,
            Expanded(
              // Use a scaffold within a scaffold to get proper FAB layout.
              child: Scaffold(
                primary: false,
                extendBody: true,
                body: Stack(
                  children: [
                    Positioned.fill(
                      child: AnimatedBlurOut(
                        duration: const Duration(milliseconds: 250),
                        blur: popup != null ? 1.0 : 0.0,
                        child: getScrollAdjustedBody(),
                      ),
                    ),
                    Positioned.fill(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 150),
                        child: popup,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: AnimatedPopUp(
                        axisAlignment: -1.0,
                        duration: const Duration(milliseconds: 250),
                        child: SizedBox(
                          key: floatingBottomPart?.keyOrType,
                          height: floatingBottomPart?.height,
                          child: floatingBottomPart?.child,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: AnimatedPopUp(
                        child: Align(
                          key: floatingTopPart?.keyOrType,
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: floatingTopPart?.height,
                            child: floatingTopPart?.child,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: floatingActionButton,
                bottomNavigationBar: AnimatedPadding(
                  duration: const Duration(milliseconds: 150),
                  padding: EdgeInsets.only(
                      bottom: floatingBottomPart?.obscuredHeight ?? 0),
                  child: toast,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomPart,
    );
  }

  Widget getScrollAdjustedBody() {
    if (!scrollable) {
      return getPaddedBody();
    } else {
      return SingleChildScrollView(
        child: getPaddedBody(),
      );
    }
  }

  Widget getPaddedBody() => Padding(
        padding: EdgeInsets.only(
            top: floatingTopPart?.obscuredHeight ?? 0,
            bottom: floatingBottomPart?.obscuredHeight ?? 0),
        child: body,
      );
}
