import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/roast/widgets/bean_card.dart';
import 'package:behmor_roast/src/sign_in/widgets/signed_in_drawer.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:behmor_roast/src/util/widgets/animated_pop_up.dart';
import 'package:behmor_roast/src/util/widgets/bobble.dart';
import 'package:behmor_roast/src/util/widgets/list_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class OverviewPage extends ConsumerStatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  OverviewPageState createState() => OverviewPageState();
}

class OverviewPageState extends ConsumerState<OverviewPage> {
  bool showArchived = false;

  @override
  Widget build(BuildContext context) {
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
          final archived = beans.where((bean) => bean.archived).toList();
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
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) {
                            return BeanCard(
                              bean: unarchived[i],
                              beanService: beanService,
                            );
                          },
                          childCount: unarchived.length,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child: showArchived
                              ? TextButton.icon(
                                  icon: const Icon(Icons.expand_less),
                                  label: const Text('Hide archived coffees'),
                                  onPressed: () {
                                    setState(() {
                                      showArchived = false;
                                    });
                                  },
                                )
                              : TextButton.icon(
                                  icon: const Icon(Icons.expand_more),
                                  label: Text(
                                      '${archived.length} archived coffees'),
                                  onPressed: () {
                                    setState(() {
                                      showArchived = true;
                                    });
                                  },
                                ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: AnimatedPopUp(
                            child: showArchived
                                ? Column(
                                    children: archived
                                        .map((bean) => BeanCard(
                                            bean: bean,
                                            beanService: beanService))
                                        .toList())
                                : const SizedBox()),
                      ),
                    ],
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
}
