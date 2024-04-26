import 'dart:async';

import 'package:behmor_roast/src/roast/models/bean.dart';
import 'package:behmor_roast/src/roast/routes/complete_roast_page.dart';
import 'package:behmor_roast/src/roast/routes/overview_page.dart';
import 'package:behmor_roast/src/roast/routes/roast_review_page.dart';
import 'package:behmor_roast/src/roast/routes/roast_timeline_page.dart';
import 'package:behmor_roast/src/sign_in/routes/sign_in_page.dart';
import 'package:behmor_roast/src/sign_in/routes/welcome_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:behmor_roast/src/timer/routes/timer.dart';
import 'package:behmor_roast/src/roast/routes/new_roast_page.dart';

class Routes {
  static const signIn = '/signIn';
  static const welcome = '/welcome';
  static const overview = '/overview';
  static const newRoast = '/newRoast';
  static const timer = '/timer';
  static const completeRoast = '/completeRoast';

  static const roastIdPart = 'roastId';
  static const roastReviewPart = '/roastReview';
  static const roastReviewConfigPath = '$roastReviewPart/:$roastIdPart';
  static String roastReview(String roastId) => '$roastReviewPart/$roastId';

  static const beanIdPart = 'beanId';
  static const roastTimelinePart = '/roastTimeline';
  static const roastTimelineConfigPath = '$roastTimelinePart/:$beanIdPart';
  static String roastTimeline(String beanId) => '$roastTimelinePart/$beanId';
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
            builder: (context, state) =>
                NewRoastPage(selectedBean: state.extra as Bean?)),
        GoRoute(
            path: Routes.overview,
            builder: (context, state) => const OverviewPage()),
        GoRoute(
          path: Routes.roastReviewConfigPath,
          builder: (context, state) {
            return RoastReviewPage(
                roastId: state.pathParameters[Routes.roastIdPart]!);
          },
        ),
        GoRoute(
          path: Routes.roastTimelineConfigPath,
          builder: (context, state) {
            return RoastTimelinePage(
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
