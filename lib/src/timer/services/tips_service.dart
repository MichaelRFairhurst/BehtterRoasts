import 'package:behmor_roast/src/roast/models/roast_log.dart';

class TipsService {
  Set<String> getTips(List<RoastLog> logs, bool running) {
	final results = <String>{};
	if (!running && logs.isEmpty) {
	  results.add('Preheat the roaster to 180-220 for a faster, hotter roast.');
	  results.add('Use the 1lb setting on all batch sizes to maximize available'
	      ' time.');
	  return results;
	}
	if (!logs.any((log) => log.control != null)) {
	  results.add('Press P1-P5 to enter manual roast mode.');
	}
	if (!logs.any((log) => log.phase != null)) {
	  results.add('The dry phase is over when the beans are yellow and have a'
		  ' bread-like (rather than hay-like) aroma.');
	}
	if (running && logs.any((log) => log.phase == RoastPhase.firstCrackStart)
	  && !logs.any((log) => log.phase == RoastPhase.firstCrackEnd)) {
	  results.add("Keep pressing 'Log Crack' while you hear pops, in order to"
		  ' track the end of the First Crack phase.');
	}
	if (logs.any((log) => log.phase == RoastPhase.done)) {
	  results.add('Remove the drum from the roaster to cool the beans more'
		  ' quickly.');
	}

	return results;
  }
}
