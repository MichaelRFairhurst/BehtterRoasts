import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/timer/models/projection.dart';

class ProjectionService {
  Projection createProjections({
    required List<RoastLog> roastLogs,
    required Duration? elapsed,
  }) {
    double? currentTemp;
    double? temp30s;
    double? temp60s;

    if (elapsed != null && roastLogs.length > 1) {
	  final temp = roastLogs.last.tempLog.temp;
	  final ror = roastLogs.last.rateOfRise!;
      final lastTime = roastLogs.last.tempLog.time;
      final since = elapsed - lastTime;
      final sinceMinutes = since.inMilliseconds / 1000.0 / 60.0;

      currentTemp = temp + sinceMinutes * ror;
      temp30s = currentTemp + ror / 2;
      temp60s = currentTemp + ror;
	}

    return Projection(
      currentTemp: currentTemp,
      temp30s: temp30s,
      temp60s: temp60s,
    );
  }
}
