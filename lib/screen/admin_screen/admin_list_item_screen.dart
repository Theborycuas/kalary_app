import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/admin_screen/categories_screen/list_categories_screen.dart';
import 'package:kalary_app/screen/admin_screen/cities_screen/list_cities.dart';
import 'package:kalary_app/screen/admin_screen/places_sceen/list_places_screen.dart';
import 'package:kalary_app/screen/admin_screen/provinces_screen.dart/list_provinces_screen.dart';
import 'package:kalary_app/screen/users_screen/list_user_screen.dart';

class AdminListItemWidget extends StatefulWidget {
  AdminListItemWidget({Key? key}) : super(key: key);

  @override
  State<AdminListItemWidget> createState() => _AdminListItemWidgetState();
}

class _AdminListItemWidgetState extends State<AdminListItemWidget> {
  FirebaseFirestore generalInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 5,
                  width: 50,
                  child: Divider(
                    color: Colors.black,
                  )),
              const SizedBox(
                width: 50,
              ),
              Container(
                  height: 5,
                  width: 50,
                  child: Divider(
                    color: Colors.black,
                  )),
              const SizedBox(
                width: 50,
              ),
              Container(
                  height: 5,
                  width: 50,
                  child: Divider(
                    color: Colors.black,
                  )),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                  stream: generalInstance.collection('users_db').snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> userSnapshot) {
                    if (userSnapshot.hasData) {
                      return MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListUserScreen()),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              userSnapshot.data!.docs.length.toString(),
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            const Text(
                              'Usuarios',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              buildDivider(),
              StreamBuilder(
                  stream:
                      generalInstance.collection('categories_db').snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> categorySnapshot) {
                    if (categorySnapshot.hasData) {
                      return MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ListCategoriesScreen()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              categorySnapshot.data!.docs.length.toString(),
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            const Text(
                              'Categorías',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              buildDivider(),
              MaterialButton(
                onPressed: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      '150',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Etiquetas',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 5,
                  width: 50,
                  child: Divider(
                    color: Colors.black,
                  )),
              const SizedBox(
                width: 50,
              ),
              Container(
                  height: 5,
                  width: 50,
                  child: Divider(
                    color: Colors.black,
                  )),
              const SizedBox(
                width: 50,
              ),
              Container(
                  height: 5,
                  width: 50,
                  child: const Divider(
                    color: Colors.black,
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                  stream: generalInstance.collection('places_db').snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> placeSnapshot) {
                    if (placeSnapshot.hasData) {
                      return MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListPlacesScreen()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              placeSnapshot.data!.docs.length.toString(),
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            const Text(
                              'Sitios',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              buildDivider(),
              StreamBuilder(
                  stream: generalInstance.collection('cities_db').snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> citySnapshot) {
                    if (citySnapshot.hasData) {
                      return MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListCitiesScreen()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              citySnapshot.data!.docs.length.toString(),
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            const Text(
                              'Ciudades',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
              buildDivider(),
              StreamBuilder(
                  stream:
                      generalInstance.collection('provinces_db').snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> provinceSnapshot) {
                    if (provinceSnapshot.hasData) {
                      return MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListProvincesScreen()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              provinceSnapshot.data!.docs.length.toString(),
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            const Text(
                              'Provincias',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }

  void viewProvinces(BuildContext context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ListProvincesScreen()));
  }

  Widget buildButton(
      BuildContext context, String value, String text, VoidCallback onClicked) {
    return MaterialButton(
      onPressed: onClicked,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Container(
        height: 30,
        child: VerticalDivider(
          color: Colors.black,
        ));
  }
}
