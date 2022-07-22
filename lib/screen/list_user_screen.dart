import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/update_sceen.dart';

import '../theme/app_theme.dart';
import '../witgets/text_form.dart';

class ListUserScreen extends StatelessWidget {
  final users = FirebaseFirestore.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confpasswordController = TextEditingController();

  ListUserScreen({
    Key? key,
  }) : super(key: key);

  //ELIMINAR USUARIO
  Future<void> users_delete(String user_id) async {
    await users.collection('users_db').doc(user_id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: users.collection('users_db').snapshots(), //build connection
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length, //number of rows
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(documentSnapshot['name']),
                  subtitle: Text(documentSnapshot['phone'].toString()),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
// Press this button to edit a single product
                        IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () =>
                                _actualizardialog(context, documentSnapshot)),
// This icon button is used to delete a single product
                        IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => users_delete(documentSnapshot.id)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

Future<Null> _actualizardialog(BuildContext context, DocumentSnapshot user) {
  final firebase = FirebaseFirestore.instance;

  final TextEditingController nameController =
      TextEditingController(text: user['name']);
  final TextEditingController phoneController =
      TextEditingController(text: user['phone']);
  final TextEditingController emailController =
      TextEditingController(text: user['email']);

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Usurio'),
          content: Container(
            height: 350,
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
                  controller: emailController,
                  text: 'Email',
                  textInputType: TextInputType.emailAddress,
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
                    firebase.collection('users_db').doc(user.id).update({
                      'name': nameController.text,
                      'phone': phoneController.text,
                      'email': emailController.text,
                    });
                    Navigator.pop(context);
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
                      'Registrarse',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
