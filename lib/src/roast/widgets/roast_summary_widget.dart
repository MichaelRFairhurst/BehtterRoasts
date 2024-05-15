import 'package:behmor_roast/src/config/theme.dart';

import 'package:behmor_roast/src/roast/models/roast_summary.dart';
import 'package:behmor_roast/src/roast/widgets/phase_chart.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';

class RoastSummaryWidget extends StatelessWidget {
  const RoastSummaryWidget({
    this.cellPadding =
        const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    this.showBeanName = true,
    required this.summary,
    super.key,
  });

  final bool showBeanName;
  final EdgeInsets cellPadding;
  final RoastSummary summary;

  TableRow paddedRow({
    required List<Widget> children,
  }) =>
      TableRow(
        children: children
            .map((child) => Padding(padding: cellPadding, child: child))
            .toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Table(
          columnWidths: const {
            0: IntrinsicColumnWidth(),
          },
          children: [
            if (showBeanName)
              paddedRow(
                children: [
                  const Text('Bean'),
                  Text(summary.beanName),
                ],
              ),
            paddedRow(
              children: [
                const Text('Roast Number'),
                Text('#${summary.roastNumber}'),
              ],
            ),
            paddedRow(
              children: [
                const Text('Roast time:'),
                TimestampWidget.twitter(summary.totalTime),
              ],
            ),
            paddedRow(
              children: [
                const Text('Weight:'),
                Text('${summary.weightIn}g in / ${summary.weightOut}g out'),
              ],
            ),
            paddedRow(
              children: [
                const Text('Weight reduction:'),
                Text(formatPercent(summary.weightLoss)),
              ],
            ),
            paddedRow(
              children: [
                const Text('Development:'),
                Text(
                  [summary.developmentPercent, summary.developmentPercentTarget]
                      .map(formatPercent)
                      .join(' / '),
                ),
              ],
            ),
            if (summary.preheatTime != null)
              paddedRow(
                children: [
                  const Text('Preheat time:'),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: TimestampWidget.twitter(summary.preheatTime!),
                        ),
                        TextSpan(
                          text: ' (',
                          style:
                              RoastAppTheme.materialTheme.textTheme.bodySmall,
                        ),
                        WidgetSpan(
                          child: TimestampWidget.twitter(
                            summary.preheatGap ?? Duration.zero,
                            style:
                                RoastAppTheme.materialTheme.textTheme.bodySmall,
                          ),
                        ),
                        TextSpan(
                          text: ' before roast)',
                          style:
                              RoastAppTheme.materialTheme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
        if (summary.notes != null)
          Padding(
            padding: cellPadding,
            child: Text(
              'Notes: ${summary.notes}',
              style: RoastAppTheme.roastNotesStyle,
            ),
          ),
        const Divider(height: 30),
        Padding(
          padding: cellPadding,
          child: Text(
            'Phase breakdown:',
            style: RoastAppTheme.materialTheme.textTheme.labelMedium,
          ),
        ),
        PhaseChart(summary: summary),
      ],
    );
  }

  String formatPercent(double val) => '${(val * 100).toStringAsFixed(1)}%';
}
