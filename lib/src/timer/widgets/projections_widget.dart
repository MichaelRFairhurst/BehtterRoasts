import 'package:behmor_roast/src/timer/models/projection.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/timer/providers.dart';

class ProjectionsWidget extends ConsumerWidget {
  const ProjectionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projection = ref.watch(projectionProvider);
    final projectionMap = getProjections(projection);
    return DataTable(
      columns: const [
        DataColumn(
          label: Expanded(
            child: Text('Projections'),
          ),
        ),
        DataColumn(label: Text('')),
      ],
      rows: [
        for (final entry in projectionMap.entries)
          DataRow(
            cells: [
              DataCell(Text(entry.key)),
              DataCell(entry.value),
            ],
          ),
        if (projectionMap.isEmpty)
          const DataRow(
            cells: [
              DataCell(Text('no projections available')),
              DataCell(Text('')),
            ],
          ),
      ],
    );
  }

  Map<String, Widget> getProjections(Projection projection) {
    final results = <String, Widget>{};
    if (projection.currentTemp != null) {
      results['Estimated current temp'] =
          Text('${(projection.currentTemp!).round()}°F');
    }
    if (projection.temp30s != null) {
      results['Temp in 30s'] = Text('${(projection.temp30s!).round()}°F');
    }
    if (projection.temp60s != null) {
      results['Temp in 60s'] = Text('${(projection.temp60s!).round()}°F');
    }
    if (projection.roastTime != null) {
      results['Roast Time'] = TimestampWidget(projection.roastTime!);
    }
    if (projection.timeRemaining != null) {
      results['Time Remaining'] =
          TimestampWidget.twitter(projection.timeRemaining!);
    }
    if (projection.timeToOverheat != null) {
      results['Time To Overheat'] =
          TimestampWidget.twitter(projection.timeToOverheat!);
    }
    return results;
  }
}
