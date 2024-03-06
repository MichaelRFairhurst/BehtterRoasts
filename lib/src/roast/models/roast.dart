import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/roast/models/temp_log.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:behmor_roast/src/roast/models/roast_config.dart';

part 'roast.freezed.dart';
part 'roast.g.dart';

@Freezed()
class Roast with _$Roast {
  const Roast._();

  const factory Roast({
    required String beanId,
    required RoastConfig config,
    required int roastNumber,
    required double weightIn,
    required double weightOut,
    required DateTime roasted,
    String? notes,
    @Default([]) List<TempLog> tempLogs,
    @Default([]) List<ControlLog> controlLogs,
    @Default([]) List<_PhaseLog> phaseLogs,
  }) = _Roast;

  factory Roast.fromJson(Map<String, dynamic> json) => _$RoastFromJson(json);

  RoastTimeline toTimeline() {
    Duration? preheatEnd;
    Duration? dryEnd;
    Duration? firstCrackStart;
    Duration? firstCrackEnd;
    Duration? secondCrackStart;
    Duration? done;

    for (final log in phaseLogs) {
      switch (log.phase) {
        case _Phase.preheatEnd:
          preheatEnd = log.time;
          break;
        case _Phase.dryEnd:
          dryEnd = log.time;
          break;
        case _Phase.crack:
        case _Phase.firstCrack:
          firstCrackStart ??= log.time;
          firstCrackEnd = log.time;
          break;
        case _Phase.secondCrack:
          secondCrackStart = log.time;
          break;
        case _Phase.done:
          done = log.time;
          break;
      }
    }

    return RoastTimeline(
      rawLogs: [...tempLogs, ...controlLogs],
      //preheatStart: preheatStart,
      preheatEnd: preheatEnd,
      //startTime: startTime,
      dryEnd: dryEnd,
      firstCrackStart: firstCrackStart,
      firstCrackEnd: firstCrackEnd,
      secondCrackStart: secondCrackStart,
      done: done,
    );
  }

  Roast withTimeline(RoastTimeline timeline) {
    final phaseLogs = <_PhaseLog>[];
    if (timeline.dryEnd != null) {
      phaseLogs.add(_PhaseLog(phase: _Phase.dryEnd, time: timeline.dryEnd!));
    }
    if (timeline.firstCrackStart != null) {
      phaseLogs.add(
          _PhaseLog(phase: _Phase.firstCrack, time: timeline.firstCrackStart!));
    }
    if (timeline.firstCrackEnd != null) {
      phaseLogs.add(
          _PhaseLog(phase: _Phase.firstCrack, time: timeline.firstCrackEnd!));
    }
    if (timeline.secondCrackStart != null) {
      phaseLogs.add(_PhaseLog(
          phase: _Phase.secondCrack, time: timeline.secondCrackStart!));
    }
    if (timeline.done != null) {
      phaseLogs.add(_PhaseLog(phase: _Phase.done, time: timeline.done!));
    }

    return copyWith(
      tempLogs: timeline.rawLogs.whereType<TempLog>().toList(),
      controlLogs: timeline.rawLogs.whereType<ControlLog>().toList(),
      phaseLogs: phaseLogs,
      roasted: timeline.startTime!,
    );
  }
}

enum _Phase {
  preheatEnd,
  start,
  dryEnd,
  crack,
  firstCrack,
  secondCrack,
  done,
}

class _PhaseLog {
  const _PhaseLog({
    required this.time,
    required this.phase,
  });

  final _Phase phase;
  final Duration time;

  Map<String, Object> toJson() => {
        'phase': phase.toString().replaceAll('_Phase.', ''),
        'time': time.inMicroseconds,
      };

  factory _PhaseLog.fromJson(Map<String, Object> json) {
    final time = Duration(microseconds: json['time'] as int);
    final phase = _Phase.values
        .singleWhere((p) => p.toString() == '_Phase.${json["phase"]}');

    return _PhaseLog(time: time, phase: phase);
  }
}
