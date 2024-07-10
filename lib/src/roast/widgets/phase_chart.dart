import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/roast_summary.dart';

class PhaseChart extends StatelessWidget {
  const PhaseChart({
    required this.summary,
    super.key,
  });

  final RoastSummary summary;

  @override
  Widget build(BuildContext context) {
    final data = [
      {
        'phase': 'dry phase',
        'duration': summary.dryPhaseTime,
      },
      {
        'phase': 'maillaird phase',
        'duration': summary.maillardPhaseTime,
      },
      {
        'phase': 'first crack phase',
        'duration': summary.firstCrackPhaseTime,
      },
      {
        'phase': 'development phase',
        'duration': summary.developmentPhaseTime,
      },
      {
        'phase': 'second crack phase',
        'duration': summary.secondCrackPhaseTime,
      },
    ].where((map) => map['duration'] != null).toList();

    return Column(
      children: [
        buildChart(data),
        buildLegend(data),
      ],
    );
  }

  Widget buildLegend(List<Map> data) {
    final style = RoastAppTheme.materialTheme.textTheme.bodySmall;
    return Column(
      children: [
        for (int i = 0; i < data.length; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Defaults.colors10[i],
                ),
                child: const SizedBox(
                  height: 8,
                  width: 8,
                ),
              ),
              const SizedBox(width: 4),
              Text('${data[i]["phase"]} (', style: style),
              TimestampWidget.twitter(data[i]['duration'], style: style),
              Text(')', style: style),
            ],
          ),
      ],
    );
  }

  Widget buildChart(List<Map> data) {
    return SizedBox(
      height: 40,
      child: Chart(
        data: data,
        variables: {
          'phase': Variable(
            accessor: (Map map) => map['phase'] as String,
          ),
          'duration': Variable(
            accessor: (Map map) => DateTime(0).add(map['duration'] as Duration),
            scale: TimeScale(),
          ),
          'ms': Variable(
            accessor: (Map map) => (map['duration'] as Duration).inMilliseconds,
          ),
        },
        transforms: [
          Proportion(
            variable: 'ms',
            as: 'percent',
          ),
        ],
        coord: RectCoord(
          transposed: true,
          dimCount: 1,
        ),
        padding: (_) => const EdgeInsets.all(10),
        marks: [
          IntervalMark(
            label: LabelEncode(
              encoder: (tuple) => Label(
                  (tuple['percent'] * 100).toStringAsFixed(1) + '%',
                  LabelStyle(
                      textStyle: Defaults.textStyle
                          .copyWith(color: RoastAppTheme.crema))),
            ),
            elevation: ElevationEncode(
              value: 0,
              updaters: {
                'tap': {true: (_) => 5}
              },
            ),
            color: ColorEncode(
              variable: 'phase',
              values: Defaults.colors10,
              updaters: {
                'tap': {false: (color) => color.withAlpha(100)}
              },
            ),
            position: Varset('percent') * Varset('percent') / Varset('phase'),
            shape: ShapeEncode<IntervalShape>(
              encoder: (map) {
                return RectShape(labelPosition: 0.5);
              },
            ),
            modifiers: [
              StackModifier(),
            ],
          ),
        ],
        axes: [
          Defaults.verticalAxis
            ..line = null
            ..tickLine = null
            ..label = null
            ..grid = null,
          Defaults.horizontalAxis
            ..line = null
            ..tickLine = null
            ..label = null
            ..grid = null,
        ],
        selections: {
          'tap': PointSelection(dim: Dim.x),
        },
      ),
    );
  }
}
