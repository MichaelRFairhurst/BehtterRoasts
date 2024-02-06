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
    final tempLogs = roastLogs.where((log) => log.temp != null).toList();

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

    return Projection(
      currentTemp: currentTemp,
      temp30s: temp30s,
      temp60s: temp60s,
    );
  }
}
