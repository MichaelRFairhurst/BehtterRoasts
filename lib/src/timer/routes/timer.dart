import 'package:behmor_roast/src/timer/models/temp_log.dart';
import 'package:behmor_roast/src/timer/widgets/check_temp_widget.dart';
import 'package:behmor_roast/src/timer/widgets/controls_widget.dart';
import 'package:behmor_roast/src/timer/widgets/projections_widget.dart';
import 'package:behmor_roast/src/timer/widgets/temp_log_widget.dart';
import 'package:behmor_roast/src/timer/widgets/time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/timer/providers.dart';

class TimerPage extends ConsumerWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tService = ref.watch(timerServiceProvider);
    final showTempInput = ref.watch(showTempInputProvider);
    final logs = ref.watch(roastLogsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Roast Controls"),
      ),
      body: Column(
        children: [
          const ControlsWidget(),
          Expanded(
            child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              const SliverToBoxAdapter(
	            child: TempLogWidget(),
              ),
	          const SliverToBoxAdapter(
	            child: ProjectionsWidget(),
	          ),
              if (showTempInput)
                SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: CheckTempWidget(
                      label: logs.isEmpty ? 'Enter starting temperature:' : 'Enter current temperature',
                      onSubmit: (val) {
                        ref.read(temperatureLogsProvider.notifier)
                          .update((logs) => logs.toList()..add(TempLog(
                             temp: val, time: tService.elapsed()!)
                        ));
                        ref.read(showTempInputProvider.notifier).state = false;
                      },
                    ),
                  ),
                ),
            ],
          ),
          ),
        ],
      ),
      floatingActionButton: StreamBuilder(
        stream: tService.running,
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return Container();
          }

          return FloatingActionButton(
            child: const Icon(Icons.play_circle),
            onPressed: () {
              tService.start();
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: TimeWidget(timerService: tService),
        ),
      ),
    );
  }
}
