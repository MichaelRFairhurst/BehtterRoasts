import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/models/roast_summary.dart';

class RoastSummaryService {
  RoastSummary summarize(Roast roast, Bean bean) {
    final timeline = roast.toTimeline();
    final totalTime = timeline.done!;
    final dryPhaseTime = timeline.dryEnd!;
    final maillardPhaseTime = timeline.firstCrackStart! - dryPhaseTime;
    // TODO: Should this do something different when first crack is last crack?
    final firstCrackPhaseTime =
        timeline.firstCrackEnd! - timeline.firstCrackStart!;
    final developmentPhaseTime = totalTime - timeline.firstCrackEnd!;

    Duration? secondCrackPhaseTime;
    double? secondCrackPhasePercent;
    if (timeline.secondCrackStart != null) {
      secondCrackPhaseTime = totalTime - timeline.secondCrackStart!;
      secondCrackPhasePercent =
          secondCrackPhaseTime.inMilliseconds / totalTime.inMilliseconds;
    }

    return RoastSummary(
      beanName: bean.name,
      roastNumber: roast.roastNumber,
      totalTime: totalTime,
      preheatTime: timeline.preheatEnd,
      preheatGap: timeline.preheatGap,
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
