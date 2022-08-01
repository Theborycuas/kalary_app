import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginWithGoogle {
  String TAG = "LoginGoogleUtils";
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> loginUsingGoogle() async {
    print(TAG + ", loginUsingGoogle() init...");

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    print(TAG +
        ", loginUsingGoogle() googleUser email -> ${googleSignInAccount?.email}");

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    UserCredential userCredential = await auth.signInWithCredential(credential);

    User? user = userCredential.user;

    return isCurrentSignIn(user!);
  }

  Future<User?> isCurrentSignIn(User user) async {
    if (user != null) {
      assert(await user.getIdToken() != null);
      final User? currentUser = auth.currentUser;
      assert(user.uid == currentUser?.uid);
      log(TAG + ', SignInwhithGoogle Succeeded: $user');
      return user;
    }
    return null;
  }
}
