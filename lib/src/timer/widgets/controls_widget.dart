import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/control_button.dart';
import 'package:behmor_roast/src/util/widgets/crack_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlsWidget extends ConsumerWidget {
  const ControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
	final phaseLogs = ref.watch(phaseLogsProvider);
	final running = ref.watch(timerRunningProvider).value ?? false;

    return Column(
      children: [
        Wrap(
          children: const [
            ControlButton(control: Control.p1),
            ControlButton(control: Control.p2),
            ControlButton(control: Control.p3),
            ControlButton(control: Control.p4),
            ControlButton(control: Control.p5),
            ControlButton(control: Control.d),
          ],
        ),
		Wrap(
		  children: [
		    if (!phaseLogs.any((p) => p.phase == Phase.dryEnd))
              ElevatedButton.icon(
                icon: const Icon(Icons.air),
                //icon: const Icon(Icons.scatter_plot),
                label: const Text('Dry end'),
                onPressed: !running ? null : () {
		      	  final tService = ref.read(timerServiceProvider);
		      	  final now = tService.elapsed()!;
		      	  final newLog = PhaseLog(time: now, phase: Phase.dryEnd);
		      	  ref.read(phaseLogsProvider.notifier).update((logs) => logs.toList()..add(newLog));
                },
              ),
		    if (phaseLogs.any((p) => p.phase == Phase.dryEnd))
              ElevatedButton.icon(
                icon: const CrackIcon(),
                //icon: const Icon(Icons.wb_sunny),
                //icon: Icon(Icons.flare),
                //icon: Icon(Icons.upcoming),
                //icon: Icon(Icons.stream),
                //icon: Icon(Icons.new_releases),
                label: const Text('Log Crack'),
                onPressed: !running ? null : () {
		      	  final tService = ref.read(timerServiceProvider);
		      	  final now = tService.elapsed()!;
		      	  final newLog = PhaseLog(time: now, phase: Phase.crack);
		      	  ref.read(phaseLogsProvider.notifier).update((logs) => logs.toList()..add(newLog));
                },
              ),
		    if (phaseLogs.any((p) => p.phase == Phase.crack))
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('Finish'),
                onPressed: !running ? null : () {
		      	  final tService = ref.read(timerServiceProvider);
				  tService.stop();
                },
              ),
          ].map((widget) => Container(
		    padding: const EdgeInsets.symmetric(horizontal: 8.0),
			child: widget,
		  )).toList(),
        ),
      ],
    );
  }
}
