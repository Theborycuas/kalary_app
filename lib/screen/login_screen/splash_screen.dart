import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalary_app/screen/users_screen/list_user_screen.dart';
import 'package:kalary_app/screen/users_screen/profile_user_screen.dart';
import 'package:kalary_app/theme/app_theme.dart';

import '../admin_screen/admin_page_screen.dart';
import '../home_sreen/home_page_sceen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key, required this.dataUserLogin}) : super(key: key);
  Map<String, dynamic> dataUserLogin;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future readUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String? idUserLogin = user?.uid;
    final docUser =
        FirebaseFirestore.instance.collection('users_db').doc(idUserLogin);
    DocumentSnapshot<Map<String, dynamic>> userSnapshot;
    userSnapshot = await docUser.get();
    widget.dataUserLogin = userSnapshot.data()!;
    print(widget.dataUserLogin);
    return widget.dataUserLogin;
  }

  @override
  void initState() {
    // TODO: implement initState
    readUser();
  }

  Widget _getLoadingPage() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data != null) {
            return AdminPageScreen();
          } else {
            return LoginScreen();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
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
