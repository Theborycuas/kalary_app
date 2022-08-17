import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalary_app/screen/login_screen/splash_screen.dart';

Future main() async {
  //INICIALIZAR DB FIREBASE
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //INICIALIZAR DB APP
  runApp(const KalaryApp());
}

class KalaryApp extends StatelessWidget {
  const KalaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalary App',
      home: SplashScreen(
        dataUserLogin: {},
      ),
    );
  }
}
