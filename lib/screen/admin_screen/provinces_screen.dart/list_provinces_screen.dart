import 'package:flutter/material.dart';
import 'package:kalary_app/screen/admin_screen/provinces_screen.dart/create_provinces_screen.dart';

class ListProvincesScreen extends StatelessWidget {
  const ListProvincesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ListProvincesScreen'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.create,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateProvincesScreen()));
        },
      ),
    );
  }
}
