import 'package:behmor_roast/src/roast/models/base_log.dart';
import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/roast/models/temp_log.dart';

class RoastLogService {
  List<RoastLog> aggregate(
    List<TempLog> temps,
    List<PhaseLog> phases,
    List<ControlLog> controls,
  ) {
    final result = <RoastLog>[];

    TempLog? previousTemp;

    final logs = <BaseLog>[...temps, ...phases, ...controls]
      ..sort((a, b) => a.time.compareTo(b.time));

    final fstCrackLogs = phases.where((p) => p.phase == Phase.firstCrack);
    final firstCrackStart = fstCrackLogs.isEmpty ? null : fstCrackLogs.first;
    final firstCrackEnd = fstCrackLogs.length < 2 ? null : fstCrackLogs.last;

    final sndCrackLogs =
        phases.where((p) => p.phase == Phase.secondCrack).toList();

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
        if (log.phase == Phase.start || log.phase == Phase.preheatEnd) {
          continue;
        } else if (log.phase == Phase.dryEnd) {
          result.add(RoastLog(time: log.time, phase: RoastPhase.dryEnd));
        } else if (log.phase == Phase.done) {
          result.add(RoastLog(time: log.time, phase: RoastPhase.done));
        } else if (identical(log, firstCrackStart)) {
          result
              .add(RoastLog(time: log.time, phase: RoastPhase.firstCrackStart));
        } else if (identical(log, firstCrackEnd)) {
          result.add(RoastLog(time: log.time, phase: RoastPhase.firstCrackEnd));
        } else if (identical(log, sndCrackLogs[0])) {
          result.add(
              RoastLog(time: log.time, phase: RoastPhase.secondCrackStart));
        }
      }

      if (log is ControlLog) {
        result.add(RoastLog(time: log.time, control: log.control));
      }
    }

    return result;
  }
}
