import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  final icon = CupertinoIcons.moon_stars;
  return AppBar(
    leading: BackButton(
      color: Colors.black,
    ),
    backgroundColor: Color.fromARGB(0, 216, 216, 216),
    elevation: 0,
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          color: Colors.black,
        ),
      )
    ],
  );
}
