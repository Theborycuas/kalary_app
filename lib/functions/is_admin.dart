import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screen/home_sreen/home_page_sceen.dart';

authorizeAccess(BuildContext context) {
  //BUSCAR ID DE USUARIO LOGUEADO
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  String? idUserLogin = user?.uid;

  final userSnapshot = FirebaseFirestore.instance;

  final docRef = userSnapshot.collection("users_db").doc(idUserLogin);

  docRef.get().then(
    (DocumentSnapshot userSnapshot) {
      final dataUserLogin = userSnapshot.data() as Map<String, dynamic>;
      if (dataUserLogin['role'] == 'admin') {}
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePageScreen(
                    dataUserLogin: dataUserLogin,
                    userSnapshot: userSnapshot,
                  )));

      return userSnapshot;
    },
    onError: (e) => print("Error getting document: $e"),
  );
}
