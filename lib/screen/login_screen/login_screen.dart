import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kalary_app/functions/login_functions.dart';
import 'package:kalary_app/screen/login_screen/register_user_sceen.dart';
import 'package:kalary_app/theme/app_theme.dart';
import 'package:kalary_app/witgets/login_button.dart';
import 'package:kalary_app/witgets/social_icon_login.dart';

import '../../witgets/text_form.dart';
import '../home_sreen/home_page_sceen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          // decoration: const BoxDecoration(
          //     gradient: LinearGradient(colors: [
          //   Colors.white,
          //   Color.fromARGB(255, 200, 233, 255),
          // ])),
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
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
                height: 30,
              ),

              ///EMAIL
              Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: Column(children: [
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                            color: AppTheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormGlobalScreen(
                      controller: emailController,
                      text: 'Email',
                      textInputType: TextInputType.emailAddress,
                      obscure: false,
                      icon: Icons.email,
                      textCap: TextCapitalization.none,
                      maxlines: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ///Password
                    Container(
                      height: 55,
                      padding: const EdgeInsets.only(top: 3, left: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 7)
                          ]),
                      child: TextFormField(
                        onChanged: ((value) {
                          print(value);
                        }),
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            hintText: 'Contraseña',
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  passwordVisible
                                      ? passwordVisible = false
                                      : passwordVisible = true;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(15),
                            hintStyle: const TextStyle(
                              height: 1,
                            )),
                        obscureText: passwordVisible,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    ///Button

                    InkWell(
                      onTap: () async {
                        User? user = await loginUsingEmailPassword(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context);
                        print(user);
                        if (user != null) {
                          //BUSCAR ID DE USUARIO LOGUEADO
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          final User? user = auth.currentUser;
                          String? idUserLogin = user?.uid;

                          final userSnapshot = FirebaseFirestore.instance;

                          final docRef = userSnapshot
                              .collection("users_db")
                              .doc(idUserLogin);

                          docRef.get().then(
                            (DocumentSnapshot userSnapshot) {
                              final dataUserLogin =
                                  userSnapshot.data() as Map<String, dynamic>;
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

                          // Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(
                          //         builder: (context) => HomePageScreen()));
                        } else {
                          print('NO SE ENCONTRO EL USUARIO');
                          emailController.text = '';
                          passwordController.text = '';
                        }

                        //LISTA DE USUARIOS
                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (context) => ListUserScreen()));
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
                          'Iniciar Sesión',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ]),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              ///Social Login Icon
              SocialIconLoginScreen()
            ],
          ),
        )),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('¿No tienes una cuenta? '),
            InkWell(
              child: const Text(
                'Registrate',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
