import 'package:behmor_roast/src/behmor/widgets/program_button.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:behmor_roast/src/util/widgets/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckTempWidget extends ConsumerStatefulWidget {
  const CheckTempWidget({
    required this.shownTime,
    required this.onSubmit,
    super.key,
  });

  final Duration shownTime;
  final void Function(Duration, int) onSubmit;

  @override
  CheckTempWidgetState createState() => CheckTempWidgetState();
}

class CheckTempWidgetState extends ConsumerState<CheckTempWidget> {
  int state = 0;
  bool useShownTime = true;
  Duration? overrideTime;

  @override
  Widget build(BuildContext context) {
    const baseDigits = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ];
    final seconds = overrideTime ?? ref.watch(secondsRoastProvider).value!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const SizedBox(width: 4.0),
            //const Expanded(
            //  child: Text('Enter Temperature'),
            //),
            Text('Check temperature with ',
                style: RoastAppTheme.checkTempTextStyle),
            const SizedBox(
              height: 32,
              child: ProgramButton('B'),
            ),
            const Spacer(),
            Text('Time: ', style: RoastAppTheme.checkTempTextStyle),
            ToggleSwitch<Duration>(
              widgetLeft: TimestampWidget(widget.shownTime),
              valueLeft: widget.shownTime,
              widgetRight: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TimestampWidget(seconds),
                  if (overrideTime != null)
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: ElevatedButton(
                        style: RoastAppTheme.tinyButtonTheme.style,
                        onPressed: () {
                          setState(() {
                            if (useShownTime) {
                              overrideTime = null;
                            } else {
                              overrideTime =
                                  ref.read(timerServiceProvider).elapsed()!;
                            }
                          });
                        },
                        child: const Icon(Icons.refresh, size: 12),
                      ),
                    ),
                ],
              ),
              valueRight: seconds,
              onToggle: (value) {
                setState(() {
                  useShownTime = value == widget.shownTime;
                  if (!useShownTime) {
                    overrideTime = value;
                  }
                });
              },
            ),
            const SizedBox(width: 4.0),
          ],
        ),
        const SizedBox(height: 6.0),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(state.toString()),
        ),
        const SizedBox(height: 4.0),
        for (final row in baseDigits) buildDigitRow(row),
        buildRow([
          buildButton(
            label: "Delete",
            onPressed: () {
              setState(() {
                state = (state / 10).floor();
              });
            },
          ),
          buildDigit(0),
          buildButton(
            label: "Done",
            onPressed: () {
              final time = useShownTime ? widget.shownTime : overrideTime!;
              widget.onSubmit(time, state);
            },
          ),
        ]),
      ],
    );
  }

  Widget buildRow(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children
          .map(
            (child) => Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: child,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget buildDigitRow(List<int> digits) {
    return buildRow([
      for (final digit in digits) buildDigit(digit),
    ]);
  }

  Widget buildDigit(int digit) {
    return buildButton(
      label: digit.toString(),
      onPressed: () {
        setState(() {
          overrideTime ??= ref.read(timerServiceProvider).elapsed()!;
          state = state * 10 + digit;
        });
      },
    );
  }

  Widget buildButton(
      {required String label, required void Function() onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: RoastAppTheme.keypadButtonTheme.style,
      child: Text(label),
    );
  }
}
