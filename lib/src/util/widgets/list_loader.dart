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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeInExpo,
      switchOutCurve: Curves.easeOutExpo,
      /*layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          children: [
            for (final child in previousChildren) Positioned.fill(child: child),
            if (currentChild != null) Positioned.fill(child: currentChild),
          ],
        );
      },*/
      child: asyncValue.when(
        loading: loadingPage,
        error: errorPage,
        data: (result) {
          if (result.isEmpty) {
            return empty();
          } else {
            return data(result);
          }
        },
      ),
    );
  }

  Widget errorPage(Object e, StackTrace st) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Oops, something went wrong!',
              style: RoastAppTheme.materialTheme.textTheme.displaySmall),
          const SizedBox(height: 10),
          Text('An error occurred: $e'),
          const SizedBox(height: 10),
          const Text('Backtrace'),
          Text(st.toString(), maxLines: 15, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget loadingPage() => const Center(
        key: Key('loader'),
        child: CircularProgressIndicator(),
      );
}
