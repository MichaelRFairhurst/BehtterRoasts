import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/development_widget.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeWidget extends ConsumerWidget {
  const TimeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(roastStateProvider);
    Duration? time;
    if (state == RoastState.preheating) {
      time = ref.watch(secondsTotalProvider).value;
    } else {
      time = ref.watch(secondsRoastProvider).value;
    }

    if (state == RoastState.waiting ||
        state == RoastState.preheatDone ||
        time == null) {
      return const Text('Not roasting.');
    }

    return Row(
      children: [
        const SizedBox(width: 20),
        if (state == RoastState.roasting) const DevelopmentWidget(),
        const Spacer(),
        if (state == RoastState.roasting) const Text('Roast time: '),
        if (state == RoastState.preheating) const Text('Preheat time: '),
        TimestampWidget.twitter(time),
        const SizedBox(width: 20),
      ],
    );
  }
}
