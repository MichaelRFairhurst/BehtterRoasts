import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';

class TipsService {
  Set<String> getTips(RoastTimeline timeline, List<RoastLog> logs) {
    final results = <String>{};
    if (timeline.roastState == RoastState.ready) {
      results.add('Use the 1lb setting on all batch sizes to maximize available'
          ' time.');
      return results;
    }

    final roasting = timeline.roastState == RoastState.roasting;

    if (roasting && !logs.any((log) => log.control != null)) {
      results.add('Press P1-P5 to enter manual roast mode.');
    }

    if (roasting && timeline.dryEnd == null) {
      results.add('The dry phase is over when the beans are yellow and have a'
          ' bread-like (rather than hay-like) aroma.');
    }

    if (roasting &&
        timeline.firstCrackStart == timeline.firstCrackEnd &&
        timeline.firstCrackStart != null &&
        timeline.secondCrackStart == null) {
      results.add("Keep pressing 'Log Crack' while you hear pops, in order to"
          ' track the end of the First Crack phase.');
    }

    if (timeline.roastState == RoastState.done) {
      results.add('Remove the drum from the roaster to cool the beans more'
          ' quickly.');
    }

    return results;
  }
}
