import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../witgets/appbar_user_profile.dart';
import '../../witgets/button_widget_profile.dart';
import '../../witgets/numbersWidget.dart';
import '../../witgets/profile_widget.dart';

class ProfileUserScreen extends StatelessWidget {
  ProfileUserScreen({Key? key}) : super(key: key);

  // final consulta = FirebaseFirestore.instance
  //     .collection('users_db')
  //     .where('email', isEqualTo: 'borys_jair@hotmail.com')
  //     .get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // SizedBox(
          //   height: 5,
          // ),
          //LLAMAR A UNA FUNCIÓN ONCLIC DESDE OTRO WIDGET
          ProfileWidget(
            onClicked: () async {},
          ),
          const SizedBox(
            height: 24,
          ),
          buildName(),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: buildUpgradeButton(),
          ),
          const SizedBox(
            height: 24,
          ),
          const NumbersWidget(),
          const SizedBox(
            height: 50,
          ),
          buildAtributes(text: "0996588558"),
          const SizedBox(
            height: 24,
          ),
          buildAtributes(text: "24/10/1996"),
          const SizedBox(
            height: 24,
          ),
          buildAtributes(text: "Hombre"),
          const SizedBox(
            height: 24,
          ),
          buildAtributes(text: "Activo"),
        ],
      ),
    );
  }

  Widget buildName() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String? email = user?.email.toString();
    String? name = user?.uid;

    return Column(
      children: [
        Text(
          name.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          email.toString(),
          style: TextStyle(
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  Widget buildUpgradeButton() {
    return ButtonWidget(
        text: 'COPIAR y PEGAR',
        onClicked: () {
          //BUSCAR ID DE USUARIO LOGUEADO
          final FirebaseAuth auth = FirebaseAuth.instance;
          final User? user = auth.currentUser;
          final String? id = user?.uid;

          print(id.toString());
        });
  }

  Widget buildAtributes({required String text}) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}
