import 'package:behmor_roast/src/timer/models/alert.dart';
import 'package:behmor_roast/src/timer/models/projection.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';

const _smokeSuppressorTime = Duration(seconds: 7 * 60 + 45);
// Technically, this is 75% of roast time. This is correct for 1lb P5 roasts.
const _pressStartTime = Duration(seconds: 13 * 60 + 30);

const _maxRecommendedPreheat = Duration(seconds: 60 + 45);

class AlertService {
  List<Alert> getAlerts({
    required RoastTimeline timeline,
    required Projection projections,
    Duration? elapsed,
    Duration? elapsedPreheat,
  }) {
    final results = <Alert>[];
    final timeToOverheat = projections.timeToOverheat;

    if (timeline.roastState == RoastState.preheating &&
        elapsedPreheat! > _maxRecommendedPreheat) {
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
    }

    final timePastPressStart = elapsed - _pressStartTime;
    if (!timePastPressStart.isNegative &&
        timePastPressStart < const Duration(seconds: 30)) {
      results.add(const Alert(
        kind: AlertKind.smokeSuppressor,
        severity: Severity.warning,
        message: 'Press START, or the roaster will automatically off!',
      ));
    }

    final timeToSmoke = _smokeSuppressorTime - elapsed;
    if (timeToSmoke < const Duration(seconds: 45) && !timeToSmoke.isNegative) {
      results.add(Alert(
        kind: AlertKind.smokeSuppressor,
        severity: Severity.alert,
        message: 'Smoke suppressor turns on in ${timeToSmoke.inSeconds}'
            ' seconds, and roast temps will quickly fall.',
      ));
    }

    return results;
  }
}
