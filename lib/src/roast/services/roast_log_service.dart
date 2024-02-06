import 'package:behmor_roast/src/roast/models/base_log.dart';
import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/timer/models/temp_log.dart';

class RoastLogService {
  List<RoastLog> aggregate(
    List<TempLog> temps,
    List<PhaseLog> phases,
    List<ControlLog> controls,
  ) {
    final result = <RoastLog>[];

    TempLog? previousTemp;

    final logs = <BaseLog>[...temps, ...phases, ...controls];

    for (final log in logs) {
      if (log is TempLog) {
	    if (previousTemp == null) {
	      result.add(RoastLog(time: log.time, temp: log.temp));
	    } else {
	      final duration = log.time - previousTemp.time;
	      final rise = log.temp - previousTemp.temp;
	      result.add(RoastLog(
            time: log.time,
	        temp: log.temp,
	        rateOfRise: rise / (duration.inMilliseconds / 1000.0 / 60.0),
	      ));
	    }
	    previousTemp = log;
      }

      if (log is PhaseLog) {
        result.add(RoastLog(time: log.time, phase: log.phase));
      }

      if (log is ControlLog) {
        result.add(RoastLog(time: log.time, control: log.control));
      }
	}

    return result;
  }
}
