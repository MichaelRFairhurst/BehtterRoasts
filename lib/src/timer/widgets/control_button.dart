import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/instructions/models/instruction.dart';
import 'package:behmor_roast/src/instructions/providers.dart';
import 'package:behmor_roast/src/instructions/services/instructions_service.dart';
import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlButton extends ConsumerWidget {
  final Control control;
  final bool? disabled;
  final TemporalInstruction? instruction;

  const ControlButton({
    required this.control,
    this.disabled,
    this.instruction,
    super.key,
  });

  bool isDisabled(WidgetRef ref) {
    if (disabled != null) {
      return disabled!;
    }

    final controls =
        ref.watch(roastTimelineProvider).rawLogs.whereType<ControlLog?>();
    final running = ref.watch(roastStateProvider) == RoastState.roasting;

    final pwrLevel = controls
        .cast<ControlLog?>()
        .lastWhere((c) => c?.control != Control.d, orElse: () => null)
        ?.control;

    return !running || pwrLevel == control;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        minimumSize: const Size(30, 30),
        padding: const EdgeInsets.all(0),
        disabledBackgroundColor: RoastAppTheme.lime.withOpacity(0.75),
      ),
      onPressed: isDisabled(ref)
          ? null
          : () {
              final tService = ref.read(roastTimerProvider);
              final now = tService.elapsed() ?? const Duration(seconds: 0);

              if (instruction != null) {
                final timeline = ref.read(roastTimelineProvider);
                // This method checks for double presses, in which case it
                // returns a non-null RoastTimeline result which handles the
                // double press case.
                final alreadyPressedTimeline = InstructionsService()
                    .checkControlWasLastPressed(
                        timeline, control, instruction!.core);

                if (alreadyPressedTimeline != null) {
                  // Save the new RoastTimeline that has handled the double
                  // press case.
                  ref.read(roastTimelineProvider.notifier).state =
                      alreadyPressedTimeline;

                  // Mark the instruction completed.
				  ref.read(coreInstructionsProvider.notifier).update((state) {
					return InstructionsService().skipInstruction(state!, instruction!);
				  });

                  // Nothing else to do. Do not add a second control log for
                  // this.
                  return;
                }
              }

              final Duration? timeDiff;
              if (instruction != null) {
                timeDiff = instruction!.time;

				// Mark the instruction completed.
				ref.read(coreInstructionsProvider.notifier).update((state) {
				  return InstructionsService().skipInstruction(state!, instruction!);
				});
              } else {
                final instructions = ref.read(temporalInstructionsProvider);

				// If we're pressing P5 in the control panel, and the
				// instructions say we're 5 seconds late to press P5, then
				// retrieve and complete that corresponding instruction.
                final isFulfillingInstruction = InstructionsService()
                    .checkControlFulfillsInstruction(
                        now, control, instructions);

                // Use the time diff for this instruction, if it exists.
                timeDiff = isFulfillingInstruction?.time;

                if (isFulfillingInstruction != null) {
				  // Mark instruction completed.
                  ref.read(coreInstructionsProvider.notifier).update((state) {
                    return InstructionsService()
                        .skipInstruction(state!, isFulfillingInstruction);
                  });
                }
              }

              final newLog = ControlLog(
                time: now,
                control: control,
                instructionTimeDiff: timeDiff,
              );

              ref
                  .read(roastTimelineProvider.notifier)
                  .update((state) => state.addLog(newLog));
            },
      child: Text(control.toString().replaceAll('Control.', '').toUpperCase()),
    );
  }
}
