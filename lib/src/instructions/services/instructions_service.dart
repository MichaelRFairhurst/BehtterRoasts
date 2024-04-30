import 'package:behmor_roast/src/instructions/models/instruction.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/roast/services/roast_profile_service.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';

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
}
