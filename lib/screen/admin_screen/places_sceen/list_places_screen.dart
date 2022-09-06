import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/admin_screen/places_sceen/create_places.dart';

import '../../../witgets/text_form.dart';

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
                    subtitle: Text(placesSnapshot['place_city']),
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
    FirebaseFirestore generalInstance = FirebaseFirestore.instance;
    TextEditingController namePlaceController =
        TextEditingController(text: placeSnapshot['place_name']);
    TextEditingController descriptionPlaceController =
        TextEditingController(text: placeSnapshot['place_description']);
    TextEditingController locationPlaceController =
        TextEditingController(text: placeSnapshot['place_location']);

    String dropdownState = placeSnapshot['place_state'];
    String? dropdownCity = placeSnapshot['place_city'];
    String? dropdownCategory = placeSnapshot['place_category'];

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text('Editar Lugar'),
            ),
            content: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: 400,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Nombre',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormGlobalScreen(
                          controller: namePlaceController,
                          text: 'Ingrese el nombre del Sitio',
                          textInputType: TextInputType.name,
                          obscure: false,
                          icon: Icons.mode_night_outlined,
                          textCap: TextCapitalization.words,
                          maxlines: 1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Ciudad',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Row(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                  stream: generalInstance
                                      .collection('cities_db')
                                      .snapshots(),
                                  builder: (context, citySnapshot) {
                                    if (citySnapshot.hasData) {
                                      return Expanded(
                                        flex: 4,
                                        child: DropdownButton(
                                          items: citySnapshot.data!.docs.map(
                                              (DocumentSnapshot documents) {
                                            return DropdownMenuItem<String>(
                                              value: documents.id.toString(),
                                              child: Center(
                                                  child: Text(
                                                      documents.id.toString())),
                                            );
                                          }).toList(),
                                          elevation: 15,
                                          onChanged: (String? value) {
                                            setState(() {
                                              dropdownCity = value!;
                                            });
                                          },
                                          value: dropdownCity,
                                          isExpanded: true,
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Link del Maps',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormGlobalScreen(
                            controller: locationPlaceController,
                            text: 'Ingrese el Link del Maps del Sitio',
                            textInputType: TextInputType.url,
                            obscure: false,
                            icon: Icons.place,
                            textCap: TextCapitalization.none,
                            maxlines: 1),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Estado del Sitio',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: DropdownButton(
                            borderRadius: const BorderRadius.horizontal(),
                            dropdownColor:
                                const Color.fromARGB(255, 207, 207, 207),
                            items: <String>['Activo', 'No Activo']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem(
                                child: Center(
                                  child: Text(value),
                                ),
                                value: value,
                              );
                            }).toList(),
                            elevation: 15,
                            value: dropdownState,
                            isExpanded: true,
                            onChanged: (String? valueState) {
                              setState(() {
                                dropdownState = valueState!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Categoría del Sitio',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Row(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                  stream: generalInstance
                                      .collection('categories_db')
                                      .snapshots(),
                                  builder: (context, categorySnapshot) {
                                    if (categorySnapshot.hasData) {
                                      return Expanded(
                                        flex: 4,
                                        child: DropdownButton(
                                          items: categorySnapshot.data!.docs
                                              .map((DocumentSnapshot
                                                  documentCat) {
                                            return DropdownMenuItem<String>(
                                                value:
                                                    documentCat.id.toString(),
                                                child: Center(
                                                  child: Text(documentCat.id
                                                      .toString()),
                                                ));
                                          }).toList(),
                                          elevation: 15,
                                          value: dropdownCategory,
                                          isExpanded: true,
                                          onChanged: (String? value) {
                                            setState(() {
                                              dropdownCategory = value!;
                                            });
                                          },
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Descripción',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormGlobalScreen(
                            controller: descriptionPlaceController,
                            text: 'Ingrese la Descripción del Sitio',
                            textInputType: TextInputType.name,
                            obscure: false,
                            icon: Icons.description,
                            textCap: TextCapitalization.none,
                            maxlines: 5),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            child: const Text('Guardar'),
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              onPrimary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 12),
                            ),
                            onPressed: () {
                              if (namePlaceController == null) {
                              } else {
                                generalInstance
                                    .collection('places_db')
                                    .doc(placeSnapshot.id)
                                    .set({
                                  'place_name': namePlaceController.text,
                                  'place_city': dropdownCity.toString(),
                                  'place_location':
                                      locationPlaceController.text,
                                  'place_state': dropdownState.toString(),
                                  'place_category': dropdownCategory.toString(),
                                  'place_description':
                                      descriptionPlaceController.text
                                });
                              }
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  Future<void> deleteSitios(DocumentSnapshot placeSnapshot) async {
    FirebaseFirestore places = FirebaseFirestore.instance;
    await places.collection('places_db').doc(placeSnapshot.id).delete();
  }
}
