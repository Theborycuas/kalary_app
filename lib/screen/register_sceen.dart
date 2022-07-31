import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../witgets/login_button.dart';
import '../witgets/social_icon_login.dart';
import '../witgets/text_form.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confpasswordController = TextEditingController();

  final firebase = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future userRegister() async {
    try {
      await firebase.collection('users_db').doc().set({
        'name': nameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'password': passwordController.text
      });

      auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      //VACIAR CAMPOS
      nameController.text = "";
      phoneController.text = "";
      emailController.text = "";
      passwordController.text = "";
      confpasswordController.text = "";
    } catch (e) {
      print('ERRROR.... ' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              // FadeInImage(
              //   image: NetworkImage(
              //       'https://marketing4ecommerce.net/wp-content/uploads/2018/01/Depositphotos_3667865_m-2015-compressor.jpg'),
              //   placeholder: const AssetImage('assets/img/jar-loading.gif'),
              //   width: double.infinity,
              //   height: 190.00,
              //   fit: BoxFit.cover,
              //   fadeInDuration: const Duration(milliseconds: 300),
              // ),
              Container(
                alignment: Alignment.center,
                child: const Image(
                  image: AssetImage('assets/img/logokalary.png'),
                  width: 110,
                  height: 110,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  "K'LARY",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'Regístrate',
                  style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
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

              ///Password
              TextFormGlobalScreen(
                controller: passwordController,
                text: 'Contraseña',
                textInputType: TextInputType.visiblePassword,
                obscure: true,
                icon: Icons.password,
                textCap: TextCapitalization.none,
              ),
              const SizedBox(
                height: 10,
              ),

              ///Password
              TextFormGlobalScreen(
                controller: confpasswordController,
                text: 'Confirmar Contraseña',
                textInputType: TextInputType.visiblePassword,
                obscure: true,
                icon: Icons.password,
                textCap: TextCapitalization.none,
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  //REGISTRO DE USUARIOS

                  userRegister();
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
        )),
      ),
    );
  }
}
