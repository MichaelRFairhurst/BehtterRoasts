import 'package:behmor_roast/src/roast/models/base_log.dart';
import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'roast_timeline.freezed.dart';

enum RoastState {
  waiting,
  preheating,
  preheatDone,
  roasting,
  done,
}

@freezed
class RoastTimeline with _$RoastTimeline {
  const RoastTimeline._();

  const factory RoastTimeline({
    required List<BaseLog> rawLogs,
    Duration? preheatEnd,
    Duration? startTime,
    Duration? dryEnd,
    Duration? firstCrackStart,
    Duration? firstCrackEnd,
    Duration? secondCrackStart,
    Duration? done,
  }) = _RoastTimeline;

  factory RoastTimeline.fromRawLogs(List<BaseLog> rawLogs) {
    Duration? preheatEnd;
    Duration? startTime;
    Duration? dryEnd;
    Duration? firstCrackStart;
    Duration? firstCrackEnd;
    Duration? secondCrackStart;
    Duration? done;

    for (final log in rawLogs) {
      if (log is PhaseLog) {
        switch (log.phase) {
          case Phase.preheatEnd:
            preheatEnd = log.time;
            break;
          case Phase.start:
            startTime = log.time;
            break;
          case Phase.dryEnd:
            dryEnd = log.time;
            break;
          case Phase.firstCrack:
            firstCrackStart ??= log.time;
            firstCrackEnd = log.time;
            break;
          case Phase.secondCrack:
            secondCrackStart = log.time;
            break;
          case Phase.done:
            done = log.time;
            break;
        }
      }
    }

    return RoastTimeline(
      rawLogs: rawLogs,
      preheatEnd: preheatEnd,
      startTime: startTime,
      dryEnd: dryEnd,
      firstCrackStart: firstCrackStart,
      firstCrackEnd: firstCrackEnd,
      secondCrackStart: secondCrackStart,
      done: done,
    );
  }

  RoastState get roastState {
    if (done != null) {
      return RoastState.done;
    }

    if (startTime != null) {
      return RoastState.roasting;
    }

    if (preheatEnd != null) {
      return RoastState.preheatDone;
    }

    /*
    if (preheatStart != null) {
      return RoastState.preheating;
    }
	*/

    return RoastState.waiting;
  }
}
