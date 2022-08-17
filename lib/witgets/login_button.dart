import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/users_screen/list_user_screen.dart';
import 'package:kalary_app/theme/app_theme.dart';

import '../functions/login_functions.dart';

class ButtonGlobalScreen extends StatelessWidget {
  ButtonGlobalScreen({Key? key, required this.email, required this.password})
      : super(key: key);
  final String email;
  final String password;

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print('NO EXISTE USUARIO PARA ESTE EMAIL');
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        User? user = await loginUsingEmailPassword(
            email: email, password: password, context: context);
        print(user);
        if (user != null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ListUserScreen()));
        }

        //LISTA DE USUARIOS
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => ListUserScreen()));
        print('Login');
      },
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
            ]),
        child: const Text(
          'Iniciar Sesión',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
