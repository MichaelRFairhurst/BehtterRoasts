import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/sign_in/services/sign_in_service.dart';
import 'package:behmor_roast/src/util/widgets/bobble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in to Behmor Roast'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 5,
              child: Text(
                'Welcome to your new roast helper app!',
                style: RoastAppTheme.materialTheme.textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            ),
            const Expanded(
              flex: 2,
              child: Text(
                'To use our app, please sign in. Your roast history will be'
                ' privately saved to your account.',
                textAlign: TextAlign.center,
              ),
            ),
            SignInButton(
              Buttons.Google,
              onPressed: () {
                SignInService().signIn();
              },
              text: 'Sign in with Google',
            ),
            const SizedBox(height: 8),
            Expanded(
              flex: 1,
              child: Bobble(
                child: Text(
                  '☝️',
                  style: RoastAppTheme.materialTheme.textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Expanded(flex: 2, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
