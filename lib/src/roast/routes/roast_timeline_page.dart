import 'package:behmor_roast/src/config/theme.dart';

import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/widgets/roast_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RoastTimelinePage extends ConsumerWidget {
  RoastTimelinePage({
    required this.beanId,
    super.key,
  });

  final String beanId;
  final dateFormat = DateFormat('EEEE, MMMM d, y');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roasts = ref.watch(roastsForBeanProvider(beanId)).value ?? [];
    final bean = ref
        .watch(beansProvider)
        .value
        ?.singleWhere((bean) => bean.id == beanId);

    final dates = getDates(roasts);

    return Scaffold(
      appBar: AppBar(
        title: Text(bean!.name, overflow: TextOverflow.fade),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Your Roast Timeline:',
                  style: RoastAppTheme.materialTheme.textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 18),
              for (final date in dates) ...[
                dateHeader(date),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const VerticalDivider(
                        color: RoastAppTheme.capuccinoLight,
                        width: 12.0,
                        thickness: 1.0,
                        //indent: 12.0,
                        endIndent: 30.0,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            for (final roast
                                in roastsForDate(date, roasts)) ...[
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: RoastCard(
                                  roast: roast,
                                  bean: bean,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget dateHeader(DateTime date) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: RoastAppTheme.capuccinoLight,
                shape: BoxShape.circle,
              ),
              child: const SizedBox(
                width: 12,
                height: 12,
              ),
            ),
            const SizedBox(width: 8),
            Text(dateFormat.format(date)),
          ],
        ),
      );

  List<Roast> roastsForDate(DateTime date, List<Roast> roasts) {
    final dateAfter = date.add(const Duration(days: 1));
    return roasts
        .where((roast) =>
            roast.roasted.isBefore(dateAfter) && roast.roasted.isAfter(date))
        .toList();
  }

  List<DateTime> getDates(List<Roast> roasts) {
    final dates = <DateTime>{};
    for (final roast in roasts) {
      final time = roast.roasted;
      final date = DateTime(time.year, time.month, time.day, 0, 0);
      dates.add(date);
    }

    return dates.toList()..sort((a, b) => a.compareTo(b));
  }
}
