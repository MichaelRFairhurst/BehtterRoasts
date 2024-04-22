import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:behmor_roast/src/timer/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RoastHistoryPage extends ConsumerWidget {
  const RoastHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roasts = ref.watch(beansProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Roast History'),
      ),
      body: roasts.when(
        data: (items) {
          return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                return Card(
                  margin:
                      const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(items[i].name),
                        ),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.visibility),
                          label: const Text('View Roasts'),
                          style: RoastAppTheme.limeButtonTheme.style,
                          onPressed: () {
                            context.push(Routes.roastReview(items[i].id!));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        loading: () => Container(),
        error: (e, st) => Container(),
      ),
      floatingActionButton: ElevatedButton.icon(
          style: RoastAppTheme.largeButtonTheme.style,
          icon: const Icon(Icons.add),
          label: const Text('New Roast'),
          onPressed: () {
            ref.read(copyOfRoastProvider.notifier).state = null;
            context.push(Routes.newRoast);
          }),
    );
  }
}
