import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/services/bean_service.dart';
import 'package:behmor_roast/src/roast/widgets/continent_icon.dart';
import 'package:behmor_roast/src/sign_in/widgets/signed_in_drawer.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/util/widgets/bobble.dart';
import 'package:behmor_roast/src/util/widgets/list_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class OverviewPage extends ConsumerWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final beans = ref.watch(beansProvider);
    final beanService = ref.watch(beanServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Behmor Roast App'),
      ),
      drawer: const SignedInDrawer(),
      body: ListLoader<Bean>(
        asyncValue: beans,
        empty: () {
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset('images/beans.svg', height: 80),
                ),
                Text(
                  'Start roasting!',
                  style: RoastAppTheme.materialTheme.textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  "You don't have any roasts yet. Tap the button below to"
                  ' begin.',
                  style: RoastAppTheme.materialTheme.textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    context.push(Routes.newRoast);
                  },
                  style: RoastAppTheme.largeButtonTheme.style,
                  label: const Text('Begin your first roast'),
                  icon: const Icon(Icons.add),
                ),
                const SizedBox(height: 24),
                Bobble(
                  child: Text(
                    '☝️',
                    style: RoastAppTheme.materialTheme.textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
        data: (beans) {
          final unarchived = beans.where((bean) => !bean.archived).toList();
          //final archived = beans.where((bean) => bean.archived).toList();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                Text(
                  'Your Coffee:',
                  style: RoastAppTheme.materialTheme.textTheme.titleLarge,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: unarchived.length,
                    itemBuilder: (context, i) {
                      return beanCard(context, unarchived[i], beanService);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: beans.when(
        loading: () => null,
        error: (_, __) => null,
        data: (data) => data.isEmpty
            ? null
            : ElevatedButton.icon(
                style: RoastAppTheme.largeButtonTheme.style,
                icon: const Icon(Icons.add),
                label: const Text('New Roast'),
                onPressed: () {
                  ref.read(copyOfRoastProvider.notifier).state = null;
                  context.push(Routes.newRoast);
                }),
      ),
    );
  }

  Widget beanCard(BuildContext context, Bean bean, BeanService beanService) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Hero(
              tag: '${bean.name}Icon',
              child: ContinentIcon(beanService.continentOf(bean)),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 16.0),
                  child: Hero(
                    tag: bean.name,
                    child: Text(bean.name,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        color: RoastAppTheme.limeDark,
                        tooltip: 'Archive',
                        onPressed: () {
                          //beanService.update(bean.copyWith(archived: true));
                        },
                        icon: const Icon(Icons.archive),
                      ),
                      IconButton(
                        color: RoastAppTheme.limeDark,
                        icon: const Icon(Icons.timeline),
                        tooltip: 'Roast Timeline',
                        onPressed: () {
                          context.push(Routes.roastTimeline(bean.id!));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 56,
            child: VerticalDivider(width: 1),
          ),
          IconButton(
            iconSize: 48,
            icon: const Icon(Icons.local_fire_department_sharp),
            color: RoastAppTheme.errorColor,
            tooltip: 'Roast',
            onPressed: () {
              context.push(Routes.newRoast, extra: bean);
            },
          ),
        ],
      ),
    );
  }
}