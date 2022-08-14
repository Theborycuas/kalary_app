import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kalary_app/screen/home_page_sceen.dart';
import 'package:kalary_app/screen/list_user_screen.dart';
import 'package:kalary_app/theme/app_theme.dart';

import '../functions/login_with_google.dart';

class SocialIconLoginScreen extends StatelessWidget {
  SocialIconLoginScreen({Key? key}) : super(key: key);
  final firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: const Text(
            '- O -',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          alignment: Alignment.center,
          child: const Text(
            'Inicia seción con',
            style:
                TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.2,
          child: Row(
            children: [
              ///GOOGLE
              InkWell(
                onTap: () {
                  print("INICIO SESIÓN CON GOOGLE");
                  LoginWithGoogle().loginUsingGoogle().then((user) {
                    if (user != null) {
                      firebase
                          .collection('users_db')
                          .doc(user.uid.toString())
                          .set({
                        'id': user.uid.toString(),
                        'name': user.displayName.toString(),
                        'phone': user.phoneNumber.toString(),
                        'email': user.email.toString(),
                        'password': user.displayName,
                        'photo': user.photoURL.toString(),
                        'age': "Edad",
                        'birthday': "Cumpleaños",
                        'state': "null",
                        'gen': "Genero",
                      });

                      //BUSCAR ID DE USUARIO LOGUEADO

                      final userSnapshot = FirebaseFirestore.instance;

                      final docRef =
                          userSnapshot.collection("users_db").doc(user.uid);

                      docRef.get().then(
                        (DocumentSnapshot userSnapshot) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePageScreen(
                                        userSnapshot: userSnapshot,
                                      )));
                          return userSnapshot;
                        },
                        onError: (e) => print("Error getting document: $e"),
                      );

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return HomePageScreen(userSnapshot: null);
                      }));
                    } else {
                      print('USUARIO NULO');
                    }
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.23,
                  height: MediaQuery.of(context).size.width * 0.2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        )
                      ]),
                  child: SvgPicture.asset(
                    'assets/img/google.svg',
                    height: 40,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),

              ///FACEBOOK
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          )
                        ]),
                    child: Image.asset(
                      'assets/img/facebookpng.png',
                      width: 40,
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
