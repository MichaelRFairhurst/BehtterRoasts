import 'package:behmor_roast/src/roast/models/base_log.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/roast/models/temp_log.dart';

class RoastProfileService {
  TempIterator iterateProfile(Iterable<BaseLog> baseLogs) =>
      TempIterator._(baseLogs);
}

class TempIterator {
  final List<TempLog> logs;
  int offset = 0;
  RoastLog? prev;

  TempIterator._(Iterable<BaseLog> logs)
      : logs = logs.whereType<TempLog>().toList();

  int? getTempDiff(TempLog log) {
    final copyTemp = getTemp(log.time);
    if (copyTemp == null) {
      return null;
    }
    return log.temp - copyTemp;
  }

  int? getTemp(Duration time) {
    // Find the first log which is at or past the requested time.
    while (logs[offset].time < time) {
      if (offset + 1 == logs.length) {
        return null;
      }

      offset++;
    }

    final log = logs[offset];
    if (time.inSeconds == log.time.inSeconds) {
      return logs[offset].temp;
    } else {
      if (offset == 0) {
        return null;
      }

      final prev = logs[offset - 1];
      final gap = log.time - prev.time;
      final progress = (time - prev.time).inMilliseconds / gap.inMilliseconds;
      final delta = log.temp - prev.temp;
      return prev.temp + (delta * progress).toInt();
    }
  }
}
