import 'package:behmor_roast/src/instructions/providers.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/roast/services/roast_log_service.dart';
import 'package:behmor_roast/src/timer/models/alert.dart';
import 'package:behmor_roast/src/timer/models/projection.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/services/alert_service.dart';
import 'package:behmor_roast/src/timer/services/buzz_beep_service.dart';
import 'package:behmor_roast/src/timer/services/projection_service.dart';
import 'package:behmor_roast/src/timer/services/roast_manager_service.dart';
import 'package:behmor_roast/src/timer/services/tips_service.dart';
import 'package:behmor_roast/src/timer/services/wakelock_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/timer/services/timer_service.dart';

final wakelockServiceProvider = Provider((_) {
  return WakelockService();
});

final buzzBeepServiceProvider = Provider((_) {
  return BuzzBeepService();
});

final roastTimerProvider = Provider((ref) {
  return TimerService(
    id: 'roastTimer',
    wakelockService: ref.watch(wakelockServiceProvider),
  );
});

final copyOfRoastProvider = StreamProvider<Roast?>(
    (ref) => ref.watch(roastManagerProvider).copyOfRoast);

final preheatTimerProvider = Provider((ref) {
  return TimerService(
    id: 'preheatTimer',
    wakelockService: ref.watch(wakelockServiceProvider),
  );
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

final projectionProvider = StreamProvider<Projection>((ref) {
  return ref.watch(roastManagerProvider).projection;
});

final alertsProvider = Provider<List<Alert>>((ref) {
  final timeline = ref.watch(roastTimelineProvider).value;
  final projection = ref.watch(projectionProvider);
  if (timeline == null || !projection.hasValue) {
    return [];
  }
  final elapsed = ref.watch(secondsRoastProvider).value;
  final elapsedPreheat = ref.watch(secondsPreheatProvider).value;

  final service = AlertService();
  return service.getAlerts(
    projections: projection.requireValue,
    timeline: timeline,
    elapsed: elapsed,
    elapsedPreheat: elapsedPreheat,
  );
});

final roastLogsProvider = StreamProvider<List<RoastLog>>((ref) {
  return ref.watch(roastManagerProvider).roastLogs;
});

final tipsProvider = Provider<Set<String>>((ref) {
  final timeline = ref.watch(roastTimelineProvider).value;
  if (timeline == null) {
    return {};
  }
  final service = TipsService();
  final roastLogs = ref.watch(roastLogsProvider);
  return service.getTips(timeline, roastLogs.requireValue);
});

final roastManagerProvider = Provider<RoastManagerService>((ref) {
  return RoastManagerService(
    roastLogService: RoastLogService(),
	projectionService: ProjectionService(),
    timerService: ref.watch(roastTimerProvider),
    preheatTimerService: ref.watch(preheatTimerProvider),
  );
});

final roastTimelineProvider = StreamProvider<RoastTimeline>(
    (ref) => ref.watch(roastManagerProvider).roastTimeline);

final roastStateProvider = Provider<RoastState>((ref) {
  return ref.watch(roastTimelineProvider).value?.roastState ??
      RoastState.waiting;
});

void initRoastManagerStreamProviders(WidgetRef ref) {
  ref.read(roastManagerProvider);
  ref.read(roastTimelineProvider);
  ref.read(roastLogsProvider);
  ref.read(projectionProvider);
  ref.read(copyOfRoastProvider);
  ref.read(roastLogsCopyProvider);
  ref.read(temporalInstructionsProvider);
}
