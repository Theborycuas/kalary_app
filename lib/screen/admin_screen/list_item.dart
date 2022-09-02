import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/admin_screen/cities_screen/list_cities.dart';
import 'package:kalary_app/screen/admin_screen/provinces_screen.dart/list_provinces_screen.dart';

class ListItemWidget extends StatefulWidget {
  ListItemWidget({Key? key}) : super(key: key);

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  FirebaseFirestore generalInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          SizedBox(
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
              SizedBox(
                width: 50,
              ),
              Container(
                  height: 5,
                  width: 50,
                  child: Divider(
                    color: Colors.black,
                  )),
              SizedBox(
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
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                onPressed: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      '24',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Usuarios',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              buildDivider(),
              MaterialButton(
                onPressed: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      '80',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Categorías',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              buildDivider(),
              MaterialButton(
                onPressed: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      '150',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
          SizedBox(
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
              SizedBox(
                width: 50,
              ),
              Container(
                  height: 5,
                  width: 50,
                  child: Divider(
                    color: Colors.black,
                  )),
              SizedBox(
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
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListProvincesScreen()));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      '24',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Sitios',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
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
                                  fontWeight: FontWeight.bold, fontSize: 20),
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
                                  fontWeight: FontWeight.bold, fontSize: 20),
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
