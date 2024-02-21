import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/services/timer_service.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeWidget extends ConsumerWidget {
  const TimeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
	final time = ref.watch(secondsProvider).value;

    if (time == null) {
      return const Text('Not roasting.');
    }

    return Row(
	  children: [
        const SizedBox(width: 20),
        ...developmentTimeParts(ref),
        const Spacer(),
	    const Text('Roast time: '),
	    TimestampWidget.twitter(time),
	    const SizedBox(width: 20),
	  ],
	);
  }

  List<Widget> developmentTimeParts(WidgetRef ref) {
    final phases = ref.watch(phaseLogsProvider);
    final roast = ref.watch(roastProvider);
    final tService = ref.watch(timerServiceProvider);
	if (!phases.any((phase) => phase.phase == Phase.dryEnd)) {
      return [const Text('Waiting for dry end.')];
	}

    final firstCracks = phases.where((phase) => phase.phase == Phase.crack);
    if (firstCracks.isEmpty) {
      return [const Text('Waiting for first crack.')];
    }

    final firstCrackEnd = firstCracks.last.time;
    final now = tService.elapsed()!;
    final development = (now - firstCrackEnd).inMilliseconds / now.inMilliseconds;

    final develFmt = (development * 100).toStringAsFixed(1);
    final targetFmt = (roast!.config.targetDevelopment * 100).toStringAsFixed(1);

    return [
      Text('$develFmt/$targetFmt% development'),
    ];
  }
}
