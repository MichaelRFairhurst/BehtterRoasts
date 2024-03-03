import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/roast/models/temp_log.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/services/roast_log_service.dart';
import 'package:behmor_roast/src/timer/models/alert.dart';
import 'package:behmor_roast/src/timer/models/projection.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/services/alert_service.dart';
import 'package:behmor_roast/src/timer/services/projection_service.dart';
import 'package:behmor_roast/src/timer/services/tips_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/timer/services/timer_service.dart';

final timerServiceProvider = Provider((_) {
  return TimerService();
});

final secondsRoastProvider = StreamProvider<Duration?>((ref) {
  final tService = ref.watch(timerServiceProvider);
  return tService.secondsRoast;
});

final secondsTotalProvider = StreamProvider<Duration?>((ref) {
  final tService = ref.watch(timerServiceProvider);
  return tService.secondsTotal;
});

final timerStateProvider = StreamProvider<RoastTimerState>((ref) {
  final tService = ref.watch(timerServiceProvider);
  return tService.state;
});

final checkTempStreamProvider = StreamProvider<Duration>((ref) {
  final tService = ref.watch(timerServiceProvider);
  return tService.checkTemp;
});

final showTempInputTimeProvider = StateProvider<Duration?>((ref) {
  // This watch induces regular updates to reset the state.
  return ref.watch(checkTempStreamProvider).value;
});

final projectionServiceProvider = Provider((_) {
  return ProjectionService();
});

final projectionProvider = Provider<Projection>((ref) {
  final service = ref.watch(projectionServiceProvider);
  final config = ref.watch(roastProvider)!.config;
  final logs = ref.watch(roastLogsProvider);
  final elapsed = ref.watch(secondsRoastProvider);
  return service.createProjections(
      roastLogs: logs, roastConfig: config, elapsed: elapsed.value);
});

final alertsProvider = Provider<List<Alert>>((ref) {
  final elapsed = ref.watch(secondsRoastProvider).value;
  if (elapsed == null) {
    return [];
  }

  final service = AlertService();
  final projection = ref.watch(projectionProvider);
  final logs = ref.watch(roastLogsProvider);
  return service.getAlerts(
    projections: projection,
    roastLogs: logs,
    elapsed: elapsed,
  );
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

final tipsProvider = Provider<Set<String>>((ref) {
  final service = TipsService();
  final roastLogs = ref.watch(roastLogsProvider);
  final running =
      ref.watch(timerStateProvider).value == RoastTimerState.roasting;
  return service.getTips(roastLogs, running);
});

final roastTimelineProvider = Provider<RoastTimeline>((ref) {
  final tService = ref.watch(timerServiceProvider);
  final temps = ref.watch(temperatureLogsProvider);
  final controls = ref.watch(controlLogsProvider);
  final phases = ref.watch(phaseLogsProvider);
  return RoastTimeline.fromRawLogs(rawLogs: [
    ...temps,
    ...controls,
    ...phases,
  ], startTime: tService.roastTime, preheatStart: tService.startTime);
});
