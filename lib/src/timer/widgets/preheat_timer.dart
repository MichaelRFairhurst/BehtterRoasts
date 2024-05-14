import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/shapes/progress_circle.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreheatTimer extends ConsumerStatefulWidget {
  const PreheatTimer({
    required this.duration,
    super.key,
  });

  final Duration duration;

  @override
  PreheatTimerState createState() => PreheatTimerState();
}

class PreheatTimerState extends ConsumerState<PreheatTimer>
    with SingleTickerProviderStateMixin {
  Duration time = Duration.zero;
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    ticker = createTicker((_) {
      setState(() {
        time = ref.read(preheatTimerProvider).elapsed()!;
      });
    })
      ..start();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeFloored = Duration(seconds: time.inSeconds);
    final remaining = widget.duration - timeFloored;
    final progress = time.inMilliseconds / widget.duration.inMilliseconds;

    return ProgressCircle(
      progress: progress,
      barWidth: 10.0,
      fillColor: RoastAppTheme.limeDark,
      overfillColor: RoastAppTheme.errorColor,
      emptyColor: RoastAppTheme.crema,
      innerColor: RoastAppTheme.cremaLight,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 220,
        height: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Time remaining:',
                style: RoastAppTheme.materialTheme.textTheme.labelLarge),
            TimestampWidget(
              remaining,
              style: RoastAppTheme.materialTheme.textTheme.displaySmall!
                  .copyWith(
                      fontFamily: 'Roboto',
                      color: remaining.isNegative
                          ? RoastAppTheme.errorColor
                          : null),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 28,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('Done'),
                style: RoastAppTheme.limeButtonTheme.style,
                onPressed: () {
                  final preheatService = ref.read(preheatTimerProvider);
                  ref
                      .read(roastTimelineProvider.notifier)
                      .update((state) => state.copyWith(
                            preheatEnd: preheatService.elapsed()!,
                          ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
