import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/instructions/models/instruction.dart';
import 'package:behmor_roast/src/instructions/providers.dart';
import 'package:behmor_roast/src/instructions/services/instructions_service.dart';
import 'package:behmor_roast/src/timer/widgets/control_button.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:behmor_roast/src/util/widgets/animated_pop_up.dart';
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
    if (instructions == null || instructions.isEmpty) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 30),
          Text(
            'Instructions:',
            style: RoastAppTheme.materialTheme.textTheme.subtitle2!,
          ),
          divider(),
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Container(
                key: ValueKey(instructions.first.core),
                child: instruction(instructions.first, disabled: false),
              ),
              transitionBuilder: (child, animation) {
                final position = Tween<Offset>(
                    begin: Offset(
                        child.key == ValueKey(instructions.first.core)
                            ? 1.0
                            : -1.0,
                        0),
                    end: const Offset(0, 0));
                return SlideTransition(
                    position: position.animate(animation), child: child);
              }),
          AnimatedPopUp(
            child: !expanded
                ? Container()
                : Column(
                    children: [
                      for (final inst in instructions.skip(1).toList()) ...[
                        divider(),
                        instruction(inst, disabled: true),
                      ],
                    ],
                  ),
          ),
          const SizedBox(
            height: 5,
          ),
          Stack(
            children: [
              const Positioned.fill(
                child: Divider(
                  height: 12,
                  color: RoastAppTheme.metal,
                ),
              ),
              Center(
                child: SizedBox(
                  width: 50,
                  height: 6,
                  child: ElevatedButton(
                    //style: RoastAppTheme.tinyButtonTheme.style,
                    style: RoastAppTheme.keypadButtonTheme.style,
                    onPressed: () {
                      setState(() {
                        expanded = !expanded;
                      });
                    },
                    child: const Text('•••'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Divider divider() => const Divider(
        height: 3,
      );

  Widget instruction(TemporalInstruction inst, {required bool disabled}) {
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

    return Row(
      children: [
        ...timestampParts,
        const Spacer(),
        const Text('Press'),
        SizedBox(
          height: 24,
          child: ControlButton(
            control: inst.core.control,
            disabled: disabled,
            instructionTimeDiff: inst.time,
            onPressed: () {
              ref.read(coreInstructionsProvider.notifier).update((state) {
                return InstructionsService().skipInstruction(state!, inst);
              });
            },
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 24,
          child: ElevatedButton(
            style: RoastAppTheme.cancelButtonTheme.style,
            onPressed: () {
              ref.read(coreInstructionsProvider.notifier).update((state) {
                return InstructionsService().skipInstruction(state!, inst);
              });
            },
            child: const Text('Skip'),
          ),
        ),
      ],
    );
  }
}
