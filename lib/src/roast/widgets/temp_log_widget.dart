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
    this.isLive = false,
    this.isDiff = false,
    super.key,
  });

  final bool isDiff;
  final bool isLive;
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
        columns: [
          const DataColumn(
            label: Expanded(
              child: Text('Time'),
            ),
          ),
          const DataColumn(
            label: Expanded(
              child: Text('Temp'),
            ),
          ),
          if (isDiff)
            const DataColumn(
              label: Expanded(
                child: Text('Temp Diff'),
              ),
            )
          else
            const DataColumn(
              label: Expanded(
                child: Text('Rate of Rise'),
              ),
            ),
          const DataColumn(
            label: Expanded(
              child: Text('Other'),
            ),
          ),
        ],
        rows: getRows(context, ref),
      ),
    );
  }

  List<DataRow> getRows(BuildContext context, WidgetRef ref) {
    final logs = isLive ? this.logs.reversed : this.logs;

    if (logs.isEmpty) {
      return const [
        DataRow(
          cells: [
            DataCell(Text('no logs yet')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
          ],
        ),
      ];
    }

    final lastTemp = this.logs.lastWhere((log) => log.temp != null,
        orElse: () => const RoastLog(time: Duration.zero));
    return logs
        .map((log) => DataRow(
              cells: [
                DataCell(TimestampWidget(log.time)),
                tempCell(log, context, ref, isLast: log == lastTemp),
                if (isDiff) diffCell(log) else rorCell(log),
                powerAndPhaseCell(log),
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
      showEditIcon: isLive && isLast,
      onTap: isLive && isLast ? updateTemp : null,
      onLongPress: isLive ? updateTemp : null,
    );
  }

  DataCell powerAndPhaseCell(RoastLog log) {
    switch (log.phase) {
      case RoastPhase.preheat:
        return const DataCell(Text('Preheat'));
      case RoastPhase.start:
        return const DataCell(Text('Start'));
      case RoastPhase.dryEnd:
        return const DataCell(Text('Dry End'));
      case RoastPhase.firstCrackStart:
        return const DataCell(Text('FC Start'));
      case RoastPhase.firstCrackEnd:
        return const DataCell(Text('FC End'));
      case RoastPhase.secondCrackStart:
        return const DataCell(Text('SC Start'));
      case RoastPhase.done:
        return const DataCell(Text('Done'));
      case null:
      // nothing
    }

    if (log.control == null) {
      return const DataCell(Text(''));
    } else {
      return DataCell(Text(
          log.control.toString().replaceAll('Control.', '').toUpperCase()));
    }
  }

  DataCell rorCell(RoastLog log) {
    if (log.rateOfRise == null) {
      return const DataCell(Text(''));
    }

    return DataCell(Text('${log.rateOfRise!.toStringAsFixed(1)}°F/m'));
  }

  DataCell diffCell(RoastLog log) {
    if (log.tempDiff != null) {
      return tempDiffCell(log);
    } else if (log.timeDiff != null) {
      return timeDiffCell(log);
    } else {
      return const DataCell(Text(''));
    }
  }

  DataCell tempDiffCell(RoastLog log) {
    final tempDiff = log.tempDiff;
    if (tempDiff == null) {
      return const DataCell(Text(''));
    }

    if (tempDiff == 0) {
      return const DataCell(Text('0°F'));
    } else if (tempDiff > 0) {
      return DataCell(Text(
        '$tempDiff°F hot',
        style: const TextStyle(
          color: RoastAppTheme.errorColor,
        ),
      ));
    } else {
      return DataCell(Text(
        '${-tempDiff}°F low',
        style: const TextStyle(
          color: RoastAppTheme.indigo,
        ),
      ));
    }
  }

  DataCell timeDiffCell(RoastLog log) {
    final timeDiff = log.timeDiff;
    if (timeDiff == null) {
      return const DataCell(Text(''));
    }

    if (timeDiff.abs().inSeconds < 1) {
      return const DataCell(Text(''));
    } else if (timeDiff.isNegative) {
      return DataCell(Row(
        children: [
          TimestampWidget.twitter(-timeDiff),
          const Text(' late'),
        ],
      ));
    } else {
      return DataCell(Row(
        children: [
          TimestampWidget.twitter(timeDiff),
          const Text(' early'),
        ],
      ));
    }
  }
}
