import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/services/timer_service.dart';
import 'package:behmor_roast/src/timer/widgets/development_widget.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeWidget extends ConsumerWidget {
  const TimeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timerStateProvider).value;
    final time = ref.watch(secondsProvider).value;

    if (state == RoastTimerState.waiting ||
        state == RoastTimerState.preheatDone ||
        time == null) {
      return const Text('Not roasting.');
    }

    return Row(
      children: [
        const SizedBox(width: 20),
        if (state == RoastTimerState.roasting) const DevelopmentWidget(),
        const Spacer(),
        if (state == RoastTimerState.roasting) const Text('Roast time: '),
        if (state == RoastTimerState.preheating) const Text('Preheat time: '),
        TimestampWidget.twitter(time),
        const SizedBox(width: 20),
      ],
    );
  }
}
