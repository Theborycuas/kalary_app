import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kalary_app/screen/explore_page_screen.dart';
import 'package:kalary_app/screen/users_screen/profile_user_screen.dart';
import 'package:kalary_app/theme/app_theme.dart';
import 'package:kalary_app/witgets/app_bar_home_page.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key, this.userSnapshot, this.data}) : super(key: key);

  final DocumentSnapshot? userSnapshot;
  final Map<String, dynamic>? data;

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
        child: getAppBar(context, widget.data),
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
        return getBody();
      },
    );
  }

  Widget getBody() {
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

  Widget getAppBar(BuildContext context, final Map<String, dynamic>? data) {
    //BUSCAR ID DE USUARIO LOGUEADO

    // final FirebaseAuth auth = FirebaseAuth.instance;
    // final User? user = auth.currentUser;
    // String? idUserLogin = user?.uid;

    // final userSnapshot = FirebaseFirestore.instance;

    // final docRef = userSnapshot.collection("users_db").doc(idUserLogin);

    // docRef.get().then(
    //   (DocumentSnapshot userSnapshot) {
    //     return userSnapshot;
    //   },
    //   onError: (e) => print("Error getting document: $e"),
    // );

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
                  if (pageIndex == 3) {
                    //BUSCAR ID DE USUARIO LOGUEADO
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final User? user = auth.currentUser;
                    String? idUserLogin = user?.uid;

                    final userSnapshot = FirebaseFirestore.instance;

                    final docRef =
                        userSnapshot.collection("users_db").doc(idUserLogin);

                    docRef.get().then(
                      (DocumentSnapshot userSnapshot) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileUserScreen(
                                      userSnapshot: userSnapshot,
                                    )));
                        return userSnapshot;
                      },
                      onError: (e) => print("Error getting document: $e"),
                    );
                  }
                });
              },
              icon: SvgPicture.asset(item[index]),
              color: Color.fromARGB(255, 107, 107, 107),
            );
          }),
        ),
      ),
    );
  }
}
