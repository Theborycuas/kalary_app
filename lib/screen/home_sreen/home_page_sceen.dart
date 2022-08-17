import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kalary_app/screen/home_sreen/explore_page_screen.dart';
import 'package:kalary_app/screen/users_screen/profile_user_screen.dart';
import 'package:kalary_app/theme/app_theme.dart';
import 'package:kalary_app/witgets/app_bar_home_page.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({Key? key, this.userSnapshot, required this.dataUserLogin})
      : super(key: key);

  DocumentSnapshot? userSnapshot;
  Map<String, dynamic> dataUserLogin;

  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: getAppBar(context, dataUserLogin),
      ),
      body: streamBuilderUser(context),
    );
  }

  Widget streamBuilderUser(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String? idUserLogin = user?.uid;
    final userSnapshot = FirebaseFirestore.instance;

    return StreamBuilder<DocumentSnapshot>(
      stream: userSnapshot
          .collection('users_db')
          .doc(idUserLogin)
          .snapshots(), //build connection
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          //print(logger);
          return Center(
            child: Column(
              children: const [
                SizedBox(
                  height: 285.0,
                ),
                Text('KLARY'),
                SizedBox(
                  height: 15.0,
                ),
                CupertinoActivityIndicator(),
              ],
            ),
          );
        }
        return getBody(dataUserLogin);
      },
    );
  }

  Widget getBody(final Map<String, dynamic>? dataUser) {
    return IndexedStack(
      index: pageIndex,
      children: [
        ExplorePage(),
        ExplorePage(),
        ExplorePage(),
        ExplorePage(),
      ],
    );
  }

  Widget getAppBar(BuildContext context, Map<String, dynamic> data) {
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
      // pageIndex == 3
      //     ? "assets/img/account_active_icon.svg"
      //     : "assets/img/account_icon.svg",
    ];

    final photoUser = NetworkImage(
        'https://firebasestorage.googleapis.com/v0/b/klary-bd657.appspot.com/o/WithOutUser.png?alt=media&token=29347eaa-61da-4f9b-849d-d5e4aef346fb');
    final photowithoutUser = NetworkImage(
        'https://firebasestorage.googleapis.com/v0/b/klary-bd657.appspot.com/o/WithOutUser.png?alt=media&token=29347eaa-61da-4f9b-849d-d5e4aef346fb');

    var index = 0;

    return AppBar(
      //QUITAR BOTON ATRAS DEL APPBAR
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            onPressed: () {
              index == 0;
            },
            icon: pageIndex == 0
                ? SvgPicture.asset('assets/img/explore_active_icon.svg')
                : SvgPicture.asset('assets/img/explore_icon.svg'),
            color: Color.fromARGB(255, 107, 107, 107),
          ),
          IconButton(
            onPressed: () {
              index == 1;
            },
            icon: pageIndex == 0
                ? SvgPicture.asset('assets/img/likes_active_icon.svg')
                : SvgPicture.asset('assets/img/likes_icon.svg'),
            color: Color.fromARGB(255, 107, 107, 107),
          ),
          IconButton(
            onPressed: () {
              index == 2;
            },
            icon: pageIndex == 0
                ? SvgPicture.asset('assets/img/chat_active_icon.svg')
                : SvgPicture.asset('assets/img/chat_icon.svg'),
            color: Color.fromARGB(255, 107, 107, 107),
          ),
          InkWell(
            child: CircleAvatar(
              maxRadius: 20,
              backgroundImage:
                  data['photo'] != 'null' ? photoUser : photowithoutUser,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileUserScreen(
                            data: data,
                          )));
            },
          )
        ]),
      ),
    );
  }
}
