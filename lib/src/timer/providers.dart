import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/services/roast_log_service.dart';
import 'package:behmor_roast/src/timer/models/projection.dart';
import 'package:behmor_roast/src/timer/models/temp_log.dart';
import 'package:behmor_roast/src/timer/services/projection_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/timer/services/timer_service.dart';

final timerServiceProvider = Provider((_) {
  return TimerService();
});

final secondsProvider = StreamProvider<Duration>((ref) {
  final tService = ref.watch(timerServiceProvider);
  return tService.seconds;
});

final checkTempStreamProvider = StreamProvider<void>((ref) {
  final tService = ref.watch(timerServiceProvider);
  return tService.checkTemp;
});

final showTempInputProvider = StateProvider<bool>((ref) {
  // This watch induces regular updates to set state to true.
  // We use `hasValue` so that it begins false.
  return ref.watch(checkTempStreamProvider).hasValue;
});

final projectionServiceProvider = Provider((_) {
  return ProjectionService();
});

final projectionProvider = Provider<Projection>((ref) {
  final service = ref.watch(projectionServiceProvider);
  final config = ref.watch(roastProvider)!.config;
  final logs = ref.watch(roastLogsProvider);
  final elapsed = ref.watch(secondsProvider);
  return service.createProjections(roastLogs: logs, roastConfig: config, elapsed: elapsed.value);
});

final temperatureLogsProvider = StateProvider<List<TempLog>>(
  (ref) => [],
);

final controlLogsProvider = StateProvider<List<ControlLog>>(
  (ref) => [],
);

final phaseLogsProvider = StateProvider<List<PhaseLog>>(
  (ref) => [],
);

final roastLogsProvider = Provider<List<RoastLog>>((ref) {
  final temps = ref.watch(temperatureLogsProvider);
  final controls = ref.watch(controlLogsProvider);
  final phases = ref.watch(phaseLogsProvider);
  return RoastLogService().aggregate(temps, phases, controls);
});
