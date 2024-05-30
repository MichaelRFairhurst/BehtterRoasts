import 'package:behmor_roast/src/behmor/constants.dart';
import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/timer/models/alert.dart';
import 'package:behmor_roast/src/timer/models/projection.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:collection/collection.dart';

const _maxRecommendedTemp = overheatTemp - 6;
const _riskyHighPowerEndSmokeSuppressorTemp = overheatTemp - 30;

class AlertService {
  List<Alert> getAlerts({
    required RoastTimeline timeline,
    required Projection projections,
    Duration? elapsed,
    Duration? elapsedPreheat,
  }) {
    final results = <Alert>[];
    final timeToOverheat = projections.timeToOverheat;

    final lastPower = timeline.rawLogs
        .whereType<ControlLog>()
        .lastWhereOrNull((log) => log.control != Control.d)
        ?.control;

    if (timeline.roastState == RoastState.preheating &&
        elapsedPreheat! > maxRecommendedPreheat) {
      results.add(const Alert(
        kind: AlertKind.preheatMax,
        severity: Severity.warning,
        message: 'It is not recommended to preheat for longer than 1m45s',
      ));
    }

    if (elapsed == null || timeline.roastState != RoastState.roasting) {
      return results;
    }

    if (timeline.secondCrackStart != null) {
      results.add(const Alert(
        kind: AlertKind.pastSecondCrack,
        severity: Severity.warning,
        message: 'Roasting more than 10 seconds past second crack is dangerous'
            ' and can cause a roaster fire!',
      ));
    }

    if (timeToOverheat != null &&
        timeToOverheat < const Duration(seconds: 90)) {
      final severity = timeToOverheat < const Duration(seconds: 45)
          ? Severity.warning
          : Severity.alert;
      results.add(Alert(
        kind: AlertKind.willOverheat,
        severity: severity,
        message: 'Roaster projected to overheat in'
            ' ${timeToOverheat.inSeconds} seconds',
      ));
    } else if (projections.currentTemp != null &&
        projections.currentTemp! >= _maxRecommendedTemp) {
      results.add(const Alert(
        kind: AlertKind.willOverheat,
        severity: Severity.warning,
        message: 'Roaster will shut down if it reaches $overheatTemp°F',
      ));
    }

    final timePastPressStart = elapsed - pressStartTime;
    if (!timePastPressStart.isNegative &&
        timePastPressStart < const Duration(seconds: 30)) {
      results.add(const Alert(
        kind: AlertKind.willShutOff,
        severity: Severity.warning,
        message: 'Press START, or the roaster will automatically off!',
      ));
    }

    final timeToSmoke = smokeSuppressorOnTime - elapsed;
    final timeToSmokeOff = smokeSuppressorOffTime - elapsed;
    if (timeToSmoke < const Duration(seconds: 45) && !timeToSmoke.isNegative) {
      results.add(Alert(
        kind: AlertKind.smokeSuppressorOn,
        severity: Severity.alert,
        message: 'Smoke suppressor turns on in ~${timeToSmoke.inSeconds}'
            ' seconds, and roast temps will quickly fall.',
      ));
    } else if (timeToSmokeOff < const Duration(seconds: 30) &&
        !timeToSmokeOff.isNegative &&
        lastPower == Control.p5 &&
        (projections.currentTemp ?? 0) >
            _riskyHighPowerEndSmokeSuppressorTemp) {
      results.add(Alert(
        kind: AlertKind.smokeSuppressorOff,
        severity: Severity.alert,
        message: 'Smoke suppressor turns off in ~${timeToSmokeOff.inSeconds}'
            ' seconds, and roast temps will begin to rise.',
      ));
    }

    return results;
  }
}
