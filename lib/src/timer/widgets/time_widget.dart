import 'package:behmor_roast/src/timer/services/timer_service.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';

class TimeWidget extends StatefulWidget {
  final TimerService timerService;
  const TimeWidget({required this.timerService, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TimeWidgetState();
  }

}

class TimeWidgetState extends State<TimeWidget> with SingleTickerProviderStateMixin {

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
	  mainAxisAlignment: MainAxisAlignment.end,
	  children: [
	    const Text('Roast time: '),
	    TimestampWidget.twitter(time!),
	    const SizedBox(width: 20),
	  ],
	);
  }
}
