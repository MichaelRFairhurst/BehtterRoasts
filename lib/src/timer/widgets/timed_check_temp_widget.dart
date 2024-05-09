import 'package:behmor_roast/src/behmor/widgets/program_button.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/check_temp_widget.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:behmor_roast/src/util/widgets/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimedCheckTempWidget extends ConsumerStatefulWidget {
  const TimedCheckTempWidget({
    required this.shownTime,
    required this.onSubmit,
    super.key,
  });

  final Duration shownTime;
  final void Function(Duration, int) onSubmit;

  @override
  TimedCheckTempWidgetState createState() => TimedCheckTempWidgetState();
}

class TimedCheckTempWidgetState extends ConsumerState<TimedCheckTempWidget> {
  bool useShownTime = true;
  Duration? overrideTime;

  @override
  Widget build(BuildContext context) {
    final seconds = overrideTime ?? ref.watch(secondsRoastProvider).value!;

    return CheckTempWidget(
      onSubmit: (temp) {
        final time = useShownTime ? widget.shownTime : overrideTime!;
        widget.onSubmit(time, temp);
      },
      onChanged: () {
        overrideTime ??= ref.read(roastTimerProvider).elapsed()!;
      },
      title: Row(
        children: [
          const SizedBox(width: 4.0),
          Text('Check temperature with ',
              style: RoastAppTheme.checkTempTextStyle),
          const SizedBox(
            height: 32,
            child: ProgramButton('B'),
          ),
          const Spacer(),
          Text('Time: ', style: RoastAppTheme.checkTempTextStyle),
          ToggleSwitch<Duration>(
            onToggle: (value) {
              setState(() {
                useShownTime = value == widget.shownTime;
                if (!useShownTime) {
                  overrideTime = value;
                }
              });
            },
            children: [
              ToggleSwitchOption<Duration>(
                child: TimestampWidget(widget.shownTime),
                value: widget.shownTime,
              ),
              ToggleSwitchOption<Duration>(
                child: Row(
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
                                    ref.read(roastTimerProvider).elapsed()!;
                              }
                            });
                          },
                          child: const Icon(Icons.refresh, size: 12),
                        ),
                      ),
                  ],
                ),
                value: seconds,
              ),
            ],
          ),
          const SizedBox(width: 4.0),
        ],
      ),
    );
  }
}
