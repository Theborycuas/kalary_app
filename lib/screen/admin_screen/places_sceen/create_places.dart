import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/witgets/text_form.dart';

class CreatePlacesScreen extends StatefulWidget {
  CreatePlacesScreen({Key? key}) : super(key: key);

  @override
  State<CreatePlacesScreen> createState() => _CreatePlacesScreenState();
}

class _CreatePlacesScreenState extends State<CreatePlacesScreen> {
  FirebaseFirestore cityInstace = FirebaseFirestore.instance;

  final TextEditingController namePlaceController = TextEditingController();
  final TextEditingController descriptionPlaceController =
      TextEditingController();
  final TextEditingController locationPlaceController = TextEditingController();

  String dropdownState = "Activo";
  String? dropdownCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'CREAR LUGARES',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormGlobalScreen(
              controller: namePlaceController,
              text: 'Nombre del Sitio',
              textInputType: TextInputType.name,
              obscure: false,
              icon: Icons.mode_night_outlined,
              textCap: TextCapitalization.words,
              maxlines: 1,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Ciudad',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: cityInstace.collection('cities_db').snapshots(),
                      builder: (context, citySnapshot) {
                        if (citySnapshot.hasData) {
                          return Expanded(
                            flex: 4,
                            child: DropdownButton(
                              items: citySnapshot.data!.docs
                                  .map((DocumentSnapshot documents) {
                                return DropdownMenuItem<String>(
                                  value: documents.id.toString(),
                                  child: Center(
                                      child: Text(documents.id.toString())),
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
                              hint:
                                  Center(child: Text('Seleccione una Opción')),
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormGlobalScreen(
                controller: locationPlaceController,
                text: 'Link del Maps del Sitio',
                textInputType: TextInputType.url,
                obscure: false,
                icon: Icons.place,
                textCap: TextCapitalization.none,
                maxlines: 1),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Estado del Sitio',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: DropdownButton(
                borderRadius: BorderRadius.horizontal(),
                dropdownColor: Color.fromARGB(255, 207, 207, 207),
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
            SizedBox(
              height: 20,
            ),
            TextFormGlobalScreen(
                controller: descriptionPlaceController,
                text: 'Descripción del Sitio',
                textInputType: TextInputType.name,
                obscure: false,
                icon: Icons.description,
                textCap: TextCapitalization.words,
                maxlines: 5)
          ],
        ),
      )),
    ));
  }
}
