import 'package:flutter/material.dart';

class AppBarHomePageScreen extends StatefulWidget {
  const AppBarHomePageScreen({Key? key}) : super(key: key);

  @override
  State<AppBarHomePageScreen> createState() => _AppBarHomePageScreenState();
}

class _AppBarHomePageScreenState extends State<AppBarHomePageScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var item = [
      pageIndex == 0 ? Icons.close : Icons.check,
      pageIndex == 1 ? Icons.free_breakfast : Icons.cell_wifi_sharp,
      pageIndex == 2 ? Icons.phone : Icons.phone_android,
      pageIndex == 3 ? Icons.open_in_browser : Icons.close_fullscreen
    ];
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
          children: List.generate(item.length, (index) {
        return IconButton(
            onPressed: () {
              setState(() {
                pageIndex = index;
              });
            },
            icon: Icon(item[index]));
      })),
    );
  }
}
