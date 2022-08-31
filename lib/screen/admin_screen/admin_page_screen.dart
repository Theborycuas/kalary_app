import 'package:flutter/material.dart';
import 'package:kalary_app/screen/admin_screen/list_item.dart';

class AdminPageScreen extends StatelessWidget {
  const AdminPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PANEL ADMINISTRATIVO'),
        shadowColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Gestion de App',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            ListItemWidget(),
          ],
        ),
      ),
    );
  }
}
