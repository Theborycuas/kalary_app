import 'package:flutter/material.dart';
import 'package:kalary_app/witgets/button.dart';
import 'package:kalary_app/witgets/social_icon_login.dart';

import '../witgets/text_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  width: 150,
                  height: 150,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'K LARY',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Iniciar Sesión',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),

              ///EMAIL
              TextFormGlobalScreen(
                controller: emailController,
                text: 'Email',
                textInputType: TextInputType.emailAddress,
                obscure: false,
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
              ),
              const SizedBox(
                height: 10,
              ),

              ///Button
              const ButtonGlobalScreen(),

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
          children: const [
            Text('¿No tienes una cuenta? '),
            InkWell(
              child: Text(
                'Registrate',
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
