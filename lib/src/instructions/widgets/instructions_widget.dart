import 'package:behmor_roast/src/config/theme.dart';

import 'package:behmor_roast/src/instructions/models/instruction.dart';
import 'package:behmor_roast/src/instructions/providers.dart';
import 'package:behmor_roast/src/instructions/services/instructions_service.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/control_button.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:behmor_roast/src/util/widgets/animated_pop_up.dart';
import 'package:behmor_roast/src/util/widgets/sliding_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InstructionsWidget extends ConsumerStatefulWidget {
  const InstructionsWidget({Key? key}) : super(key: key);

  @override
  InstructionsWidgetState createState() => InstructionsWidgetState();
}

class InstructionsWidgetState extends ConsumerState<InstructionsWidget> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final instructions = ref.watch(temporalInstructionsProvider);
    final state = ref.watch(roastStateProvider);
    if (instructions == null ||
        instructions.isEmpty ||
        state == RoastState.done) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: RoastAppTheme.capuccinoLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              'Instructions:',
              style: RoastAppTheme.materialTheme.textTheme.subtitle2?.copyWith(
                color: RoastAppTheme.cremaLight,
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 32,
                      child: IconButton(
                        icon: Icon(
                            expanded ? Icons.expand_less : Icons.expand_more),
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          setState(() {
                            expanded = !expanded;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: instructionsList(instructions),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget instructionsList(List<TemporalInstruction> instructions) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 120),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlidingSwitcher(
              child: Container(
                key: ValueKey(instructions.first.core),
                child: instruction(instructions.first, isFirst: true),
              ),
            ),
            AnimatedPopUp.down(
              child: !expanded
                  ? Container()
                  : Column(
                      children: [
                        for (final inst in instructions.skip(1).toList()) ...[
                          divider(),
                          instruction(inst, isFirst: false),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Divider divider() => const Divider(
        height: 3,
      );

  Widget instruction(TemporalInstruction inst, {required bool isFirst}) {
    List<Widget> timestampParts;
    if (inst.time.isNegative) {
      final style = RoastAppTheme.materialTheme.textTheme.bodySmall!.copyWith(
        color: RoastAppTheme.errorColor,
      );
      timestampParts = [
        Text('Late by ', style: style),
        TimestampWidget.twitter(-inst.time, style: style),
        Text(':', style: style),
      ];
    } else {
      timestampParts = [
        const Text('In '),
        TimestampWidget.twitter(inst.time),
        const Text(':'),
      ];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('${inst.core.index + 1}. ',
              style: RoastAppTheme.materialTheme.textTheme.labelLarge),
          ...timestampParts,
          const Spacer(),
          const Text('Press'),
          SizedBox(
            height: 24,
            child: ControlButton(
              control: inst.core.control,
              disabled: !isFirst,
              instructionTimeDiff: inst.time,
              onPressed: () {
                ref.read(coreInstructionsProvider.notifier).update((state) {
                  return InstructionsService().skipInstruction(state!, inst);
                });
              },
            ),
          ),
          Text('at ${inst.core.temp}°F'),
          const Spacer(),
          SizedBox(
            height: 24,
            child: IconButton(
              onPressed: () {
                ref.read(coreInstructionsProvider.notifier).update((state) {
                  return InstructionsService().skipInstruction(state!, inst);
                });
              },
              padding: const EdgeInsets.all(0),
              icon: const Icon(Icons.cancel, color: RoastAppTheme.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}
