import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/timer/providers.dart';

class ProjectionsWidget extends ConsumerWidget {

  const ProjectionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(roastLogsProvider);
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
        for (final entry in getProjections(logs).entries)
          DataRow(
           cells: [
             DataCell(Text(entry.key)),
             DataCell(Text(entry.value)),
           ],
         ),
      ],
	);
  }

  Map<String, String> getProjections(List<RoastLog> logs) {
    final results = <String, String>{};
    if (logs.length > 1) {
	  final temp = logs.last.tempLog.temp;
	  final ror = logs.last.rateOfRise!;
      results['Temp in 30s'] = '${(temp + ror / 2).round()}°F';
      results['Temp in 60s'] = '${(temp + ror).round()}°F';
	}
	return results;
  }
}
