import 'package:behmor_roast/src/roast/routes/complete_roast_page.dart';
import 'package:behmor_roast/src/roast/routes/roast_history.dart';
import 'package:behmor_roast/src/roast/routes/roast_review_page.dart';
import 'package:go_router/go_router.dart';
import 'package:behmor_roast/src/timer/routes/timer.dart';
import 'package:behmor_roast/src/roast/routes/new_roast_page.dart';

class Routes {
  static const roastHistory = '/roastHistory';
  static const newRoast = '/newRoast';
  static const timer = '/timer';
  static const completeRoast = '/completeRoast';

  static const beanIdPart = 'beanId';
  static const roastReviewPart = '/roastReview';
  static const roastReviewConfigPath = '$roastReviewPart/:$beanIdPart';
  static String roastReview(String beanId) => '$roastReviewPart/$beanId';
}

final router = GoRouter(
  initialLocation: Routes.roastHistory,
  routes: [
    GoRoute(
        path: Routes.newRoast,
        builder: (context, state) => const NewRoastPage()),
    GoRoute(
        path: Routes.roastHistory,
        builder: (context, state) => const RoastHistoryPage()),
    GoRoute(
      path: Routes.roastReviewConfigPath,
      builder: (context, state) {
        return RoastReviewPage(
            beanId: state.pathParameters[Routes.beanIdPart]!);
      },
    ),
    GoRoute(path: Routes.timer, builder: (context, state) => const TimerPage()),
    GoRoute(
        path: Routes.completeRoast,
        builder: (context, state) => const CompleteRoastPage()),
  ],
);
