import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';

import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/models/roast_summary.dart';
import 'package:behmor_roast/src/roast/services/roast_summary_service.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RoastCard extends ConsumerWidget {
  const RoastCard({
    required this.roast,
    required this.bean,
    super.key,
  });

  final Roast roast;
  final Bean bean;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = RoastSummaryService().summarize(roast, bean);

    return Card(
      elevation: 6.0,
      child: InkWell(
        onTap: () {
          context.push(Routes.roastReview(roast.id!));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Roast #${roast.roastNumber}',
                style: RoastAppTheme.materialTheme.textTheme.labelSmall,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: _developmentTime(summary),
                  ),
                  Expanded(
                    flex: 1,
                    child: _roastTime(),
                  ),
                  Expanded(
                    flex: 1,
                    child: _weightOut(),
                  ),
                ],
              ),
              const Divider(),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0, right: 4.0),
                  child: SizedBox(
                    height: 28,
                    child: ElevatedButton(
                      style: RoastAppTheme.limeButtonTheme.style,
                      onPressed: () {
                        ref.read(copyOfRoastProvider.notifier).state = roast;
                        context.replace(Routes.newRoast);
                      },
                      child: const Text('Roast again'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _developmentTime(RoastSummary summary) => Column(
        children: [
          Text(
            '${(summary.developmentPercent * 100).toStringAsFixed(1)}%',
            style: RoastAppTheme.materialTheme.textTheme.titleLarge?.copyWith(
              color: RoastAppTheme.lilacDark,
            ),
          ),
          Text('Development %',
              style: RoastAppTheme.materialTheme.textTheme.caption),
        ],
      );

  Widget _roastTime() => Column(
        children: [
          TimestampWidget(
            roast.toTimeline().done!,
            style: RoastAppTheme.materialTheme.textTheme.displaySmall?.copyWith(
              color: RoastAppTheme.capuccino,
            ),
          ),
          Text('Roast time',
              style: RoastAppTheme.materialTheme.textTheme.caption),
        ],
      );

  Widget _weightOut() => Column(
        children: [
          Text(
            '${roast.weightOut}g',
            style: RoastAppTheme.materialTheme.textTheme.titleMedium?.copyWith(
              color: RoastAppTheme.indigoDark,
            ),
          ),
          Text('Weight out',
              style: RoastAppTheme.materialTheme.textTheme.caption),
        ],
      );
}
