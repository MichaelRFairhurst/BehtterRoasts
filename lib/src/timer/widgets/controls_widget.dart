import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/timer/widgets/control_button.dart';
import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  const ControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        ControlButton(control: Control.p1),
        ControlButton(control: Control.p2),
        ControlButton(control: Control.p3),
        ControlButton(control: Control.p4),
        ControlButton(control: Control.p5),
        ControlButton(control: Control.d),
      ],
    );
  }
}
