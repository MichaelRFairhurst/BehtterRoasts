import 'package:behmor_roast/firebase_options.dart';
import 'package:behmor_roast/src/sign_in/widgets/stay_signed_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:behmor_roast/src/config/routes.dart';
import 'package:behmor_roast/src/config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const BehmorRoastApp());
}

class BehmorRoastApp extends StatelessWidget {
  const BehmorRoastApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: StaySignedIn(
        builder: (refresh, redirect) => MaterialApp.router(
          title: 'Behmor Roaster',
          theme: RoastAppTheme.materialTheme,
          routerConfig: createRouter(refresh, redirect),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
