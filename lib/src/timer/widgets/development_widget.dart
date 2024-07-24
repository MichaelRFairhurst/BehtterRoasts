import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/shapes/progress_circle.dart';
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
        time = ref.read(roastTimerProvider).elapsed() ?? Duration.zero;
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
    final roast = ref.watch(roastProvider);
    final timeline = ref.watch(roastTimelineProvider).requireValue;

    List<Widget> innerParts;
    double progress;

    if (time == null || time!.inMicroseconds == 0) {
      innerParts = [
        const Text(
          'Not yet roasting.',
          textAlign: TextAlign.center,
          textScaler: TextScaler.linear(1.0),
        )
      ];
      progress = 0;
    } else if (timeline.dryEnd == null) {
      innerParts = [
        const Text(
          'Waiting for dry end.',
          textAlign: TextAlign.center,
          textScaler: TextScaler.linear(1.0),
        )
      ];
      progress = 0;
    } else {
      final firstCrackStart = timeline.firstCrackStart;
      if (firstCrackStart == null) {
        innerParts = [
          const Text(
            'Waiting for first crack.',
            textAlign: TextAlign.center,
            textScaler: TextScaler.linear(1.0),
          )
        ];
        progress = 0;
      } else {
        final development =
            (time! - firstCrackStart).inMilliseconds / time!.inMilliseconds;

        final develFmt = (development * 100).toStringAsFixed(1);

        innerParts = [
          Text(
            'development',
            style: RoastAppTheme.materialTheme.textTheme.labelSmall,
            textScaler: const TextScaler.linear(0.85),
          ),
          Text(
            '$develFmt%',
            style: RoastAppTheme.materialTheme.textTheme.headlineSmall
                ?.copyWith(fontFamily: 'Roboto'),
            textScaler: const TextScaler.linear(1.0),
          ),
        ];
        progress = development / roast!.config.targetDevelopment;
      }
    }

    return OversizedCircle(
      borderWidth: 1,
      borderColor: RoastAppTheme.metal,
      oversize: const EdgeInsets.only(left: 150, right: 100, bottom: 10),
      color: RoastAppTheme.capuccino,
      alignment: Alignment.topLeft,
      topBorder: false,
      child: Container(
        width: 95,
        height: 95,
        padding: const EdgeInsets.only(left: 5, top: 8),
        child: ProgressCircle(
          progress: progress,
          barWidth: 6.0,
          fillColor: RoastAppTheme.indigo,
          overfillColor: RoastAppTheme.errorColor,
          emptyColor: RoastAppTheme.cremaLight,
          innerColor: RoastAppTheme.crema,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: innerParts,
            ),
          ),
        ),
      ),
    );
  }
}
