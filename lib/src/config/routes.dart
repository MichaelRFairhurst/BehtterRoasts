import 'package:go_router/go_router.dart';
import 'package:behmor_roast/src/timer/routes/timer.dart';
import 'package:behmor_roast/src/roast/routes/new_roast_page.dart';

class Routes {
  static const newRoast = '/newRoast';
  static const timer = '/timer';

  /*
  static final routes = <String, Widget Function(BuildContext)>{
    newRoast: (context) {
      return const NewRoastPage();
    },
    timer: (context) {
      return const TimerPage();
    },
  };
  */
}

final router = GoRouter(
  initialLocation: Routes.newRoast,
  routes: [
    GoRoute(
      path: Routes.newRoast,
      builder: (context, state) => const NewRoastPage()
    ),
    GoRoute(
      path: Routes.timer,
      builder: (context, state) => const TimerPage()
    ),
    /*GoRoute(
      path: Routes.systemDetails(':systemName'),
      builder: (context, state)
        => SystemsDetailPage(systemName: state.pathParameters['systemName']!),
    ),*/
  ],
);
