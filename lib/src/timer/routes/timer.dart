import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/roast/models/phase_log.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/models/temp_log.dart';
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

    Widget? fab;
    if (state == RoastState.preheatDone) {
      fab = ElevatedButton.icon(
        style: RoastAppTheme.largeButtonTheme.style,
        icon: const Icon(Icons.local_fire_department_sharp, size: 28.0),
        label: const Text('Start'),
        onPressed: () {
          final roast = ref.read(roastProvider);
          tService.start(roast!.config.tempInterval);
          ref.read(roastTimelineProvider.notifier).update((state) => state
              .addLog(PhaseLog(
                time: tService.elapsed()!,
                phase: Phase.start,
              ))
              .copyWith(startTime: tService.startTime));
        },
      );
    } else if (state == RoastState.done) {
      fab = ElevatedButton.icon(
        style: RoastAppTheme.largeButtonTheme.style,
        label: const Icon(Icons.navigate_next, size: 28.0),
        icon: const Text('Continue'),
        onPressed: () {
          final roast = ref.read(roastProvider);
          final timeline = ref.read(roastTimelineProvider);
          final tempLogs = timeline.rawLogs.whereType<TempLog>().toList();
          final controlLogs = timeline.rawLogs.whereType<ControlLog>().toList();
          final phaseLogs = timeline.rawLogs.whereType<PhaseLog>().toList();
          final toAdd = roast!.copyWith(
              roasted: tService.startTime!,
              tempLogs: tempLogs,
              controlLogs: controlLogs,
              phaseLogs: phaseLogs);
          ref.read(roastProvider.notifier).state = toAdd;
          context.replace(Routes.completeRoast);
        },
      );
    } else if (state == RoastState.preheating) {
      fab = ElevatedButton.icon(
        style: RoastAppTheme.largeButtonTheme.style,
        icon: const Icon(Icons.stop_circle, size: 28.0),
        label: const Text('Stop Preheat'),
        onPressed: () {
          final preheatService = ref.read(preheatTimerProvider);
          ref
              .read(roastTimelineProvider.notifier)
              .update((state) => state.addLog(PhaseLog(
                    time: preheatService.elapsed()!,
                    phase: Phase.preheatEnd,
                  )));
        },
      );
    }

    final Widget body;
    if (state == RoastState.waiting || state == RoastState.preheating) {
      body = const Padding(
        padding: EdgeInsets.all(16),
        child: PreheatWidget(),
      );
    } else {
      body = BottomStickyScrollView(
        children: [
          TempLogWidget(logs: logs),
          const ProjectionsWidget(),
        ],
      );
    }

    return RoastPopScope(
      state: state,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Roast Controls"),
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
                      child: CheckTempWidget(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              RoastTipWidget(tips: tips),
              const SizedBox(
                height: 50,
                child: Center(
                  child: TimeWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
