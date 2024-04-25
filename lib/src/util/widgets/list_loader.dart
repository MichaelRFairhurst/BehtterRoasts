import 'package:behmor_roast/src/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListLoader<T> extends StatelessWidget {
  const ListLoader({
    required this.asyncValue,
    required this.empty,
    required this.data,
    super.key,
  });

  final AsyncValue<List<T>> asyncValue;
  final Widget Function() empty;
  final Widget Function(List<T>) data;

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      data: (result) {
        if (result.isEmpty) {
          return empty();
        } else {
          return data(result);
        }
      },
      error: errorPage,
    );
  }

  Widget errorPage(Object e, StackTrace st) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Oops, something went wrong!',
            style: RoastAppTheme.materialTheme.textTheme.displaySmall),
        const SizedBox(height: 10),
        Text('An error occurred: $e'),
        Text(st.toString()),
      ],
    );
  }
}
