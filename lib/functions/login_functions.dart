import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<User?> loginUsingEmailPassword(
    {String? email, String? password, BuildContext? context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.toString(), password: password.toString());
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      print('NO EXISTE USUARIO PARA ESTE EMAIL');
    }
  }
  return user;
}

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
