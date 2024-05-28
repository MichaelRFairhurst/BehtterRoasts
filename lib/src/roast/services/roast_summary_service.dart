import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/models/roast_summary.dart';

class RoastSummaryService {
  RoastSummary summarize(Roast roast, Bean bean) {
    final timeline = roast.toTimeline();
    final totalTime = timeline.done!;
    final dryPhaseTime = timeline.dryEnd ?? totalTime;
	Duration? maillardPhaseTime;
	double? maillardPhasePercent;
	if (timeline.dryEnd != null) {
	  maillardPhaseTime = (timeline.firstCrackStart ?? totalTime) - dryPhaseTime;
      maillardPhasePercent = maillardPhaseTime.inMilliseconds / totalTime.inMilliseconds;
	}

    Duration? firstCrackPhaseTime;
	double? firstCrackPhasePercent;
	Duration? developmentPhaseTime;
	double? developmentPercent;
    if (timeline.firstCrackStart != null && timeline.firstCrackEnd != null) {
	  firstCrackPhaseTime =
		  timeline.firstCrackEnd! - timeline.firstCrackStart!;
          firstCrackPhasePercent = firstCrackPhaseTime.inMilliseconds / totalTime.inMilliseconds;
	  developmentPhaseTime = totalTime - timeline.firstCrackEnd!;
	  // Caution: Due to weird coffee terminology, development percent is NOT
	  // the percentage of the time in the development phase. It is time since
	  // first crack start.
	  developmentPercent = (totalTime - timeline.firstCrackStart!).inMilliseconds / totalTime.inMilliseconds;
	}

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
      maillardPhasePercent: maillardPhasePercent,
      firstCrackPhaseTime: firstCrackPhaseTime,
      firstCrackPhasePercent: firstCrackPhasePercent,
      secondCrackPhaseTime: secondCrackPhaseTime,
      secondCrackPhasePercent: secondCrackPhasePercent,
      developmentPhaseTime: developmentPhaseTime,
      developmentPercent: developmentPercent ?? 0.0,
      developmentPercentTarget: roast.config.targetDevelopment,
      weightIn: roast.weightIn,
      weightOut: roast.weightOut,
      weightLoss: 1.0 - roast.weightOut / roast.weightIn,
      notes: roast.notes,
    );
  }
}
