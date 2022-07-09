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
                height: 50,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'Logo',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Iniciar Sesión',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 50,
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
                height: 10,
              ),

              ///Social Login Icon
              const SocialIconLoginScreen()
            ],
          ),
        )),
      ),
    );
  }
}
