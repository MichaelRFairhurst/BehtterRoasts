import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';

class TempLogWidget extends ConsumerWidget {

  const TempLogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logs = ref.watch(roastLogsProvider);
    return DataTable(
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
    	    child: Text('Rate of Rise'),
    	  ),
    	),
      ],
      rows: logs.map((log) => DataRow(
    	  cells: [
    	    DataCell(TimestampWidget(log.time)),
    	    DataCell(Text('${log.temp}°F')),
    	    DataCell(log.rateOfRise == null
    		  ? const Text('N/A')
    		  : Text('${log.rateOfRise!.toStringAsFixed(1)}°F/m')),
    	  ],
    	)).toList(),
    );
  }
}
