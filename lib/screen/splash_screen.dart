import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalary_app/screen/list_user_screen.dart';
import 'package:kalary_app/screen/login_screen.dart';
import 'package:kalary_app/screen/users_screen/profile_user_screen.dart';
import 'package:kalary_app/theme/app_theme.dart';

import 'home_page_sceen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key, this.dataUserLogin}) : super(key: key);
  Map<String, dynamic>? dataUserLogin;

  Future readUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String? idUserLogin = user?.uid;
    final docUser =
        FirebaseFirestore.instance.collection('users_db').doc(idUserLogin);
    final userSnapshot = await docUser.get();
    dataUserLogin = userSnapshot.data();
    print(dataUserLogin);
    return dataUserLogin;
  }

  Widget _getLoadingPage() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          readUser();

          if (snapshot.data != null) {
            return HomePageScreen(
              data: dataUserLogin,
            );
          } else {
            return LoginScreen();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(() => _getLoadingPage());
    });
    return Scaffold(
      //backgroundColor: AppTheme.primary,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          AppTheme.primary,
          Colors.white,
        ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: Text(
                'BIENVENIDO A',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Image(
                image: AssetImage('assets/img/logokalary.png'),
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Center(
              child: Text(
                "K'LARY",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
