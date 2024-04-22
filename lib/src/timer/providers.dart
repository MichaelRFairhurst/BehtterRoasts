import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
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

final roastTimerProvider = Provider((_) {
  return TimerService();
});

final copyOfRoastProvider = StateProvider<Roast?>((ref) => null);

final preheatTimerProvider = Provider((_) {
  return TimerService();
});

final secondsRoastProvider = StreamProvider<Duration?>((ref) {
  final tService = ref.watch(roastTimerProvider);
  return tService.seconds;
});

final secondsPreheatProvider = StreamProvider<Duration?>((ref) {
  final tService = ref.watch(preheatTimerProvider);
  return tService.seconds;
});

final checkTempStreamProvider = StreamProvider<Duration>((ref) {
  final tService = ref.watch(roastTimerProvider);
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
  final elapsedPreheat = ref.watch(secondsPreheatProvider).value;

  final service = AlertService();
  final projection = ref.watch(projectionProvider);
  final timeline = ref.watch(roastTimelineProvider);
  return service.getAlerts(
    projections: projection,
    timeline: timeline,
    elapsed: elapsed,
    elapsedPreheat: elapsedPreheat,
  );
});

final roastLogsProvider = Provider<List<RoastLog>>((ref) {
  final timeline = ref.watch(roastTimelineProvider);
  final copy = ref.watch(copyOfRoastProvider);
  return RoastLogService().aggregate(timeline, copy: copy?.toTimeline());
});

final tipsProvider = Provider<Set<String>>((ref) {
  final service = TipsService();
  final timeline = ref.watch(roastTimelineProvider);
  final roastLogs = ref.watch(roastLogsProvider);
  return service.getTips(timeline, roastLogs);
});

final roastTimelineProvider =
    StateProvider<RoastTimeline>((ref) => const RoastTimeline(rawLogs: []));

final roastStateProvider = Provider<RoastState>((ref) {
  return ref.watch(roastTimelineProvider).roastState;
});
