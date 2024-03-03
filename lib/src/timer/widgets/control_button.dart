import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/timer/models/roast_timeline.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlButton extends ConsumerWidget {
  final Control control;

  const ControlButton({
    required this.control,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controls = ref.watch(controlLogsProvider);
    final running = ref.watch(roastStateProvider) == RoastState.roasting;

    final pwrLevel = controls
        .cast<ControlLog?>()
        .lastWhere((c) => c?.control != Control.d, orElse: () => null)
        ?.control;

    final disabled = !running || pwrLevel == control;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        minimumSize: const Size(30, 30),
      ),
      onPressed: disabled
          ? null
          : () {
              final tService = ref.read(roastTimerProvider);
              final now = tService.elapsed() ?? const Duration(seconds: 0);
              final newLog = ControlLog(
                time: now,
                control: control,
              );

              ref
                  .read(controlLogsProvider.notifier)
                  .update((ls) => ls.toList()..add(newLog));
            },
      child: Text(control.toString().replaceAll('Control.', '').toUpperCase()),
    );
  }
}
