import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_sreen/home_page_sceen.dart';
import 'login_screen.dart';

class ReplaceSplashScreen extends StatefulWidget {
  ReplaceSplashScreen({Key? key, required this.dataUserLogin})
      : super(key: key);
  Map<String, dynamic> dataUserLogin;

  @override
  State<ReplaceSplashScreen> createState() => _ReplaceSplashScreenState();
}

class _ReplaceSplashScreenState extends State<ReplaceSplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    readUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data != null) {
            return HomePageScreen(
              dataUserLogin: widget.dataUserLogin,
            );
          } else {
            return LoginScreen();
          }
        });
  }

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
}
