import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginGoogle {
  static const String TAG = "LoginGoogle";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  //GOOGLE METHODS
  //SIGNIN WHITH GOOGLE

  // Future<User> signInWithGoogle() async {
  //   log(TAG + ", signInWithGoogle() init...");
  // }

}
