import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/shapes/widgets/overflowing_circles.dart';

import 'package:behmor_roast/src/roast/models/control_log.dart';
import 'package:behmor_roast/src/timer/widgets/control_button.dart';
import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  const ControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const buttonSize = 36.0;
    const spacing = -2.0;
    const paddingTop = 6.0;
    const margin = 4.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned.fill(
                child: OverflowingCircles(
              childSize: buttonSize,
              overflowSize: buttonSize + margin * 2,
              centers: [
                ...OverflowingCircles.centeredZigZag(
                  count: 5,
                  childSize: buttonSize + margin,
                  spacing: spacing,
                  containerSize: constraints
                      .deflate(
                        const EdgeInsets.only(top: paddingTop, bottom: margin),
                      )
                      .biggest,
                ).map((offset) => offset + const Offset(0, paddingTop)),
                Offset(constraints.maxWidth - 30, constraints.maxHeight / 2),
              ],
              children: const [
                ControlButton(control: Control.p1),
                ControlButton(control: Control.p2),
                ControlButton(control: Control.p3),
                ControlButton(control: Control.p4),
                ControlButton(control: Control.p5),
                ControlButton(control: Control.d),
              ],
            )),
            Positioned(
              left: 16,
              bottom: 14,
              child: Text(
                'Roaster\nControls:',
                style: RoastAppTheme.materialTheme.textTheme.labelSmall!
                    .copyWith(color: RoastAppTheme.crema),
              ),
            ),
          ],
        );
      },
    );
  }
}
