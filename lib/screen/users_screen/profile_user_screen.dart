import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../witgets/appbar_user_profile.dart';
import '../../witgets/button_widget_profile.dart';
import '../../witgets/numbersWidget.dart';
import '../../witgets/profile_widget.dart';
import '../../witgets/text_form.dart';

class ProfileUserScreen extends StatelessWidget {
  const ProfileUserScreen({Key? key, this.data}) : super(key: key);
  final Map<String, dynamic>? data;

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
            data: data,
            onClicked: () async {},
          ),
          const SizedBox(
            height: 24,
          ),
          buildAtributes(context, data),
        ],
      ),
    );
  }

  Widget buildUpgradeButton(BuildContext context, Map<String, dynamic>? data) {
    return ButtonWidget(
        text: 'EDITAR PERFIL',
        onClicked: () {
          //BUSCAR ID DE USUARIO LOGUEADO
          // final FirebaseAuth auth = FirebaseAuth.instance;
          // final User? user = auth.currentUser;
          // final String? id = user?.uid;

          upgradeUser(context, data);

          // print(id.toString());
        });
  }

  Widget buildAtributes(BuildContext context, Map<String, dynamic>? data) {
    // final data = userSnapshot.data() as Map<String, dynamic>;

    return Column(
      children: [
        Text(
          data!['name'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          data['email'],
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        const NumbersWidget(),
        const SizedBox(
          height: 25,
        ),
        const Text(
          'Teléfono',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          data['phone'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Edad',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          data['age'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Cumpleaños',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          data['birthday'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Genero',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          data['gen'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: buildUpgradeButton(context, data),
        ),
      ],
    );
  }

  Future upgradeUser(BuildContext context, Map<String, dynamic>? data) {
    // final data = userSnapshot.data() as Map<String, dynamic>;
    final firebase = FirebaseFirestore.instance;

    final TextEditingController nameController =
        TextEditingController(text: data!['name']);
    final TextEditingController phoneController =
        TextEditingController(text: data['phone']);
    final TextEditingController ageController =
        TextEditingController(text: data['age']);
    final TextEditingController birthdayController =
        TextEditingController(text: data['birthday']);
    final TextEditingController genController =
        TextEditingController(text: data['gen']);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text('EDITAR INFORMACIÓN')),
            content: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  height: 410,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      ///EMAIL
                      TextFormGlobalScreen(
                        controller: nameController,
                        text: 'Nombres',
                        textInputType: TextInputType.name,
                        obscure: false,
                        icon: Icons.person,
                        textCap: TextCapitalization.words,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      ///EMAIL
                      TextFormGlobalScreen(
                        controller: phoneController,
                        text: 'Teléfono',
                        textInputType: TextInputType.phone,
                        obscure: false,
                        icon: Icons.phone,
                        textCap: TextCapitalization.none,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      ///EMAIL
                      TextFormGlobalScreen(
                        controller: ageController,
                        text: 'Edad',
                        textInputType: TextInputType.name,
                        obscure: false,
                        icon: Icons.email,
                        textCap: TextCapitalization.none,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormGlobalScreen(
                        controller: birthdayController,
                        text: 'Cumpleaños',
                        textInputType: TextInputType.name,
                        obscure: false,
                        icon: Icons.email,
                        textCap: TextCapitalization.none,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormGlobalScreen(
                        controller: genController,
                        text: 'Genero',
                        textInputType: TextInputType.name,
                        obscure: false,
                        icon: Icons.email,
                        textCap: TextCapitalization.none,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          //REGISTRO DE USUARIOS
                          firebase
                              .collection('users_db')
                              .doc(data['id'])
                              .update({
                            'name': nameController.text,
                            'phone': phoneController.text,
                            'age': ageController.text,
                            'birthday': birthdayController.text,
                            'gen': genController.text,
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10)
                              ]),
                          child: const Text(
                            'Actalizar',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
