import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/development_widget.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimeWidget extends ConsumerWidget {
  const TimeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
	final time = ref.watch(secondsProvider).value;

    if (time == null) {
      return const Text('Not roasting.');
    }

    return Row(
	  children: [
        const SizedBox(width: 20),
        const DevelopmentWidget(),
        const Spacer(),
	    const Text('Roast time: '),
	    TimestampWidget.twitter(time),
	    const SizedBox(width: 20),
	  ],
	);
  }
}
