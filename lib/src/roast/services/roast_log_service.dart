import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/timer/models/temp_log.dart';

class RoastLogService {
  List<RoastLog> fromTempLogs(List<TempLog> temps) {
    final result = <RoastLog>[];

    TempLog? previous;

    for (final temp in temps) {
	  if (previous == null) {
	    result.add(RoastLog(tempLog: temp));
	  } else {
	    final duration = temp.time - previous.time;
		final rise = temp.temp - previous.temp;
	    result.add(RoastLog(
		  tempLog: temp,
		  rateOfRise: rise / (duration.inMilliseconds / 1000.0 / 60.0),
		));
	  }
	  previous = temp;
	}

    return result;
  }
}
