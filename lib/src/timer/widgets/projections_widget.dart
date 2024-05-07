import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/timer/models/projection.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:behmor_roast/src/util/aligned_extra_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/timer/providers.dart';

class ProjectionsWidget extends ConsumerWidget {
  const ProjectionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projection = ref.watch(projectionProvider);
    final projectionMap = getProjections(projection);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text('Projections:',
              style: RoastAppTheme.materialTheme.textTheme.labelLarge),
        ),
        if (projectionMap.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              '(No projections available)',
              style: RoastAppTheme.materialTheme.textTheme.bodySmall,
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AlignedExtraGridView(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                for (final entry in projectionMap.entries)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.center,
                              child: entry.value,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Text(
                              entry.key,
                              style: RoastAppTheme
                                  .materialTheme.textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Map<String, Widget> getProjections(Projection projection) {
    final results = <String, Widget>{};
    final style = RoastAppTheme.materialTheme.textTheme.titleLarge!
        .copyWith(color: RoastAppTheme.metalLight, fontFamily: 'Roboto');
    if (projection.currentTemp != null) {
      results['Estimated current temp'] =
          Text('${(projection.currentTemp!).round()}°F', style: style);
    }
    if (projection.temp30s != null) {
      results['Temp in 30s'] =
          Text('${(projection.temp30s!).round()}°F', style: style);
    }
    if (projection.temp60s != null) {
      results['Temp in 60s'] =
          Text('${(projection.temp60s!).round()}°F', style: style);
    }
    if (projection.roastTime != null) {
      results['Roast Time'] =
          TimestampWidget(projection.roastTime!, style: style);
    }
    if (projection.timeRemaining != null) {
      results['Time Remaining'] =
          TimestampWidget.twitter(projection.timeRemaining!, style: style);
    }
    if (projection.timeToOverheat != null) {
      results['Time To Overheat'] =
          TimestampWidget.twitter(projection.timeToOverheat!, style: style);
    }
    return results;
  }
}
