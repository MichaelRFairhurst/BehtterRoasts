import 'dart:async';

import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/sign_in/providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StaySignedIn extends ConsumerStatefulWidget {
  const StaySignedIn({
    required this.builder,
    super.key,
  });

  final Widget Function(
          Listenable, FutureOr<String?> Function(BuildContext, GoRouterState))
      builder;

  @override
  StaySignedInState createState() => StaySignedInState();
}

class StaySignedInState extends ConsumerState<StaySignedIn> {
  final notifier = _AuthNotifier();
  Widget? child;

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authProvider, (old, newAuth) {
      notifier.notify();
    });

    GoRouteInformationParser? z;
    GoRouterDelegate? y;
    Router? x;
    return child ??= widget.builder(notifier, (context, state) {
      final user = ref.read(authProvider).value;
      if (user == null) {
        return Routes.signIn;
      } else if (state.location == Routes.signIn) {
        return Routes.welcome;
      }

      return null;
    });
  }
}

class _AuthNotifier extends ChangeNotifier {
  void notify() async {
    notifyListeners();
  }
}
