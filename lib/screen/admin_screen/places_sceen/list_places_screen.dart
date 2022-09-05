import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/admin_screen/places_sceen/create_places.dart';

class ListPlacesScreen extends StatefulWidget {
  ListPlacesScreen({Key? key}) : super(key: key);

  @override
  State<ListPlacesScreen> createState() => _ListPlacesScreenState();
}

class _ListPlacesScreenState extends State<ListPlacesScreen> {
  FirebaseFirestore placesInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Sitios'),
      ),
      body: StreamBuilder(
        stream: placesInstance.collection('places_db').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot placesSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    title: Text(
                      placesSnapshot['place_name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(placesSnapshot['pplace_city']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                actualizarSitios(context, placesSnapshot);
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                deleteSitios(placesSnapshot);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.plus_one),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePlacesScreen()),
          );
        },
      ),
    );
  }

  Future<void> actualizarSitios(
      BuildContext context, DocumentSnapshot placeSnapshot) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog();
        });
  }

  Future<void> deleteSitios(DocumentSnapshot placeSnapshot) async {}
}
