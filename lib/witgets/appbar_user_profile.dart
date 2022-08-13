import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../functions/signOut.dart';

AppBar buildAppBar(BuildContext context) {
  final icon = CupertinoIcons.arrow_left_to_line;
  return AppBar(
    leading: BackButton(
      color: Colors.black,
    ),
    backgroundColor: Color.fromARGB(0, 216, 216, 216),
    elevation: 0,
    actions: [
      IconButton(
        onPressed: () {
          signOut(context);
        },
        icon: Icon(
          icon,
          color: Colors.black,
        ),
      )
    ],
  );
}
