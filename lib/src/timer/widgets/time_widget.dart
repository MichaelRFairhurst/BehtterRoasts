import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/services/timer_service.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeWidget extends ConsumerStatefulWidget {
  final TimerService timerService;
  const TimeWidget({required this.timerService, Key? key}) : super(key: key);

  @override
  TimeWidgetState createState() {
    return TimeWidgetState();
  }

}

class TimeWidgetState extends ConsumerState<TimeWidget> with SingleTickerProviderStateMixin {

  Duration? time;

  @override
  void initState() {
    super.initState();

    createTicker((_) {
      setState(() {
        time = widget.timerService.elapsed();
      });
    }).start();
  }

  @override
  Widget build(BuildContext context) {
    if (time == null) {
      return const Text('Not roasting.');
    }

    return Row(
	  //mainAxisAlignment: MainAxisAlignment.end,
	  children: [
        const SizedBox(width: 20),
        ...developmentTimeParts(),
        const Spacer(),
	    const Text('Roast time: '),
	    TimestampWidget.twitter(time!),
	    const SizedBox(width: 20),
	  ],
	);
  }

  List<Widget> developmentTimeParts() {
    final phases = ref.watch(phaseLogsProvider);
    final roast = ref.watch(roastProvider);
    final firstCracks = phases.where((phase) => phase.phase == Phase.crack);
    if (firstCracks.isEmpty) {
      return [const Text('Waiting for first crack.')];
    }

    final firstCrackEnd = firstCracks.last.time;
    final now = widget.timerService.elapsed()!;
    final development = (now - firstCrackEnd).inMilliseconds / now.inMilliseconds;

    final develFmt = (development * 100).toStringAsFixed(1);
    final targetFmt = (roast!.config.targetDevelopment * 100).toStringAsFixed(1);

    return [
      Text('$develFmt/$targetFmt% development'),
    ];
  }
}
