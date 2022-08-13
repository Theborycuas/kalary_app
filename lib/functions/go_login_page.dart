import 'package:flutter/material.dart';

import '../screen/login_screen.dart';

Future goLoginPage(BuildContext context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (builder) => LoginScreen()));
}
