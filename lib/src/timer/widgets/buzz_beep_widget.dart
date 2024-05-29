import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/services/buzz_beep_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BuzzBeepWidget extends ConsumerWidget {
  const BuzzBeepWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buzzBeep = ref.read(buzzBeepServiceProvider);

    return StreamBuilder<BuzzBeepState>(
      stream: buzzBeep.stateStream,
      builder: (context, val) {
        final state = val.data ?? buzzBeep.state;
        final IconData icon;
        final BuzzBeepState switchTo;
        switch (state) {
          case BuzzBeepState.buzz:
            icon = Icons.vibration;
            switchTo = BuzzBeepState.silent;
            break;
          case BuzzBeepState.silent:
            icon = Icons.notifications_off;
            switchTo = BuzzBeepState.buzzBeep;
            break;
          case BuzzBeepState.buzzBeep:
            icon = Icons.notifications_active;
            switchTo = BuzzBeepState.buzz;
            break;
        }

        return IconButton(
          icon: Icon(icon),
          onPressed: () {
            buzzBeep.state = switchTo;
          },
        );
      },
    );
  }
}
