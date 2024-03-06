import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/control_button.dart';
import 'package:behmor_roast/src/util/widgets/crack_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlsWidget extends ConsumerWidget {
  const ControlsWidget({Key? key}) : super(key: key);

  List<Widget> phaseButtons(
      WidgetRef ref, RoastTimeline timeline, bool running) {
    final results = <Widget>[];

    if (timeline.dryEnd == null) {
      results.add(phaseButton(
        ref,
        updater: (timeline, time) => timeline.copyWith(dryEnd: time),
        icon: const Icon(Icons.air),
        label: 'Dry end',
        running: running,
      ));
    } else {
      final hasFirstCrack = timeline.firstCrackStart != null;

      if (timeline.secondCrackStart == null) {
        results.add(phaseButton(
          ref,
          updater: (timeline, time) => timeline.copyWith(
            firstCrackStart: timeline.firstCrackStart ?? time,
            firstCrackEnd: time,
          ),
          icon: const CrackIcon(),
          label: '1st crack',
          running: running,
        ));

        if (hasFirstCrack) {
          results.add(phaseButton(
            ref,
            updater: (timeline, time) => timeline.copyWith(
              secondCrackStart: time,
            ),
            icon: const CrackIcon(),
            label: '2nd crack',
            running: running,
          ));
        }
      }

      if (hasFirstCrack) {
        results.add(phaseButton(
          ref,
          updater: (timeline, time) => timeline.copyWith(done: time),
          icon: const Icon(Icons.check),
          label: 'Done',
          running: running,
          extra: () {
            final tService = ref.read(roastTimerProvider);
            tService.stop();
          },
        ));
      }
    }

    return results;
  }

  Widget phaseButton(
    WidgetRef ref, {
    required RoastTimeline Function(RoastTimeline, Duration) updater,
    required Widget icon,
    required String label,
    required bool running,
    void Function()? extra,
  }) {
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

                ref
                    .read(roastTimelineProvider.notifier)
                    .update((state) => updater(state, now));

                if (extra != null) {
                  extra();
                }
              },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeline = ref.watch(roastTimelineProvider);
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
          children: phaseButtons(ref, timeline, running),
        ),
      ],
    );
  }
}
