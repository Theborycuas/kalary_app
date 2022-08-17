import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'go_login_page.dart';

Future<User?> signOut(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    auth.signOut();

    goLoginPage(context);
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      print('USUARIO NO CERRO LA SESIÓN');
    }
  }
}
