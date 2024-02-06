import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/roast/services/roast_log_service.dart';
import 'package:behmor_roast/src/timer/models/temp_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/timer/services/timer_service.dart';

final timerServiceProvider = Provider((_) {
  return TimerService();
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

final temperatureLogsProvider = StateProvider<List<TempLog>>(
  (ref) => [],
);

final roastLogsProvider = Provider<List<RoastLog>>((ref) {
  final temps = ref.watch(temperatureLogsProvider);
  return RoastLogService().fromTempLogs(temps);
});
