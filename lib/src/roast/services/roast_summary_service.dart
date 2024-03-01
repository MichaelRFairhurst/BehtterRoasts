import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/models/roast_summary.dart';

class RoastSummaryService {
  RoastSummary summarize(Roast roast, Bean bean) {
    final dryPhaseLog =
        roast.phaseLogs.singleWhere((p) => p.phase == Phase.dryEnd);
    final firstCrackLog =
        roast.phaseLogs.firstWhere((p) => p.phase == Phase.firstCrack);
    final firstCrackEndLog =
        roast.phaseLogs.lastWhere((p) => p.phase == Phase.firstCrack);

    final totalTime = roast.phaseLogs.last.time;
    final dryPhaseTime = dryPhaseLog.time;
    final maillardPhaseTime = firstCrackLog.time - dryPhaseLog.time;
    // TODO: Should this do something different when first crack is last crack?
    final firstCrackPhaseTime = firstCrackEndLog.time - firstCrackLog.time;
    final developmentPhaseTime = totalTime - firstCrackEndLog.time;

    Duration? secondCrackPhaseTime;
    double? secondCrackPhasePercent;
    if (roast.phaseLogs.any((p) => p.phase == Phase.secondCrack)) {
      secondCrackPhaseTime =
          roast.phaseLogs.singleWhere((p) => p.phase == Phase.secondCrack).time;
      secondCrackPhasePercent =
          secondCrackPhaseTime.inMilliseconds / totalTime.inMilliseconds;
    }

    return RoastSummary(
      beanName: bean.name,
      totalTime: totalTime,
      dryPhaseTime: dryPhaseTime,
      dryPhasePercent: dryPhaseTime.inMilliseconds / totalTime.inMilliseconds,
      maillardPhaseTime: maillardPhaseTime,
      maillardPhasePercent:
          maillardPhaseTime.inMilliseconds / totalTime.inMilliseconds,
      firstCrackPhaseTime: firstCrackPhaseTime,
      firstCrackPhasePercent:
          firstCrackPhaseTime.inMilliseconds / totalTime.inMilliseconds,
      secondCrackPhaseTime: secondCrackPhaseTime,
      secondCrackPhasePercent: secondCrackPhasePercent,
      developmentPhaseTime: developmentPhaseTime,
      developmentPercent:
          developmentPhaseTime.inMilliseconds / totalTime.inMilliseconds,
      developmentPercentTarget: roast.config.targetDevelopment,
      weightLoss: 1.0 - roast.weightOut / roast.weightIn,
      notes: roast.notes,
    );
  }
}
