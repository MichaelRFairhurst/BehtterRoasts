import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/check_temp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';

class TempLogWidget extends ConsumerWidget {
  const TempLogWidget({
    required this.logs,
    this.editable = false,
    super.key,
  });

  final bool editable;
  final List<RoastLog> logs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconTheme(
      data: const IconThemeData(
        color: RoastAppTheme.metalLight,
        size: 4,
      ),
      child: DataTable(
        dataRowHeight: 20,
        columnSpacing: 10,
        headingRowHeight: 26,
        columns: const [
          DataColumn(
            label: Expanded(
              child: Text('Time'),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text('Temp'),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text('Power'),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text('Phase'),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text('Rate of Rise'),
            ),
          ),
        ],
        rows: getRows(logs, context, ref),
      ),
    );
  }

  List<DataRow> getRows(
      List<RoastLog> logs, BuildContext context, WidgetRef ref) {
    if (logs.isEmpty) {
      return const [
        DataRow(
          cells: [
            DataCell(Text('no logs yet')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
          ],
        ),
      ];
    }

    final lastTemp = logs.lastWhere((log) => log.temp != null);
    return logs
        .map((log) => DataRow(
              cells: [
                DataCell(TimestampWidget(log.time)),
                tempCell(log, context, ref, isLast: log == lastTemp),
                powerCell(log),
                phaseCell(log),
                rorCell(log),
              ],
            ))
        .toList();
  }

  DataCell tempCell(RoastLog log, BuildContext context, WidgetRef ref,
      {required bool isLast}) {
    if (log.temp == null) {
      return const DataCell(Text(''));
    }

    void updateTemp() {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              color: RoastAppTheme.metalLight,
              margin: const EdgeInsets.all(30),
              padding: const EdgeInsets.all(16),
              child: IntrinsicHeight(
                child: CheckTempWidget(
                  title: Row(
                    children: [
                      const Text('Enter temperature for '),
                      if (log.phase == RoastPhase.preheat)
                        const Text('preheat')
                      else
                        TimestampWidget.twitter(log.time),
                      const Text(':'),
                    ],
                  ),
                  onSubmit: (newTemp) {
                    if (log.phase == RoastPhase.preheat) {
                      ref
                          .read(roastTimelineProvider.notifier)
                          .update((tl) => tl.copyWith(preheatTemp: newTemp));
                    } else {
                      ref
                          .read(roastTimelineProvider.notifier)
                          .update((tl) => tl.updateTemp(log.time, newTemp));
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          );
        },
      );
    }

    return DataCell(
      Text('${log.temp}°F'),
      showEditIcon: editable && isLast,
      onTap: editable && isLast ? updateTemp : null,
      onLongPress: editable ? updateTemp : null,
    );
  }

  DataCell powerCell(RoastLog log) {
    if (log.control == null) {
      return const DataCell(Text(''));
    }

    return DataCell(
        Text(log.control.toString().replaceAll('Control.', '').toUpperCase()));
  }

  DataCell phaseCell(RoastLog log) {
    if (log.phase == RoastPhase.preheat) {
      return const DataCell(Text('Preheat'));
    }
    if (log.phase == RoastPhase.start) {
      return const DataCell(Text('Start'));
    }
    if (log.phase == RoastPhase.dryEnd) {
      return const DataCell(Text('Dry End'));
    }
    if (log.phase == RoastPhase.firstCrackStart) {
      return const DataCell(Text('FC Start'));
    }
    if (log.phase == RoastPhase.firstCrackEnd) {
      return const DataCell(Text('FC End'));
    }
    if (log.phase == RoastPhase.done) {
      return const DataCell(Text('Done'));
    }

    return const DataCell(Text(''));
  }

  DataCell rorCell(RoastLog log) {
    if (log.rateOfRise == null) {
      return const DataCell(Text(''));
    }

    return DataCell(Text('${log.rateOfRise!.toStringAsFixed(1)}°F/m'));
  }
}
