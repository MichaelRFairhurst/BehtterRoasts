import 'package:behmor_roast/src/behmor/widgets/program_button.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/services/timer_service.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreheatWidget extends ConsumerStatefulWidget {
  const PreheatWidget({super.key});

  @override
  PreheatWidgetState createState() => PreheatWidgetState();
}

class PreheatWidgetState extends ConsumerState<PreheatWidget> {
  TextEditingController tempCtrl = TextEditingController(
    text: '180',
  );

  var duration = const Duration(seconds: 100);

  @override
  Widget build(BuildContext context) {
    final state =
        ref.watch(timerStateProvider).value ?? RoastTimerState.waiting;

    if (state == RoastTimerState.preheating) {
      return Column(
        children: [
          Text(
            'Preheating...',
            style: RoastAppTheme.materialTheme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Press ',
                  style: RoastAppTheme.materialTheme.textTheme.bodySmall,
                ),
                const WidgetSpan(
                  child: ProgramButton('B'),
                ),
                TextSpan(
                  text: ' to monitor the current temp of your roaster.',
                  style: RoastAppTheme.materialTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(timerServiceProvider).stopPreheat();
            },
            child: const Text('Stop'),
          ),
        ],
      );
    }

    return Column(
      children: [
        Text(
          'Preheat this roast?',
          style: RoastAppTheme.materialTheme.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        const Text(
          'Simply run your roaster for a minute or two before loading your'
          " beans, and you'll have a faster / hotter roast profile.",
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Preheat temp: '),
            SizedBox(
              width: 100,
              child: TextField(
                controller: TextEditingController(
                  text: '180',
                ),
                decoration: const InputDecoration(
                  suffixText: 'F',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Expanded(
              child: Text('Estimated time:'),
            ),
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  duration -= const Duration(seconds: 5);
                });
              },
            ),
            TimestampWidget.twitter(duration),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  duration += const Duration(seconds: 5);
                });
              },
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              style: RoastAppTheme.largeButtonTheme.style,
              label: const Text('Start Preheat'),
              icon: const Icon(Icons.local_fire_department),
              onPressed: () {
                ref.read(timerServiceProvider).startPreheat();
              },
            ),
            const Text('or'),
            ElevatedButton(
              style: RoastAppTheme.limeButtonTheme.style,
              child: const Text('Skip'),
              onPressed: () {
                ref.read(timerServiceProvider).stopPreheat();
              },
            ),
          ],
        ),
      ],
    );
  }
}
