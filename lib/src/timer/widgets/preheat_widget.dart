import 'package:behmor_roast/src/behmor/widgets/program_button.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/preheat_timer.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
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

  final formKey = GlobalKey<FormState>();
  var duration = const Duration(seconds: 100);

  @override
  void initState() {
    super.initState();
    final copy = ref.read(copyOfRoastProvider);
    final copyPreheat = copy?.preheat;

    if (copyPreheat != null) {
      tempCtrl.text = copyPreheat.temp.toString();
      duration = roundToFiveSeconds(copyPreheat.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(roastStateProvider);
    final copy = ref.watch(copyOfRoastProvider);
    final suggestPreheat = copy == null || copy.preheat != null;

    if (state == RoastState.preheating) {
      final time = ref.watch(secondsPreheatProvider).value ?? Duration.zero;
      final timeFloored = Duration(seconds: time.inSeconds);

      ref.listen<AsyncValue<Duration?>>(secondsPreheatProvider, (last, next) {
        final now = next.value;
        final earlier = last?.value;
        if (now == null || earlier == null) {
          return;
        }
        final earlyWarning = duration - const Duration(seconds: 10);
        if (now >= earlyWarning && earlier < earlyWarning) {
          FlutterBeep.beep();
        } else if (now >= duration && earlier < duration) {
          FlutterBeep.beep(false);
        }
      });

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Preheating...',
            textAlign: TextAlign.center,
            style: RoastAppTheme.materialTheme.textTheme.headlineLarge,
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: PreheatTimer(
              duration: duration,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Target temp: ${tempCtrl.text}°F',
            textAlign: TextAlign.center,
            style: RoastAppTheme.materialTheme.textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Elapsed: ',
                textAlign: TextAlign.center,
                style: RoastAppTheme.materialTheme.textTheme.titleMedium,
              ),
              TimestampWidget.twitter(timeFloored,
                  style: RoastAppTheme.materialTheme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 30),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Press ',
                  style: RoastAppTheme.materialTheme.textTheme.bodyMedium!
                      .copyWith(fontStyle: FontStyle.italic),
                ),
                const WidgetSpan(
                  child: ProgramButton('B'),
                ),
                TextSpan(
                  text: ' to monitor the temp of your roaster. When your'
                      ' roaster reaches your target temperature of '
                      '${tempCtrl.text}°F, press "Stop Preheat."',
                  style: RoastAppTheme.materialTheme.textTheme.bodyMedium!
                      .copyWith(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          if (copy == null) ...[
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
          ] else if (suggestPreheat) ...[
            Text(
              'Preheat your roaster!',
              style: RoastAppTheme.materialTheme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            const Text(
              'Preheat your roaster now to replicate your last roast.',
              textAlign: TextAlign.center,
            ),
          ],
          if (!suggestPreheat) ...[
            Text(
              'Preheat this roast?',
              style: RoastAppTheme.materialTheme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            const Text(
              'Note that you did NOT preheat this roast last time.',
              textAlign: TextAlign.center,
            ),
          ],
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Preheat temp: '),
              SizedBox(
                width: 100,
                child: TextFormField(
                    controller: tempCtrl,
                    decoration: const InputDecoration(
                      suffixText: '°F',
                    ),
                    validator: (str) {
                      if (str == null || int.tryParse(str) == null) {
                        return 'Enter a valid temperature';
                      }
                    }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(
                child: Text('Estimated time:'),
              ),
              if (duration > const Duration(seconds: 5))
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
                style: suggestPreheat
                    ? RoastAppTheme.largeButtonTheme.style
                    : RoastAppTheme.limeButtonTheme.style,
                label: const Text('Start Preheat'),
                icon: const Icon(Icons.local_fire_department),
                onPressed: () {
                  final state = formKey.currentState!;
                  if (state.validate()) {
                    ref
                        .read(roastProvider.notifier)
                        .update((roast) => roast!.copyWith(
                              config: roast.config.copyWith(
                                preheatTarget: int.parse(tempCtrl.text),
                                preheatTimeEst: duration,
                              ),
                            ));
                    ref.read(roastTimelineProvider.notifier).update((state) =>
                        state.copyWith(preheatStart: DateTime.now()));
                    ref.read(preheatTimerProvider).start(null);
                  }
                },
              ),
              const Text('or'),
              ElevatedButton(
                style: suggestPreheat
                    ? RoastAppTheme.limeButtonTheme.style
                    : RoastAppTheme.largeButtonTheme.style,
                child: suggestPreheat
                    ? const Text('Skip')
                    : const Text('Start Roasting'),
                onPressed: () {
                  ref
                      .read(roastTimelineProvider.notifier)
                      .update((state) => state.copyWith(
                            preheatTemp: -1,
                          ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Duration roundToFiveSeconds(Duration duration) {
    return Duration(seconds: (duration.inSeconds / 5).round() * 5);
  }
}
