import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/util/widgets/animated_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class PhaseControlWidget extends ConsumerWidget {
  const PhaseControlWidget({Key? key}) : super(key: key);

  List<Widget> phaseButtons(BuildContext context, WidgetRef ref,
      RoastTimeline timeline, bool running) {
    final results = <Widget>[];
    if (timeline.dryEnd == null) {
      results.add(phaseButton(
        ref,
        onPressed: () {
          ref.read(roastManagerProvider).markDryEnd();
        },
        icon: SvgPicture.asset(
          'images/dry.svg',
          height: 24,
          color: RoastAppTheme.capuccino,
        ),
        label: 'Dry end',
        running: running,
      ));
    } else {
      final hasFirstCrack = timeline.firstCrackStart != null;

      if (timeline.secondCrackStart == null) {
        results.add(phaseButton(
          ref,
          onPressed: () {
            ref.read(roastManagerProvider).markFirstCrack();
          },
          icon: SvgPicture.asset(
            'images/crack.svg',
            height: 24,
            color: RoastAppTheme.capuccino,
          ),
          label: timeline.firstCrackStart == null
              ? 'Start first crack'
              : 'End first crack',
          running: running,
        ));

        if (hasFirstCrack) {
          results.add(phaseButton(
            ref,
            onPressed: () {
              ref.read(roastManagerProvider).markSecondCrack();
            },
            icon: SvgPicture.asset('images/2nd_crack.svg',
                height: 24, color: RoastAppTheme.capuccino),
            label: 'Start second crack',
            running: running,
          ));
        }
      }
    }

    return results;
  }

  Widget phaseButton(
    WidgetRef ref, {
    required Widget icon,
    required String label,
    required bool running,
    required void Function() onPressed,
  }) {
    return Expanded(
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: ElevatedButton.icon(
          style: RoastAppTheme.phaseButtonTheme.style,
          icon: icon,
          label: Text(label, textAlign: TextAlign.center),
          onPressed: !running ? null : onPressed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeline = ref.watch(roastTimelineProvider).requireValue;
    final running = ref.watch(roastStateProvider) == RoastState.roasting;

    return AnimatedPopUp(
      axisAlignment: -1.0,
      child: !running
          ? const SizedBox()
          : Container(
              color: RoastAppTheme.capuccinoLight,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: phaseButtons(context, ref, timeline, running),
              ),
            ),
    );
  }
}
