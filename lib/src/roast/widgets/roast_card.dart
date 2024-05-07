import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';

import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/models/roast_summary.dart';
import 'package:behmor_roast/src/roast/services/roast_summary_service.dart';
import 'package:behmor_roast/src/roast/widgets/roast_summary_widget.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/timer/widgets/timestamp_widget.dart';
import 'package:behmor_roast/src/util/widgets/animated_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RoastCard extends ConsumerStatefulWidget {
  const RoastCard({
    required this.roast,
    required this.bean,
    super.key,
  });

  final Roast roast;
  final Bean bean;

  @override
  RoastCardState createState() => RoastCardState();
}

class RoastCardState extends ConsumerState<RoastCard> {
  var opened = false;

  @override
  Widget build(BuildContext context) {
    final roast = widget.roast;
    final bean = widget.bean;
    final summary = RoastSummaryService().summarize(roast, bean);

    return Card(
      elevation: 6.0,
      child: InkWell(
        onTap: () {
          setState(() {
            opened = !opened;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Roast #${roast.roastNumber}',
                style: RoastAppTheme.materialTheme.textTheme.labelSmall,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      'images/beans.svg',
                      width: 38,
                      height: 38,
                      color: _getRoastColor(summary.weightLoss),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    flex: 1,
                    child: _roastTime(),
                  ),
                  Expanded(
                    flex: 1,
                    child: _developmentTime(summary),
                  ),
                  Expanded(
                    flex: 1,
                    child: _weightOut(),
                  ),
                  Icon(
                    opened ? Icons.expand_less : Icons.expand_more,
                    size: 16,
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              AnimatedPopUp(
                child: _expandedContent(summary),
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
            style: RoastAppTheme.materialTheme.textTheme.titleMedium?.copyWith(
              color: RoastAppTheme.lilacDark,
            ),
          ),
          Text('Development',
              style: RoastAppTheme.materialTheme.textTheme.caption),
        ],
      );

  Widget _roastTime() => Column(
        children: [
          TimestampWidget(
            widget.roast.toTimeline().done!,
            style:
                RoastAppTheme.materialTheme.textTheme.headlineLarge?.copyWith(
              color: RoastAppTheme.capuccino,
              fontFamily: 'Roboto',
            ),
          ),
          Text('Roast time',
              style: RoastAppTheme.materialTheme.textTheme.caption),
        ],
      );

  Widget _weightOut() => Column(
        children: [
          Text(
            '${widget.roast.weightOut}g',
            style: RoastAppTheme.materialTheme.textTheme.titleMedium?.copyWith(
              color: RoastAppTheme.indigoDark,
            ),
          ),
          Text('Weight out',
              style: RoastAppTheme.materialTheme.textTheme.caption),
        ],
      );

  Color _getRoastColor(double weightLoss) {
    const minLoss = 0.08;
    const maxLoss = 0.25;
    final baseValue =
        ((weightLoss - minLoss) / (maxLoss - minLoss)).clamp(0.0, 1.0);
    const curve = Curves.easeInOutCubic;
    final value = curve.transform(baseValue);
    return ColorTween(
            begin: const Color(0xFFB36D57), end: RoastAppTheme.capuccino)
        .lerp(value)!;
  }

  Widget _expandedContent(RoastSummary summary) {
    if (!opened) {
      return const SizedBox();
    }
    return Column(
      children: [
        const Divider(),
        RoastSummaryWidget(summary: summary, showBeanName: false),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: RoastAppTheme.limeButtonTheme.style,
                onPressed: () {
                  context.push(Routes.roastReview(widget.roast.id!));
                },
                child: const Text('Full details'),
              ),
              const SizedBox(width: 12.0),
              ElevatedButton(
                style: RoastAppTheme.limeButtonTheme.style,
                onPressed: () {
                  // Clear copy state first so that this is a change. Otherwise,
                  // the roast instruction state isn't properly reset.
                  ref.read(copyOfRoastProvider.notifier).state = null;
                  ref.read(copyOfRoastProvider.notifier).state = widget.roast;
                  context.replace(Routes.newRoast);
                },
                child: const Text('Roast again'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
