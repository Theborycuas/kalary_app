import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kalary_app/screen/explore_page_screen.dart';
import 'package:kalary_app/theme/app_theme.dart';
import 'package:kalary_app/witgets/app_bar_home_page.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: getAppBar(),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [ExplorePage(), ExplorePage(), ExplorePage(), ExplorePage()],
    );
  }

  Widget getAppBar() {
    var item = [
      pageIndex == 0
          ? "assets/img/explore_active_icon.svg"
          : "assets/img/explore_icon.svg",
      pageIndex == 1
          ? "assets/img/likes_active_icon.svg"
          : "assets/img/likes_icon.svg",
      pageIndex == 2
          ? "assets/img/chat_active_icon.svg"
          : "assets/img/chat_icon.svg",
      pageIndex == 3
          ? "assets/img/account_active_icon.svg"
          : "assets/img/account_icon.svg",
    ];
    return AppBar(
      //QUITAR BOTON ATRAS DEL APPBAR
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(item.length, (index) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    pageIndex = index;
                  });
                },
                icon: SvgPicture.asset(item[index]),
                color: Color.fromARGB(255, 107, 107, 107),
              );
            })),
      ),
    );
  }
}
