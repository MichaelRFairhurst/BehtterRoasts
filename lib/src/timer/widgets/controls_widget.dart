import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/control_button.dart';
import 'package:behmor_roast/src/util/widgets/crack_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlsWidget extends ConsumerWidget {
  const ControlsWidget({Key? key}) : super(key: key);

  List<Phase> phaseButtonTypes(Iterable<PhaseLog> phaseLogs) {
    final results = <Phase>[];

    if (!phaseLogs.any((p) => p.phase == Phase.dryEnd)) {
      results.add(Phase.dryEnd);
    } else {
      final hasFirstCrack = phaseLogs.any((p) => p.phase == Phase.firstCrack);

      if (!phaseLogs.any((p) => p.phase == Phase.secondCrack)) {
        results.add(Phase.firstCrack);
        if (hasFirstCrack) {
          results.add(Phase.secondCrack);
        }
      }

      if (hasFirstCrack) {
        results.add(Phase.done);
      }
    }

    return results;
  }

  Widget phaseButton(Phase phaseType, WidgetRef ref, bool running) {
    final Widget icon;
    final String label;
    switch (phaseType) {
      case Phase.preheatEnd:
      case Phase.start:
        throw 'unreachable';

      case Phase.dryEnd:
        icon = const Icon(Icons.air);
        label = 'Dry end';
        break;
      case Phase.firstCrack:
        icon = const CrackIcon();
        label = '1st crack';
        break;
      case Phase.secondCrack:
        icon = const CrackIcon();
        label = '2nd crack';
        break;
      case Phase.done:
        icon = const Icon(Icons.check);
        label = 'Done';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton.icon(
        icon: icon,
        label: Text(label),
        onPressed: !running
            ? null
            : () {
                final tService = ref.read(roastTimerProvider);
                final now = tService.elapsed()!;
                final newLog = PhaseLog(time: now, phase: phaseType);
                ref
                    .read(roastTimelineProvider.notifier)
                    .update((state) => state.addLog(newLog));

                if (phaseType == Phase.done) {
                  tService.stop();
                }
              },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phaseLogs =
        ref.watch(roastTimelineProvider).rawLogs.whereType<PhaseLog>();
    final running = ref.watch(roastStateProvider) == RoastState.roasting;

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
          children: phaseButtonTypes(phaseLogs)
              .map((type) => phaseButton(type, ref, running))
              .toList(),
        ),
      ],
    );
  }
}
