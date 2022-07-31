import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/register_sceen.dart';
import 'package:kalary_app/theme/app_theme.dart';
import 'package:kalary_app/witgets/login_button.dart';
import 'package:kalary_app/witgets/social_icon_login.dart';

import '../witgets/text_form.dart';
import 'list_user_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print('NO EXISTE USUARIO PARA ESTE EMAIL');
      }
    }
    return user;
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ///Password
                    TextFormGlobalScreen(
                      controller: passwordController,
                      text: 'Password',
                      textInputType: TextInputType.visiblePassword,
                      obscure: true,
                      icon: Icons.password,
                      textCap: TextCapitalization.words,
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
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => ListUserScreen()));
                        } else {
                          print('NO SE ENCONTRO EL USUARIO');
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
              const SocialIconLoginScreen()
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
