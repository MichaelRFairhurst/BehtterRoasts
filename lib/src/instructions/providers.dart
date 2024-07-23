import 'package:behmor_roast/src/instructions/models/instruction.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roastLogsCopyProvider = StreamProvider<List<RoastLog>?>((ref) {
  return ref.watch(roastManagerProvider).copyOfRoastLogs;
});

final temporalInstructionsProvider =
    StreamProvider<List<TemporalInstruction>?>((ref) {
  return ref.watch(roastManagerProvider).instructions;
});
