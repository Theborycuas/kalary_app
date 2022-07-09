import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalary_app/screen/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 15), () {
      Get.to(LoginScreen());
    });
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              'BIENVENIDOS A',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Image(
              image: AssetImage('assets/img/logokalary.png'),
              width: 200,
              height: 200,
            ),
          ),
          Center(
            child: Text(
              'K LARY',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
