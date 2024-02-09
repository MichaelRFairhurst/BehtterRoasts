import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/roast/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RoastHistoryPage extends ConsumerWidget {
  const RoastHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
	final roasts = ref.watch(roastsProvider);

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
			    margin: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
			    child: Container(
				  padding: const EdgeInsets.all(8.0),
				  child: Text(items[i].bean.name)
				),
			  );
	        }
	      );
	    },
	    loading: () => Container(),
	    error: (e, st) => Container(),
	  ),
	  floatingActionButton: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: const Text('New Roast'),
        onPressed: () {
	      context.push(Routes.newRoast);
        }
      ),
	);
  }

}
