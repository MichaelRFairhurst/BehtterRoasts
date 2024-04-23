import 'package:behmor_roast/src/config/theme.dart';
import 'package:behmor_roast/src/sign_in/providers.dart';
import 'package:behmor_roast/src/sign_in/services/sign_in_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignedInDrawer extends ConsumerWidget {
  const SignedInDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value;
    if (user == null) {
      return const Text('not signed in.');
    }

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Currently signed in.',
                style: RoastAppTheme.materialTheme.textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Text('Welcome ${user.displayName}!'),
              const SizedBox(height: 4),
              Text('Email: ${user.email}'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: SignInService().signOut,
                child: const Text('Sign out'),
              ),
              const Spacer(),
              const Text('This app is free and open source. If you enjoy using'
                  ' it, please leave a review or recommend it to others in the'
                  ' roasting community.'),
              const SizedBox(height: 8),
              const Text('Tips appreciated: @Michael-Fairhurst on venmo.'),
              const SizedBox(height: 8),
              const Text(
                  "Issues? Please report so that everyone's experience can be"
                  ' improved.'),
            ],
          ),
        ),
      ),
    );
  }
}
