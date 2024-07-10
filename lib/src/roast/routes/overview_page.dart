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

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final beans = ref.watch(beansProvider);
    final beanService = ref.watch(beanServiceProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset('images/logo_transparent.svg'),
        ),
        title: const Text('Behtter Roasts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ],
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
                  style: RoastAppTheme.materialTheme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    context.push(Routes.newRoast);
                  },
                  style: RoastAppTheme.largeButtonTheme.style,
                  label: const Text('Begin your first roast'),
                  icon: const Icon(Icons.local_fire_department),
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
                      if (unarchived.isEmpty)
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                "You don't have any unarchived coffees. To"
                                ' roast a new bean, tap the button below.',
                                style: RoastAppTheme
                                    .materialTheme.textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: () {
                                  context.push(Routes.newRoast);
                                },
                                style: RoastAppTheme.largeButtonTheme.style,
                                label: const Text('Roast a new bean'),
                                icon: const Icon(Icons.local_fire_department),
                              ),
                              const SizedBox(height: 24),
                              Bobble(
                                child: Text(
                                  '☝️',
                                  style: RoastAppTheme
                                      .materialTheme.textTheme.displayMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 48),
                            ],
                          ),
                        ),
                      if (archived.isNotEmpty)
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
                                    label: Text(archived.length == 1
                                        ? '1 archived coffee'
                                        : '${archived.length} archived coffees'),
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
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 50),
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
        data: (data) => data.any((bean) => !bean.archived)
            ? ElevatedButton.icon(
                style: RoastAppTheme.largeButtonTheme.style,
                icon: const Icon(Icons.add),
                label: const Text('New Roast'),
                onPressed: () {
                  ref.read(copyOfRoastProvider.notifier).state = null;
                  context.push(Routes.newRoast);
                })
            : null,
      ),
    );
  }
}
