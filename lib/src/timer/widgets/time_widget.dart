import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/shapes/widgets/oversized_circle.dart';
import 'package:behmor_roast/src/timer/models/projection.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/development_widget.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeWidget extends ConsumerWidget {
  const TimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(roastStateProvider);
    final projections = ref.watch(projectionProvider);

    Duration? time = ref.watch(secondsRoastProvider).value;

    final showRoastInfo =
        state == RoastState.roasting || state == RoastState.done;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const DevelopmentWidget(),
        OversizedCircle(
          borderWidth: 1,
          borderColor: RoastAppTheme.metalLight,
          oversize: const EdgeInsets.only(left: 25, right: 7),
          color: RoastAppTheme.cremaLight,
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 110,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: tempCircleParts(projections),
            ),
          ),
        ),
        OversizedCircle(
          borderWidth: 5,
          borderColor: RoastAppTheme.lime,
          oversize: const EdgeInsets.symmetric(horizontal: 8),
          color: RoastAppTheme.cremaLight,
          alignment: Alignment.topCenter,
          child: Container(
            width: 150,
            height: 110,
            padding: const EdgeInsets.only(top: 6, bottom: 20),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: timeCircleContent(time, state, showRoastInfo, ref),
            ),
          ),
        ),
      ],
    );
  }

  Widget timeCircleContent(
      Duration? time, RoastState state, bool showRoastInfo, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Roast Time',
          style: RoastAppTheme.materialTheme.textTheme.labelMedium,
        ),
        TimestampWidget(time ?? Duration.zero,
            style: RoastAppTheme.materialTheme.textTheme.displaySmall
                ?.copyWith(fontFamily: 'Roboto')),
        if (showRoastInfo)
          SizedBox(
            height: 28,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text('Done'),
              style: RoastAppTheme.limeButtonTheme.style,
              onPressed: donePressed(state, ref),
            ),
          ),
      ],
    );
  }

  List<Widget> tempCircleParts(Projection projections) {
    final base = [
      Text(
        'Est. Temp',
        style: RoastAppTheme.materialTheme.textTheme.labelSmall,
      ),
      Text(formatTemp(projections.currentTemp),
          style: RoastAppTheme.materialTheme.textTheme.headlineMedium
              ?.copyWith(fontFamily: 'Roboto')),
    ];

    final tempDiff = projections.copyRoastTempDiff?.round().toDouble();
    if (tempDiff == null) {
      return base;
    }

    final Color diffColor;
    final String diffText;
    if (tempDiff.isNegative) {
      diffColor = RoastAppTheme.indigo;
      diffText = 'low';
    } else if (tempDiff > 0.0) {
      diffColor = RoastAppTheme.errorColor;
      diffText = 'hot';
    } else {
      diffColor = RoastAppTheme.crema;
      diffText = 'low';
    }

    return [
      ...base,
      Text(
        '${formatTemp(tempDiff.abs())} $diffText',
        style: RoastAppTheme.materialTheme.textTheme.bodySmall
            ?.copyWith(color: diffColor),
      ),
    ];
  }

  void Function()? donePressed(RoastState state, WidgetRef ref) {
    if (state == RoastState.roasting) {
      return () {
        final tService = ref.read(roastTimerProvider);
        final now = tService.elapsed()!;

        ref
            .read(roastTimelineProvider.notifier)
            .update((timeline) => timeline.copyWith(done: now));
        tService.stop();
      };
    }

    return null;
  }

  String formatTemp(double? currentTemp) {
    if (currentTemp == null) {
      return 'N/A';
    }

    return '${currentTemp.round()}°F';
  }
}
