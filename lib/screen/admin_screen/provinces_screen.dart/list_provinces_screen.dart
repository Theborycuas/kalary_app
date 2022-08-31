import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/admin_screen/provinces_screen.dart/create_provinces_screen.dart';

import '../../../witgets/text_form.dart';

class ListProvincesScreen extends StatefulWidget {
  ListProvincesScreen({Key? key}) : super(key: key);

  @override
  State<ListProvincesScreen> createState() => _ListProvincesScreenState();
}

class _ListProvincesScreenState extends State<ListProvincesScreen> {
  FirebaseFirestore provinces = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Provincias'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: provinces.collection('provinces_db').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot provincesSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    title: Text(
                      provincesSnapshot['province_name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(provincesSnapshot['province_region']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                actualizarProvincia(context, provincesSnapshot);
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                deleteProvinces(provincesSnapshot);
                              },
                              icon: Icon(Icons.delete))
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
        child: const Icon(
          Icons.plus_one,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateProvincesScreen()));
        },
      ),
    );
  }

  //ACTUALIZAR PROVINCIA
  Future<void> actualizarProvincia(
    BuildContext context,
    DocumentSnapshot provinceSnapshot,
  ) {
    FirebaseFirestore provinces = FirebaseFirestore.instance;

    final TextEditingController nameProvinceControler =
        TextEditingController(text: provinceSnapshot['province_name']);
    String dropdownState = provinceSnapshot['province_state'];
    String dropdownRegion = provinceSnapshot['province_region'];

    return showDialog(
        context: context,
        builder: (BuildContext contex) {
          return AlertDialog(
            title: Center(child: Text('Editar Provincia')),
            content: Container(
              height: 350,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  ///NAME
                  TextFormGlobalScreen(
                    controller: nameProvinceControler,
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
                    child: Text('Estado de la Provincia'),
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
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text('Region de la Provincia'),
                  ),
                  Center(
                    child: DropdownButton(
                        items: <String>[
                          'Costa',
                          'Sierra',
                          'Amazonía',
                          'Insular'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                        elevation: 15,
                        value: dropdownRegion,
                        onChanged: (String? valueState) {
                          setState(() {
                            dropdownRegion = valueState!;
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      child: const Text('Guardar'),
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 70,
                            vertical: 12,
                          )),
                      onPressed: () {
                        if (nameProvinceControler.text == 'null') {
                        } else {
                          provinces
                              .collection('provinces_db')
                              .doc(provinceSnapshot.id)
                              .set({
                            'province_name': nameProvinceControler.text,
                            'province_state': dropdownState.toString(),
                            'province_region': dropdownRegion.toString()
                          });
                          nameProvinceControler.text = '';
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListProvincesScreen()));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> deleteProvinces(DocumentSnapshot provinceSnapshot) async {
    FirebaseFirestore provinces = FirebaseFirestore.instance;
    await provinces
        .collection('provinces_db')
        .doc(provinceSnapshot.id)
        .delete();
  }
}
