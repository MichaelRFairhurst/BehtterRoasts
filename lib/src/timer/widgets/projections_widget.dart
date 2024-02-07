import 'package:behmor_roast/src/timer/models/projection.dart';
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
              DataCell(Text(entry.value)),
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

  Map<String, String> getProjections(Projection projection) {
    final results = <String, String>{};
    if (projection.currentTemp != null) {
      results['Estimated current temp'] = '${(projection.currentTemp!).round()}°F';
	}
    if (projection.temp30s != null) {
      results['Temp in 30s'] = '${(projection.temp30s!).round()}°F';
	}
    if (projection.temp60s != null) {
      results['Temp in 60s'] = '${(projection.temp60s!).round()}°F';
	}
	return results;
  }
}
