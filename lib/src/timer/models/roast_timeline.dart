import 'package:behmor_roast/src/roast/models/base_log.dart';
import 'package:behmor_roast/src/roast/models/temp_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'roast_timeline.freezed.dart';

enum RoastState {
  waiting,
  preheating,
  preheatDone,
  ready,
  roasting,
  done,
}

@freezed
class RoastTimeline with _$RoastTimeline {
  const RoastTimeline._();

  const factory RoastTimeline({
    required List<BaseLog> rawLogs,
    DateTime? preheatStart,
    Duration? preheatEnd,
    int? preheatTemp,
    DateTime? startTime,
    Duration? dryEnd,
    Duration? firstCrackStart,
    Duration? firstCrackEnd,
    Duration? secondCrackStart,
    Duration? done,
  }) = _RoastTimeline;

  RoastTimeline addLog(BaseLog log) => copyWith(
        rawLogs: rawLogs.toList()..add(log),
      );

  RoastTimeline updateTemp(Duration time, int temp) => copyWith(
        rawLogs: rawLogs.map((log) {
          if (log is TempLog && log.time == time) {
            return log.copyWith(temp: temp);
          }
          return log;
        }).toList(),
      );

  RoastState get roastState {
    if (done != null) {
      return RoastState.done;
    }

    if (startTime != null) {
      return RoastState.roasting;
    }

    if (preheatTemp != null) {
      return RoastState.ready;
    }

    if (preheatEnd != null) {
      return RoastState.preheatDone;
    }

    if (preheatStart != null) {
      return RoastState.preheating;
    }

    return RoastState.waiting;
  }

  Duration? get preheatGap {
    if (startTime == null || preheatStart == null || preheatEnd == null) {
      return null;
    }

    return startTime!.difference(preheatStart!.add(preheatEnd!));
  }
}
