import 'package:behmor_roast/src/chart/temp_chart.dart';
import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/services/roast_summary_service.dart';
import 'package:behmor_roast/src/roast/widgets/roast_summary_widget.dart';
import 'package:behmor_roast/src/roast/widgets/temp_log_widget.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/util/logo_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RoastReviewPage extends ConsumerWidget {
  const RoastReviewPage({
    required this.roastId,
    super.key,
  });

  final String roastId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roast = ref.watch(roastByIdProvider(roastId)).value;
    if (roast == null) {
      return Container();
    }
    final copy = roast.copyOfRoastId == null
        ? null
        : ref.watch(roastByIdProvider(roast.copyOfRoastId!)).value;
    final bean = ref
        .watch(beansProvider)
        .value
        ?.singleWhere((bean) => bean.id == roast.beanId);
    final roastLogService = ref.watch(roastLogServiceProvider);
    if (bean == null) {
      return Container();
    }

    final dateFormat = DateFormat.yMd();
    return Scaffold(
      appBar: AppBar(
        title: LogoTitle('${bean.name} #{roast.roastNumber}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Roast #${roast.roastNumber}',
            style: RoastAppTheme.materialTheme.textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          Text(
            'Roasted: ${dateFormat.format(roast.roasted)}',
            style: RoastAppTheme.materialTheme.textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
          if (copy != null)
            Text(
              'Copy of roast #${copy.roastNumber}',
              style: RoastAppTheme.materialTheme.textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 30),
                    child: RoastSummaryWidget(
                      summary: RoastSummaryService().summarize(roast, bean),
                      cellPadding: const EdgeInsets.all(4.0),
                      showBeanName: false,
                    ),
                  ),
                  TempChart(
                    logs: roastLogService.aggregate(
                      roast.toTimeline(),
                      copy: copy?.toTimeline(),
                    ),
                    copyLogs: copy == null
                        ? null
                        : roastLogService.aggregate(copy.toTimeline()),
                    isLive: false,
                  ),
                  const SizedBox(height: 20),
                  TempLogWidget(
                    logs: roastLogService.aggregate(
                      roast.toTimeline(),
                      copy: copy?.toTimeline(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 82,
              vertical: 15,
            ),
            child: ElevatedButton(
              onPressed: () {
                ref.read(copyOfRoastProvider.notifier).state = roast;
                context.replace(Routes.newRoast);
              },
              child: const Text('Repeat this roast'),
            ),
          ),
        ],
      ),
    );
  }

  static const noRoastsPage = Center(
    child: Text('No roasts yet.'),
  );
}
