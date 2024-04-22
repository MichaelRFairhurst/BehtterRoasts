import 'package:behmor_roast/src/instructions/models/instruction.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';

class InstructionsService {
  List<CoreInstruction> createCoreCopyInstructions(
      List<RoastLog> copyRoastLogs) {
    return copyRoastLogs
        .where((log) => log.control != null)
        .map((log) => CoreInstruction(
              time: log.time,
              control: log.control!,
              skipped: false,
            ))
        .toList();
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
