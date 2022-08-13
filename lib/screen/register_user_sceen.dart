import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/functions/signOut.dart';

import '../functions/go_login_page.dart';
import '../theme/app_theme.dart';
import '../witgets/login_button.dart';
import '../witgets/social_icon_login.dart';
import '../witgets/text_form.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confpasswordController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

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

              ///NAME
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

              ///PHONE
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

                  userRegisterwithEmailAndPasword(context);
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

  //REGISTRO EN FIREBASE CON EMAIL & PASSWORD
  Future userRegisterwithEmailAndPasword(BuildContext context) async {
    try {
      auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      loginUsingEmailPassword(
          context: context,
          name: nameController.text,
          phone: phoneController.text,
          email: emailController.text,
          password: passwordController.text);

      //MENSAJE TOAST
      // Fluttertoast.showToast(
      //   msg: 'USUARIO EXITOSO', //Message
      //   toastLength: Toast.LENGTH_SHORT, //Length (Longitud)
      //   gravity: ToastGravity.CENTER, //Location
      //   timeInSecForIosWeb: 2, //Duration
      // );
    } catch (e) {
      print('ERRROR.... ' + e.toString());
    }
  }

  //VACIAR CAMPOS
  void cleanTextField() {
    //VACIAR CAMPOS
    nameController.text = "";
    phoneController.text = "";
    emailController.text = "";
    passwordController.text = "";
    confpasswordController.text = "";

    // final FirebaseAuth auth = FirebaseAuth.instance;
    // final firebase = FirebaseFirestore.instance;
    // final User? user = auth.currentUser;
    // String? userId = user?.uid;

    // await firebase.collection('users_db').doc(userId.toString()).set({
    //   'id': userId.toString(),
    //   'name': nameController.text,
    //   'phone': phoneController.text,
    //   'email': emailController.text,
    //   'password': passwordController.text,
    // });

    // signOut(context);
  }

  // LOGIN PROVISIONAL
  static Future<User?> loginUsingEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final firebase = FirebaseFirestore.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;

      String? userId = user?.uid;
      firebase.collection('users_db').doc(userId.toString()).set({
        'id': userId.toString(),
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      });

      if (user != null) {
        //CERRAR SESION E IR A LOGIN PAGE
        signOut(context);
      } else {
        //USUARIO NO SE REGISTRO
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => RegisterScreen()));
        print('NO SE ENCONTRO EL USUARIO');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print('NO EXISTE USUARIO PARA ESTE EMAIL');
      }
    }
  }
}
