import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DevelopmentWidget extends ConsumerStatefulWidget {
  const DevelopmentWidget({super.key});

  @override
  DevelopmentWidgetState createState() => DevelopmentWidgetState();
}

class DevelopmentWidgetState extends ConsumerState<DevelopmentWidget>
    with SingleTickerProviderStateMixin {
  Duration? time;
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    ticker = createTicker((_) {
      setState(() {
        time = ref.read(roastTimerProvider).elapsed()!;
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: developmentTimeParts(),
    );
  }

  List<Widget> developmentTimeParts() {
    final timeline = ref.watch(roastTimelineProvider);
    final roast = ref.watch(roastProvider);
    if (timeline.dryEnd == null) {
      return [const Text('Waiting for dry end.')];
    }

    final firstCrackEnd = timeline.firstCrackEnd;
    if (firstCrackEnd == null) {
      return [const Text('Waiting for first crack.')];
    }

    final development =
        (time! - firstCrackEnd).inMilliseconds / time!.inMilliseconds;

    final develFmt = (development * 100).toStringAsFixed(1);
    final targetFmt =
        (roast!.config.targetDevelopment * 100).toStringAsFixed(1);

    return [
      Text('$develFmt/$targetFmt% development'),
    ];
  }
}
