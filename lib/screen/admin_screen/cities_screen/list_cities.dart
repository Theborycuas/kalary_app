import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/admin_screen/cities_screen/create_cities_screen.dart';

import '../../../witgets/text_form.dart';

class ListCitiesScreen extends StatefulWidget {
  ListCitiesScreen({Key? key}) : super(key: key);

  @override
  State<ListCitiesScreen> createState() => _ListCitiesScreenState();
}

class _ListCitiesScreenState extends State<ListCitiesScreen> {
  FirebaseFirestore cities = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Ciudades'),
      ),
      body: StreamBuilder(
          stream: cities.collection('cities_db').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot citiesSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(
                        citiesSnapshot['city_name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(citiesSnapshot['city_state']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                actualizarCiudades(context, citiesSnapshot);
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteCities(citiesSnapshot);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
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
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateCitiesScreen()),
          );
        },
      ),
    );
  }

  actualizarCiudades(BuildContext context, DocumentSnapshot citySnapshot) {
    FirebaseFirestore cityInstance = FirebaseFirestore.instance;

    TextEditingController nameCitiesControler =
        TextEditingController(text: citySnapshot['city_name']);
    String dropdownState = citySnapshot['city_state'];
    String dropdownProvince = citySnapshot['city_province'];

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text('Editar Ciudad')),
            //StatefulBuilder ACTUALIZA EL ESTADO DEL ALERTDIALOG
            content: StatefulBuilder(builder: ((context, setState) {
              return Container(
                height: 350,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    ///NAME
                    TextFormGlobalScreen(
                      controller: nameCitiesControler,
                      text: 'Nombres',
                      textInputType: TextInputType.name,
                      obscure: false,
                      icon: Icons.map,
                      textCap: TextCapitalization.words,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text('Provincia'),
                    ),
                    Center(
                      child: Container(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: cityInstance
                                .collection('provinces_db')
                                .snapshots(),
                            builder: (context, citiesSnapshot) {
                              if (citiesSnapshot.hasData) {
                                return Expanded(
                                  child: DropdownButton(
                                    items: citiesSnapshot.data!.docs
                                        .map((DocumentSnapshot documents) {
                                      return DropdownMenuItem<String>(
                                        value: documents.id.toString(),
                                        child: Center(
                                          child: Text(documents.id.toString()),
                                        ),
                                      );
                                    }).toList(),
                                    elevation: 5,
                                    isExpanded: false,
                                    value: dropdownProvince,
                                    onChanged: (String? valueState) {
                                      setState(() {
                                        dropdownProvince = valueState!;
                                      });
                                    },
                                    hint: const Center(
                                      child: Text('Seleccione una Opción'),
                                    ),
                                  ),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text('Estado '),
                    ),
                    Center(
                      child: DropdownButton(
                          items: <String>['Activo', 'No Activo']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          elevation: 15,
                          value: dropdownState,
                          onChanged: (String? valueState) {
                            setState(() {
                              dropdownState = valueState!;
                            });
                          }),
                    ),
                    Center(
                      child: ElevatedButton(
                        child: const Text('Guardar'),
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            onPrimary: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 70, vertical: 12)),
                        onPressed: () {
                          if (nameCitiesControler.text == 'null') {
                          } else {
                            cityInstance
                                .collection('cities_db')
                                .doc(citySnapshot.id)
                                .set({
                              'city_name': nameCitiesControler.text,
                              'city_province': dropdownProvince.toString(),
                              'city_state': dropdownState.toString()
                            });
                            //VALIDAR
                            Navigator.pop(context);
                          }
                        },
                      ),
                    )
                  ],
                ),
              );
            })),
          );
        });
  }

  Future<void> deleteCities(DocumentSnapshot citiesSnapshot) async {
    FirebaseFirestore cities = FirebaseFirestore.instance;
    await cities.collection('cities_db').doc(citiesSnapshot.id).delete();
  }
}
