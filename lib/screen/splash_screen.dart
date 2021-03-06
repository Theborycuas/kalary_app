import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalary_app/screen/login_screen.dart';
import 'package:kalary_app/theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 10), () {
      Get.to(() => LoginScreen());
    });
    return Scaffold(
      //backgroundColor: AppTheme.primary,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          AppTheme.primary,
          Colors.white,
        ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: Text(
                'BIENVENIDO A',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Image(
                image: AssetImage('assets/img/logokalary.png'),
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Center(
              child: Text(
                "K'LARY",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
