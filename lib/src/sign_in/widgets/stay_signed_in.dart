import 'dart:async';

import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/sign_in/providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StaySignedIn extends ConsumerWidget {
  const StaySignedIn({
    required this.builder,
    super.key,
  });

  final Widget Function(
          Listenable, FutureOr<String?> Function(BuildContext, GoRouterState))
      builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = _AuthNotifier();

    ref.listen(authProvider, (old, newAuth) {
      notifier.notify();
    });

    return builder(notifier, (context, state) {
      final user = ref.read(authProvider).value;
      if (user == null) {
        return Routes.signIn;
      } else if (state.location == Routes.signIn) {
        return Routes.welcome;
      }
    });
  }
}

class _AuthNotifier extends ChangeNotifier {
  void notify() => notifyListeners();
}
