import 'package:behmor_roast/src/sign_in/services/sign_in_service.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in to Behmor Roast'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            SignInService().signIn();
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}
