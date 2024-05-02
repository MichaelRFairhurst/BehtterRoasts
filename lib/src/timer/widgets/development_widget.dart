import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/shapes/widgets/oversized_circle.dart';
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
    return OversizedCircle(
      borderWidth: 1,
      borderColor: RoastAppTheme.metal,
      oversize: const EdgeInsets.only(left: 150, right: 100, top: 10),
      color: RoastAppTheme.capuccino,
      alignment: Alignment.bottomLeft,
      bottomBorder: false,
      child: Container(
        width: 90,
        height: 90,
        margin: const EdgeInsets.only(left: 5, bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: RoastAppTheme.crema,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: developmentTimeParts(),
        ),
      ),
    );
  }

  List<Widget> developmentTimeParts() {
    final timeline = ref.watch(roastTimelineProvider);

    if (timeline.dryEnd == null) {
      return [const Text('Waiting for dry end.', textAlign: TextAlign.center)];
    }

    final firstCrackEnd = timeline.firstCrackEnd;
    if (firstCrackEnd == null) {
      return [
        const Text('Waiting for first crack.', textAlign: TextAlign.center)
      ];
    }

    final development =
        (time! - firstCrackEnd).inMilliseconds / time!.inMilliseconds;

    final develFmt = (development * 100).toStringAsFixed(1);
    //final targetFmt =
    //    (roast!.config.targetDevelopment * 100).toStringAsFixed(1);

    return [
      Text(
        'development',
        style: RoastAppTheme.materialTheme.textTheme.labelSmall,
      ),
      Text('$develFmt%',
          style: RoastAppTheme.materialTheme.textTheme.headlineSmall
              ?.copyWith(fontFamily: 'Roboto')),
    ];
  }
}
