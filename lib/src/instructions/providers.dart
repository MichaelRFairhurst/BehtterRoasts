import 'package:behmor_roast/src/instructions/models/instruction.dart';
import 'package:behmor_roast/src/instructions/services/instructions_service.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/roast/services/roast_log_service.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roastLogsCopyProvider = Provider<List<RoastLog>?>((ref) {
  final service = RoastLogService();
  final copy = ref.watch(copyOfRoastProvider);
  if (copy != null) {
    return service.aggregate(copy.toTimeline());
  }
  return null;
});

final coreInstructionsProvider = StateProvider<List<CoreInstruction>?>((ref) {
  // Watch these so the instructions are rebuilt. Note: this resets which
  // have been skipped.
  final copyTimeline = ref.watch(copyOfRoastProvider)?.toTimeline();
  final copyLogs = ref.watch(roastLogsCopyProvider);
  if (copyLogs != null && copyTimeline != null) {
    return InstructionsService()
        .createCoreCopyInstructions(copyLogs, copyTimeline);
  } else {
    return null;
  }
});

final temporalInstructionsProvider =
    Provider<List<TemporalInstruction>?>((ref) {
  final core = ref.watch(coreInstructionsProvider);
  final elapsed = ref.watch(secondsRoastProvider).valueOrNull;
  if (core != null && elapsed != null) {
    return InstructionsService().createTemporalInstructions(elapsed, core);
  } else {
    return null;
  }
});
