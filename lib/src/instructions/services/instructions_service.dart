import 'package:behmor_roast/src/instructions/models/instruction.dart';
import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/roast/services/roast_profile_service.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:collection/collection.dart';

class InstructionsService {
  List<CoreInstruction> createCoreCopyInstructions(
      List<RoastLog> copyRoastLogs, RoastTimeline copyTimeline) {
    final profile = RoastProfileService().iterateProfile(copyTimeline.rawLogs);
    final controlLogs =
        copyRoastLogs.where((log) => log.control != null).toList();

    return [
      for (int i = 0; i < controlLogs.length; ++i)
        if (controlLogs[i].control != null)
          CoreInstruction(
            index: i,
            temp: profile.getTemp(controlLogs[i].time),
            time: controlLogs[i].time,
            control: controlLogs[i].control!,
            skipped: false,
          )
    ];
  }

  List<TemporalInstruction> createTemporalInstructions(
    Duration now,
    List<CoreInstruction> coreInstructions,
  ) {
    return coreInstructions
        .where((core) => !core.skipped)
        .map((core) => TemporalInstruction(
              time: core.time - now,
              core: core,
            ))
        .toList();
  }

  List<CoreInstruction> skipInstruction(
          List<CoreInstruction> coreInstructions, TemporalInstruction toSkip) =>
      [
        for (final core in coreInstructions)
          if (identical(toSkip.core, core))
            core.copyWith(
              skipped: true,
            )
          else
            core,
      ];

  /// When a control button is pressed (eg P4 or P5) as an instruction, and the
  /// power level already matches, return an updated timeline, else null.
  ///
  /// Sets the [instructionTimeDiff] on the the timeline's relevant prior power
  /// instruction. The caller of this function should save this result, and does
  /// not need to create new control logs. If this returns null, it means that
  /// no matching instruction was found and the caller should continue adding a
  /// new control log with time diff.
  ///
  /// The relevant prior power instruction may already have a time diff. In this
  /// case, an unchanged timeline is returned, and the current instruction
  /// should be skipped by the caller.
  ///
  /// This handles the case where a user hits P5 at the start of a roast, then
  /// sees the P5 instruction, and hits that button. Without this logic, the
  /// user would see two P5 instructions where one of them is late.
  RoastTimeline? checkControlWasLastPressed(
      RoastTimeline timeline, Control control, CoreInstruction instruction) {
    final lastPowerLog = timeline.rawLogs
        .whereType<ControlLog>()
        .lastWhereOrNull((log) => log.control != Control.d);

    if (lastPowerLog?.control != control) {
      // Normal behavior; user is changing power level on the roaster, return
      // null to fulfill API contract.
      return null;
    }

    // If we are here, the user hit a P5 instruction when the power level is
    // already P5.

    if (lastPowerLog!.instructionTimeDiff != null) {
      // User hit P5 -> P1 -> P5 last roast, this time hit P5 *skip* P5.
      // Return the timeline unchanged as per API contract. Caller should skip
      // the second P5 instruction.
      return timeline;
    }

    // If we are here, the user seems to have just pressed P5 twice; once on
    // the control panel and then once in the instruction panel.

    // The actual time diff for following this instruction is based on the prior
    // P5 press, not the current time.
    final timeDiff = instruction.time - lastPowerLog.time;

    // Update the prior P5 control log to note that it was early or late.
    return timeline.copyWith(
      rawLogs: timeline.rawLogs.map((log) {
        if (identical(log, lastPowerLog)) {
          return lastPowerLog.copyWith(
            instructionTimeDiff: timeDiff,
          );
        } else {
          return log;
        }
      }).toList(),
    );
  }

  /// When a control button is pressed (eg P4, P5) and we're on time or late for
  /// an instruction to hit P4 or P5, get that instruction, else null.
  ///
  /// Assumes that if the control is within 30 seconds of the first upcoming
  /// instruction, or if the upcoming instruction is late, that we're fulfilling
  /// that instruction.
  ///
  /// Currently does not handle the case where we're fulfilling a later
  /// instruction than the first upcoming one. As future work, it would possibly
  /// be better to identify future instructions matching this criteria, mark
  /// that instruction as fulfilled, and skip all prior instructions as well.
  TemporalInstruction? checkControlFulfillsInstruction(
      Duration now, Control control, List<TemporalInstruction>? instructions) {
    if (instructions == null || instructions.isEmpty) {
      return null;
    }

    final first = instructions.first;
    if (first.core.control == control &&
        first.time < const Duration(seconds: 15)) {
      return first;
    }

    return null;
  }
}
