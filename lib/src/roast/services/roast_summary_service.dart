import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/models/roast_summary.dart';

class RoastSummaryService {

  RoastSummary summarize(Roast roast, Bean bean) {
	final dryPhaseLog = roast.phaseLogs.singleWhere((p) => p.phase == Phase.dryEnd);
	final firstCrackLog = roast.phaseLogs.firstWhere((p) => p.phase == Phase.crack);
	final lastCrackLog = roast.phaseLogs.lastWhere((p) => p.phase == Phase.crack);

	Duration totalTime = roast.phaseLogs.last.time;
	Duration dryPhaseTime = dryPhaseLog.time;
	Duration maillardPhaseTime = firstCrackLog.time - dryPhaseLog.time;
	// TODO: Should this do something different when first crack is last crack?
	Duration firstCrackPhaseTime = lastCrackLog.time - firstCrackLog.time;
	Duration developmentPhaseTime = totalTime - lastCrackLog.time;

	return RoastSummary(
	  beanName: bean.name,
	  totalTime: totalTime,
	  dryPhaseTime: dryPhaseTime,
	  dryPhasePercent: dryPhaseTime.inMilliseconds / totalTime.inMilliseconds,
	  maillardPhaseTime: maillardPhaseTime,
	  maillardPhasePercent: maillardPhaseTime.inMilliseconds / totalTime.inMilliseconds,
	  firstCrackPhaseTime: firstCrackPhaseTime,
	  firstCrackPhasePercent: firstCrackPhaseTime.inMilliseconds / totalTime.inMilliseconds,
	  developmentPhaseTime: developmentPhaseTime,
	  developmentPercent: developmentPhaseTime.inMilliseconds / totalTime.inMilliseconds,
	  developmentPercentTarget: roast.config.targetDevelopment,
	  weightLoss: 1.0 - roast.weightOut / roast.weightIn,
	  notes: roast.notes,
	);
  }
}
