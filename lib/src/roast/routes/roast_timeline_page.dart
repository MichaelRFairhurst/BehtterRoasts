import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';

import 'package:behmor_roast/src/roast/models/roast.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/widgets/continent_icon.dart';
import 'package:behmor_roast/src/roast/widgets/roast_card.dart';
import 'package:behmor_roast/src/util/logo_title.dart';
import 'package:behmor_roast/src/util/widgets/list_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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
    final roasts = ref.watch(roastsForBeanProvider(beanId));
    final beanService = ref.watch(beanServiceProvider);
    final bean = ref
        .watch(beansProvider)
        .value!
        .singleWhere((bean) => bean.id == beanId);

    return Scaffold(
      appBar: AppBar(
        title: const LogoTitle('Timeline'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Hero(
                      tag: '${bean.name}Icon',
                      child: ContinentIcon(beanService.continentOf(bean),
                          height: 54)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Hero(
                      tag: bean.name,
                      child: Text(
                        bean.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              ListLoader<Roast>(
                asyncValue: roasts,
                empty: () {
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 80),
                        Center(
                          child: SvgPicture.asset(
                            'images/beans.svg',
                            height: 80,
                            color: RoastAppTheme.limeDark,
                          ),
                        ),
                        Text(
                          'Nothing here yet!',
                          style: RoastAppTheme
                              .materialTheme.textTheme.displaySmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'You have not yet roasted ${bean.name}.',
                          style:
                              RoastAppTheme.materialTheme.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
                data: (roasts) {
                  final dates = getDates(roasts);

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Roast Timeline:',
                        style:
                            RoastAppTheme.materialTheme.textTheme.titleMedium,
                      ),
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
	  floatingActionButton: ElevatedButton.icon(
	    style: RoastAppTheme.largeButtonTheme.style,
		icon: const Icon(Icons.local_fire_department, size: 32),
		label: const Text('Roast'),
		onPressed: () {
		  context.push(Routes.newRoast, extra: bean);
		}
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
