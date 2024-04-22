import 'package:behmor_roast/src/roast/models/base_log.dart';
import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/roast/models/temp_log.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';

class RoastLogService {
  List<RoastLog> aggregate(RoastTimeline timeline, {RoastTimeline? copy}) {
    final result = <RoastLog>[];

    TempLog? previousTemp;

    final logs = timeline.rawLogs;
    final copyTempIterator = copy == null ? null : _TempIterator(copy.rawLogs);

    for (final log in logs) {
      if (log is TempLog) {
        if (previousTemp == null) {
          result.add(RoastLog(
              time: log.time,
              temp: log.temp,
              tempDiff: copyTempIterator?.getTempDiff(log)));
        } else {
          final duration = log.time - previousTemp.time;
          final rise = log.temp - previousTemp.temp;
          result.add(RoastLog(
            time: log.time,
            temp: log.temp,
            rateOfRise: rise / (duration.inMilliseconds / 1000.0 / 60.0),
            tempDiff: copyTempIterator?.getTempDiff(log),
          ));
        }
        previousTemp = log;
      }

      if (log is ControlLog) {
        result.add(RoastLog(
            time: log.time,
            control: log.control,
            timeDiff: log.instructionTimeDiff));
      }
    }

    if (timeline.preheatStart != null && timeline.preheatEnd != null) {
      final preheatGap = timeline.preheatGap;
      if (preheatGap == null) {
        result.add(RoastLog(
            time: timeline.preheatEnd!,
            temp: timeline.preheatTemp,
            phase: RoastPhase.preheat));
      } else {
        result.add(RoastLog(
            time: preheatGap * -1,
            temp: timeline.preheatTemp,
            phase: RoastPhase.preheat));
      }
    }

    if (timeline.dryEnd != null) {
      result.add(RoastLog(
        time: timeline.dryEnd!,
        phase: RoastPhase.dryEnd,
        timeDiff: copy == null ? null : copy.dryEnd! - timeline.dryEnd!,
      ));
    }

    if (timeline.firstCrackStart != null) {
      result.add(RoastLog(
        time: timeline.firstCrackStart!,
        phase: RoastPhase.firstCrackStart,
        timeDiff: copy == null
            ? null
            : copy.firstCrackStart! - timeline.firstCrackStart!,
      ));
    }

    if (timeline.firstCrackEnd != null) {
      result.add(RoastLog(
        time: timeline.firstCrackEnd!,
        phase: RoastPhase.firstCrackEnd,
        timeDiff:
            copy == null ? null : copy.firstCrackEnd! - timeline.firstCrackEnd!,
      ));
    }

    if (timeline.secondCrackStart != null) {
      result.add(RoastLog(
        time: timeline.secondCrackStart!,
        phase: RoastPhase.secondCrackStart,
        timeDiff: copy == null
            ? null
            : copy.secondCrackStart! - timeline.secondCrackStart!,
      ));
    }

    if (timeline.done != null) {
      result.add(RoastLog(
        time: timeline.done!,
        phase: RoastPhase.done,
        timeDiff: copy == null ? null : copy.done! - timeline.done!,
      ));
    }

    result.sort((a, b) => a.time.compareTo(b.time));

    return result;
  }
}

class _TempIterator {
  final List<TempLog> logs;
  int offset = 0;
  RoastLog? prev;

  _TempIterator(Iterable<BaseLog> logs)
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
