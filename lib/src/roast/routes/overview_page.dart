import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/providers.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Roast History'),
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
          return ListView.builder(
            itemCount: beans.length,
            itemBuilder: (context, i) {
              return Card(
                margin: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(beans[i].name),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.visibility),
                        label: const Text('View Roasts'),
                        style: RoastAppTheme.limeButtonTheme.style,
                        onPressed: () {
                          context.push(Routes.roastTimeline(beans[i].id!));
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
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
}
