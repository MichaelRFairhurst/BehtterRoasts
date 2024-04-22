import 'dart:async';

import 'package:behmor_roast/src/roast/routes/complete_roast_page.dart';
import 'package:behmor_roast/src/roast/routes/roast_history.dart';
import 'package:behmor_roast/src/roast/routes/roast_review_page.dart';
import 'package:behmor_roast/src/sign_in/routes/sign_in_page.dart';
import 'package:behmor_roast/src/sign_in/routes/welcome_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:behmor_roast/src/timer/routes/timer.dart';
import 'package:behmor_roast/src/roast/routes/new_roast_page.dart';

class Routes {
  static const signIn = '/signIn';
  static const welcome = '/welcome';
  static const roastHistory = '/roastHistory';
  static const newRoast = '/newRoast';
  static const timer = '/timer';
  static const completeRoast = '/completeRoast';

  static const beanIdPart = 'beanId';
  static const roastReviewPart = '/roastReview';
  static const roastReviewConfigPath = '$roastReviewPart/:$beanIdPart';
  static String roastReview(String beanId) => '$roastReviewPart/$beanId';
}

GoRouter createRouter(Listenable refreshListenable,
        FutureOr<String?> Function(BuildContext, GoRouterState) redirect) =>
    GoRouter(
      initialLocation: Routes.signIn,
      routes: [
        GoRoute(
            path: Routes.signIn,
            builder: (context, state) => const SignInPage()),
        GoRoute(
            path: Routes.welcome,
            builder: (context, state) => const WelcomePage()),
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
        GoRoute(
            path: Routes.timer, builder: (context, state) => const TimerPage()),
        GoRoute(
            path: Routes.completeRoast,
            builder: (context, state) => const CompleteRoastPage()),
      ],
      redirect: redirect,
      refreshListenable: refreshListenable,
    );
