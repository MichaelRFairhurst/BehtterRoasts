import 'package:behmor_roast/src/roast/models/roast_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';

class TempLogWidget extends ConsumerWidget {

  const TempLogWidget({
	required this.logs,
	super.key,
  });

  final List<RoastLog> logs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DataTable(
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
      rows: getRows(logs),
    );
  }

  List<DataRow> getRows(List<RoastLog> logs) {
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

    return logs.map((log) => DataRow(
        cells: [
          DataCell(TimestampWidget(log.time)),
          tempCell(log),
          powerCell(log),
          phaseCell(log),
          rorCell(log),
        ],
      )).toList();
  }

  DataCell tempCell(RoastLog log) {
    if (log.temp == null) {
      return const DataCell(Text(''));
    }

    return DataCell(Text('${log.temp}°F'));
  }

  DataCell powerCell(RoastLog log) {
    if (log.control == null) {
      return const DataCell(Text(''));
    }

    return DataCell(Text(log.control.toString().replaceAll('Control.','').toUpperCase()));
  }

  DataCell phaseCell(RoastLog log) {
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
