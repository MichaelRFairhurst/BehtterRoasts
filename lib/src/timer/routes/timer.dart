import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/models/temp_log.dart';
import 'package:behmor_roast/src/roast/widgets/temp_log_widget.dart';
import 'package:behmor_roast/src/timer/widgets/check_temp_widget.dart';
import 'package:behmor_roast/src/timer/widgets/controls_widget.dart';
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
    final tService = ref.watch(timerServiceProvider);
    final running = ref.watch(timerRunningProvider).value ?? false;
    final showTempInputTime = ref.watch(showTempInputTimeProvider);
    final logs = ref.watch(roastLogsProvider);
    final tips = ref.watch(tipsProvider);

    Widget? fab;
	if (!running && tService.elapsed() == null) {
      fab = ElevatedButton.icon(
	    style: RoastAppTheme.largeButtonTheme.style,
        icon: const Icon(Icons.local_fire_department_sharp, size: 28.0),
        label: const Text('Start'),
        onPressed: () {
		  final roast = ref.read(roastProvider);
          tService.start(roast!.config.tempInterval);
        },
      );
	} else if (!running) {
      fab = ElevatedButton.icon(
	    style: RoastAppTheme.largeButtonTheme.style,
        label: const Icon(Icons.navigate_next, size: 28.0),
        icon: const Text('Continue'),
        onPressed: () {
		  final roast = ref.read(roastProvider);
		  final tempLogs = ref.read(temperatureLogsProvider);
		  final controlLogs = ref.read(controlLogsProvider);
		  final phaseLogs = ref.read(phaseLogsProvider);
		  final toAdd = roast!.copyWith(
		    roasted: tService.startTime!,
		    tempLogs: tempLogs,
			controlLogs: controlLogs,
			phaseLogs: phaseLogs
		  );
		  ref.read(roastProvider.notifier).state = toAdd;
		  context.replace(Routes.completeRoast);
        },
      );
	}

    return RoastPopScope(
	  running: running,
	  child: Scaffold(
		appBar: AppBar(
		  title: const Text("Roast Controls"),
		),
		body: Column(
		  crossAxisAlignment: CrossAxisAlignment.stretch,
		  children: [
			Container(
			  decoration: const BoxDecoration(
				color: RoastAppTheme.metalLight,
				//border: Border(bottom: BorderSide(color: RoastAppTheme.capuccino, width: 1.0)),
				boxShadow: [BoxShadow(
				  color: RoastAppTheme.capuccino,
				  offset: Offset(0, 0),
				  blurRadius: 2.0,
				)],
			  ),
			  padding: const EdgeInsets.only(bottom: 4.0),
			  margin: const EdgeInsets.only(bottom: 4.0),
			  child: const ControlsWidget(),
			),
			Expanded(
			  child: BottomStickyScrollView(
			    children: [
				  TempLogWidget(logs: logs),
				  const ProjectionsWidget(),
				],
			  ),
			),
			AnimatedPopUp(
			  child: !running || showTempInputTime == null ? null : Container(
				alignment: Alignment.center,
				padding: const EdgeInsets.all(16.0),
				decoration: const BoxDecoration(
				  color: RoastAppTheme.metalLight,
				  boxShadow: [BoxShadow(
					color: RoastAppTheme.capuccino,
					offset: Offset(0, 0),
					blurRadius: 2.0,
				  )],
				),
				child: CheckTempWidget(
				  shownTime: showTempInputTime,
				  onSubmit: (time, temp) {
					ref.read(temperatureLogsProvider.notifier)
					  .update((logs) => logs.toList()..add(TempLog(
						 temp: temp, time: time)
					));
					ref.read(showTempInputTimeProvider.notifier).state = null;
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
