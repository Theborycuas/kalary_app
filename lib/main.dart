import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalary_app/screen/splash_screen.dart';

Future main() async {
  //INICIALIZAR DB FIREBASE
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //INICIALIZAR DB APP
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalary App',
      home: SplashScreen(),
    );
  }
}
