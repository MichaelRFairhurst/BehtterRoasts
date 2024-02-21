import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/models/temp_log.dart';
import 'package:behmor_roast/src/roast/widgets/temp_log_widget.dart';
import 'package:behmor_roast/src/timer/widgets/check_temp_widget.dart';
import 'package:behmor_roast/src/timer/widgets/controls_widget.dart';
import 'package:behmor_roast/src/timer/widgets/projections_widget.dart';
import 'package:behmor_roast/src/timer/widgets/time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/timer/providers.dart';

class TimerPage extends ConsumerWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tService = ref.watch(timerServiceProvider);
    final running = ref.watch(timerRunningProvider).value ?? false;
    final showTempInputTime = ref.watch(showTempInputTimeProvider);
    final logs = ref.watch(roastLogsProvider);

    Widget? fab;
	if (!running && tService.elapsed() == null) {
      fab = FloatingActionButton(
        child: const Icon(Icons.play_circle),
        onPressed: () {
          tService.start();
        },
      );
	} else if (!running) {
      fab = ElevatedButton.icon(
        icon: const Icon(Icons.save),
        label: const Text('Save'),
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
          ref.read(roastServiceProvider).add(toAdd);
        },
      );
	}

    return Scaffold(
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
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
	              child: TempLogWidget(
				    logs: logs,
				  ),
                ),
	            const SliverToBoxAdapter(
	              child: ProjectionsWidget(),
	            ),
              ],
            ),
          ),
          if (showTempInputTime != null)
            Container(
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
        ],
      ),
      floatingActionButton: fab,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: const TimeWidget(),
        ),
      ),
    );
  }
}
