import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInService {
  Future<void> signIn() async {
    final googleSignIn = GoogleSignIn(
      clientId: Platform.isIOS
          ? '476682855230-povgmevit3agcfchqgthgqafp38igtep.apps.googleusercontent.com'
          : null,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
