import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlsWidget extends ConsumerWidget {
  const ControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ProviderListenable timerService;
    void Function() handle(Control control) {
      return () {
        final tService = ref.read(timerServiceProvider);
        final now = tService.elapsed() ?? const Duration(seconds: 0);
        final newLog = ControlLog(
          time: now,
          control: control
        );

        ref.read(controlLogsProvider.notifier).update((ls) => ls.toList()..add(newLog));
      };
    }

    return Column(
      children: [
        Wrap(
          children: [
            button('P1', handle(Control.p1)),
            button('P2', handle(Control.p2)),
            button('P3', handle(Control.p3)),
            button('P4', handle(Control.p4)),
            button('P5', handle(Control.p5)),
            button('D', handle(Control.d)),
          ],
        ),
        ElevatedButton.icon(
         icon: Icon(Icons.wb_sunny),
         //icon: Icon(Icons.flare),
         //icon: Icon(Icons.upcoming),
         //icon: Icon(Icons.stream),
         //icon: Icon(Icons.new_releases),
         label: const Text('Log Crack'),
         onPressed: () {},
        ),
      ],
    );
  }

  Widget button(String text, void Function() onpressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        minimumSize: const Size(30, 30),
      ),
      onPressed: onpressed,
      child: Text(text),
    );
  }
}
