import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../functions/signOut.dart';

AppBar buildAppBar(BuildContext context) {
  const icon = CupertinoIcons.arrow_right_to_line;
  return AppBar(
    leading: const BackButton(
      color: Colors.black,
    ),
    backgroundColor: const Color.fromARGB(0, 216, 216, 216),
    elevation: 0,
    actions: [
      IconButton(
        onPressed: () {
          signOut(context);
        },
        icon: const Icon(icon, color: Colors.red),
      )
    ],
  );
}
