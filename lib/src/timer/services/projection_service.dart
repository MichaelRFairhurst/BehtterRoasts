import 'package:behmor_roast/src/roast/models/roast_config.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/timer/models/projection.dart';

class ProjectionService {
  Projection createProjections({
	required RoastConfig roastConfig,
    required List<RoastLog> roastLogs,
    required Duration? elapsed,
  }) {
    double? currentTemp;
    double? temp30s;
    double? temp60s;
    Duration? roastTime;
    Duration? timeRemaining;
    final tempLogs = roastLogs.where((log) => log.temp != null).toList();
    final phaseLogs = roastLogs.where((log) => log.phase != null).toList();

    if (elapsed != null && tempLogs.length > 1) {
	  final temp = tempLogs.last.temp!;
	  final ror = tempLogs.last.rateOfRise!;
      final lastTime = tempLogs.last.time;
      final since = elapsed - lastTime;
      final sinceMinutes = since.inMilliseconds / 1000.0 / 60.0;

      currentTemp = temp + sinceMinutes * ror;
      temp30s = currentTemp + ror / 2;
      temp60s = currentTemp + ror;
	}

    if (elapsed != null && phaseLogs.isNotEmpty) {
      if (phaseLogs.last.phase == RoastPhase.firstCrackEnd) {
		final inverseRatio = 1.0 / (1.0 - roastConfig.targetDevelopment);
		roastTime = phaseLogs.last.time * inverseRatio;
		timeRemaining = roastTime - elapsed;
	  }
	}

    return Projection(
	  roastTime: roastTime,
	  timeRemaining: timeRemaining,
      currentTemp: currentTemp,
      temp30s: temp30s,
      temp60s: temp60s,
    );
  }
}
