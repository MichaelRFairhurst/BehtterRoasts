import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/instructions/widgets/instructions_widget.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/models/temp_log.dart';
import 'package:behmor_roast/src/timer/widgets/phase_control_widget.dart';
import 'package:behmor_roast/src/roast/widgets/temp_log_widget.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/widgets/alert_widget.dart';
import 'package:behmor_roast/src/timer/widgets/check_temp_widget.dart';
import 'package:behmor_roast/src/timer/widgets/controls_widget.dart';
import 'package:behmor_roast/src/timer/widgets/preheat_widget.dart';
import 'package:behmor_roast/src/timer/widgets/projections_widget.dart';
import 'package:behmor_roast/src/timer/widgets/roast_pop_scope.dart';
import 'package:behmor_roast/src/timer/widgets/roast_tip_widget.dart';
import 'package:behmor_roast/src/timer/widgets/time_widget.dart';
import 'package:behmor_roast/src/timer/widgets/timed_check_temp_widget.dart';
import 'package:behmor_roast/src/util/logo_title.dart';
import 'package:behmor_roast/src/util/widgets/animated_pop_up.dart';
import 'package:behmor_roast/src/util/widgets/bottom_sticky_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:go_router/go_router.dart';

class TimerPage extends ConsumerWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tService = ref.watch(roastTimerProvider);
    final state = ref.watch(roastStateProvider);
    final showTempInputTime = ref.watch(showTempInputTimeProvider);
    final alerts = ref.watch(alertsProvider);
    final logs = ref.watch(roastLogsProvider);
    final tips = ref.watch(tipsProvider);
    final copyingRoast = ref.watch(copyOfRoastProvider);

    Widget? fab;
    if (state == RoastState.ready) {
      fab = ElevatedButton.icon(
        style: RoastAppTheme.largeButtonTheme.style,
        icon: const Icon(Icons.local_fire_department_sharp, size: 28.0),
        label: const Text('Start'),
        onPressed: () {
          final roast = ref.read(roastProvider);
          tService.start(roast!.config.tempInterval);
          ref
              .read(roastTimelineProvider.notifier)
              .update((state) => state.copyWith(startTime: tService.startTime));
        },
      );
    } else if (state == RoastState.done) {
      fab = ElevatedButton.icon(
        style: RoastAppTheme.largeButtonTheme.style,
        label: const Icon(Icons.navigate_next, size: 28.0),
        icon: const Text('Continue'),
        onPressed: () {
          final timeline = ref.read(roastTimelineProvider);
          ref
              .read(roastProvider.notifier)
              .update((state) => state!.withTimeline(timeline));
          context.replace(Routes.completeRoast);
        },
      );
    }

    final Widget body;
    if (state == RoastState.waiting || state == RoastState.preheating) {
      body = const Padding(
        padding: EdgeInsets.all(16),
        child: PreheatWidget(),
      );
    } else if (state == RoastState.preheatDone) {
      body = Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text('Caution: roaster is hot!',
              style: RoastAppTheme.materialTheme.textTheme.titleMedium),
          const SizedBox(height: 16),
          const Text('Enter the final preheat temperature you recorded, and'
              ' then carefully load your beans into the hot roasting drum.'),
          const SizedBox(height: 16),
          CheckTempWidget(
            title: const Text('Enter final preheat temperature'),
            onSubmit: (temp) {
              ref
                  .read(roastTimelineProvider.notifier)
                  .update((state) => state.copyWith(preheatTemp: temp));
            },
          ),
        ]),
      );
    } else {
      body = BottomStickyScrollView(
        children: [
          TempLogWidget(
              logs: logs, editable: true, isDiff: copyingRoast != null),
          const ProjectionsWidget(),
        ],
      );
    }

    return RoastPopScope(
      state: state,
      child: Scaffold(
        appBar: AppBar(
          title: const LogoTitle("Roast Controls"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AlertWidget(
              alerts: alerts,
            ),
            Container(
              decoration: const BoxDecoration(
                color: RoastAppTheme.metalLight,
                //border: Border(bottom: BorderSide(color: RoastAppTheme.capuccino, width: 1.0)),
                boxShadow: [
                  BoxShadow(
                    color: RoastAppTheme.capuccino,
                    offset: Offset(0, 0),
                    blurRadius: 2.0,
                  )
                ],
              ),
              padding: const EdgeInsets.only(bottom: 4.0),
              margin: const EdgeInsets.only(bottom: 4.0),
              child: const ControlsWidget(),
            ),
            Expanded(child: body),
            const TimeWidget(),
            if (copyingRoast != null) const InstructionsWidget(),
            const PhaseControlWidget(),
            RoastTipWidget(tips: tips),
            AnimatedPopUp(
              child: state != RoastState.roasting || showTempInputTime == null
                  ? null
                  : Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                        color: RoastAppTheme.metalLight,
                        boxShadow: [
                          BoxShadow(
                            color: RoastAppTheme.capuccino,
                            offset: Offset(0, 0),
                            blurRadius: 2.0,
                          )
                        ],
                      ),
                      child: TimedCheckTempWidget(
                        shownTime: showTempInputTime,
                        onSubmit: (time, temp) {
                          ref.read(roastTimelineProvider.notifier).update(
                              (state) => state
                                  .addLog(TempLog(temp: temp, time: time)));
                          ref.read(showTempInputTimeProvider.notifier).state =
                              null;
                        },
                      ),
                    ),
            ),
          ],
        ),
        floatingActionButton: fab,
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
        ),
      ),
    );
  }
}
