import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/sign_in/services/sign_in_service.dart';
import 'package:behmor_roast/src/util/widgets/bobble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'dart:developer' as developer;

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in to Behtter Roasts'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 80,
                child: SvgPicture.asset('images/logo_transparent.svg')),
            Text(
              'Welcome to Behtter Roasts, your new roast helper app!',
              style: RoastAppTheme.materialTheme.textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const Text(
              'To use our app, please sign in. Your roast history will be'
              ' privately saved to your account.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SignInButton(
              Buttons.Google,
              onPressed: () async {
                try {
                  await SignInService().signIn();
                } catch (e, st) {
                  print(e);
                  print(st);
                  Logger()
                    ..f(e)
                    ..f(st);
                  developer.log(e.toString());
                  developer.log(st.toString());
                  showDialog(
                      context: context, builder: (context) => Text('$e\n$st'));
                  rethrow;
                }
              },
              text: 'Sign in with Google',
            ),
            const SizedBox(height: 8),
            Bobble(
              child: Text(
                '☝️',
                style: RoastAppTheme.materialTheme.textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
