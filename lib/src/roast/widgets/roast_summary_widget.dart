import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/roast_summary.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';

class RoastSummaryWidget extends StatelessWidget {
  const RoastSummaryWidget({
    this.cellPadding = const EdgeInsets.all(6.0),
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
                const Text('Roast time:'),
                TimestampWidget.twitter(summary.totalTime),
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
                phaseDetails(
                  summary.developmentPhaseTime,
                  summary.developmentPercent,
                  extra: '/${formatPercent(summary.developmentPercentTarget)}',
                ),
              ],
            ),
            paddedRow(
              children: [
                const Text('First Crack Phase:'),
                phaseDetails(
                  summary.firstCrackPhaseTime,
                  summary.firstCrackPhasePercent,
                ),
              ],
            ),
            if (summary.secondCrackPhaseTime != null)
              paddedRow(
                children: [
                  const Text('Second Crack Phase:'),
                  phaseDetails(
                    summary.secondCrackPhaseTime!,
                    summary.secondCrackPhasePercent!,
                  ),
                ],
              ),
            paddedRow(
              children: [
                const Text('Maillard Phase:'),
                phaseDetails(
                  summary.maillardPhaseTime,
                  summary.maillardPhasePercent,
                ),
              ],
            ),
            paddedRow(
              children: [
                const Text('Dry Phase:'),
                phaseDetails(
                  summary.dryPhaseTime,
                  summary.dryPhasePercent,
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
      ],
    );
  }

  Widget phaseDetails(Duration time, double percent, {String extra = ''}) =>
      RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: TimestampWidget.twitter(time),
            ),
            TextSpan(
              text: ' (${formatPercent(percent)}$extra)',
              style: RoastAppTheme.materialTheme.textTheme.bodySmall,
            ),
          ],
        ),
      );

  String formatPercent(double val) => '${(val * 100).toStringAsFixed(1)}%';
}
