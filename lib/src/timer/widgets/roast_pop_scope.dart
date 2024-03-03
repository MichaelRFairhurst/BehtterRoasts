import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoastPopScope extends ConsumerWidget {
  const RoastPopScope({
    required this.child,
    required this.state,
    super.key,
  });

  final RoastState state;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String contentStr;
    final String continueStr;
    final String stopStr;
    if (state == RoastState.roasting) {
      contentStr = 'Are you sure you want to stop the current roast?';
      continueStr = 'Continue roasting';
      stopStr = 'Stop current roast';
    } else {
      contentStr = 'Are you sure you want to abandon the current roast?';
      continueStr = 'Keep roast';
      stopStr = 'Abandon roast';
    }

    return WillPopScope(
      onWillPop: () async {
        showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: const Text('Abandon roast?'),
                content: Text(contentStr),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(continueStr),
                  ),
                  ElevatedButton(
                    style: RoastAppTheme.cancelButtonTheme.style,
                    onPressed: () {
                      ref.read(roastTimerProvider).stop();
                      ref.read(preheatTimerProvider).stop();
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(stopStr),
                  ),
                ]);
          },
        );
        return false;
      },
      child: child,
    );
  }
}
