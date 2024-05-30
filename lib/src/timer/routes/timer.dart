import 'package:behmor_roast/src/chart/temp_chart.dart';
import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/instructions/providers.dart';
import 'package:behmor_roast/src/instructions/widgets/instructions_widget.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/models/temp_log.dart';
import 'package:behmor_roast/src/timer/services/buzz_beep_service.dart';
import 'package:behmor_roast/src/timer/widgets/buzz_beep_widget.dart';
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
import 'package:behmor_roast/src/util/widgets/animated_blur_out.dart';
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
    final copyLogs = ref.watch(roastLogsCopyProvider);
    final tips = ref.watch(tipsProvider);
    final copyingRoast = ref.watch(copyOfRoastProvider);

    ref.listen<Duration?>(showTempInputTimeProvider, (_, next) {
      if (next != null) {
        ref.read(buzzBeepServiceProvider).trigger(BuzzBeepKind.tempCheck);
      }
    });

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

    const roasterControlsHeight = 60.0;
    const timeWidgetHeight = 150.0;
    const timeWidgetOverlap = 45.0;

    final showRoasterControls = state == RoastState.roasting ||
        state == RoastState.ready ||
        state == RoastState.done;

    final bool showTempPopup;
    final Widget tempPopupWidget;
    if (state == RoastState.roasting && showTempInputTime != null) {
      showTempPopup = true;
      tempPopupWidget = Container(
        color: RoastAppTheme.capuccino.withOpacity(0.75),
        padding: const EdgeInsets.all(8.0).copyWith(bottom: 105),
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: RoastAppTheme.metalLight,
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
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
                  (state) => state.addLog(TempLog(temp: temp, time: time)));
              ref.read(showTempInputTimeProvider.notifier).state = null;
            },
          ),
        ),
      );
    } else {
      tempPopupWidget = const SizedBox();
      showTempPopup = false;
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
        child: Column(
          children: [
            const Spacer(),
            Text('Caution: roaster is hot!',
                style: RoastAppTheme.materialTheme.textTheme.headlineLarge),
            const Spacer(),
            const Text('Enter the final preheat temperature you recorded, and'
                ' then carefully load your beans into the hot roasting drum.'),
            const Spacer(),
            CheckTempWidget(
              title: Text('Enter final preheat temperature:',
                  style: RoastAppTheme.materialTheme.textTheme.titleSmall),
              onSubmit: (temp) {
                ref
                    .read(roastTimelineProvider.notifier)
                    .update((state) => state.copyWith(preheatTemp: temp));
              },
            ),
            const Spacer(flex: 3),
          ],
        ),
      );
    } else {
      body = SingleChildScrollView(
        child: Column(
          children: [
            if (showRoasterControls)
              const SizedBox(height: roasterControlsHeight),
            TempChart(
              logs: logs,
              copyLogs: copyLogs,
              isLive: true,
            ),
            TempLogWidget(
              logs: logs,
              isLive: true,
              isDiff: copyingRoast != null,
            ),
            const ProjectionsWidget(),
            const SizedBox(height: timeWidgetHeight - timeWidgetOverlap),
          ],
        ),
      );
    }

    return RoastPopScope(
      state: state,
      child: Scaffold(
        appBar: AppBar(
          title: const LogoTitle('Now Roasting'),
          actions: const [BuzzBeepWidget()],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AlertWidget(
              alerts: alerts,
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedBlurOut(
                      duration: const Duration(milliseconds: 250),
                      blur: showTempPopup ? 1.0 : 0.0,
                      child: body,
                    ),
                  ),
                  Positioned.fill(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 150),
                      child: tempPopupWidget,
                    ),
                  ),
                  if (showRoasterControls)
                    const Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: roasterControlsHeight,
                      child: ControlsWidget(),
                    ),
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: timeWidgetHeight,
                    child: TimeWidget(),
                  ),
                ],
              ),
            ),
            if (copyingRoast != null) const InstructionsWidget(),
            const PhaseControlWidget(),
          ],
        ),
        floatingActionButton: fab,
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!showTempPopup) RoastTipWidget(tips: tips),
            ],
          ),
        ),
      ),
    );
  }
}
