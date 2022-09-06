import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/admin_screen/places_sceen/list_places_screen.dart';
import 'package:kalary_app/witgets/text_form.dart';

class CreatePlacesScreen extends StatefulWidget {
  CreatePlacesScreen({Key? key}) : super(key: key);

  @override
  State<CreatePlacesScreen> createState() => _CreatePlacesScreenState();
}

class _CreatePlacesScreenState extends State<CreatePlacesScreen> {
  FirebaseFirestore generalInstance = FirebaseFirestore.instance;

  final TextEditingController namePlaceController = TextEditingController();
  final TextEditingController descriptionPlaceController =
      TextEditingController();
  final TextEditingController locationPlaceController = TextEditingController();

  String dropdownState = "Activo";
  String? dropdownCity;
  String? dropdownCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CREAR SITIO'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  hint: const Center(
                                      child: Text('Seleccione una Ciudad')),
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
                    dropdownColor: const Color.fromARGB(255, 207, 207, 207),
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
                    hint: const Center(
                      child: Text('Selecione un Estado'),
                    ),
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
                                      .map((DocumentSnapshot documentCat) {
                                    return DropdownMenuItem<String>(
                                        value: documentCat.id.toString(),
                                        child: Center(
                                          child:
                                              Text(documentCat.id.toString()),
                                        ));
                                  }).toList(),
                                  elevation: 15,
                                  value: dropdownCategory,
                                  isExpanded: true,
                                  hint: const Center(
                                    child: Text('Selecione una Categoría'),
                                  ),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                    ),
                    onPressed: () {
                      if (namePlaceController == null) {
                      } else {
                        generalInstance
                            .collection('places_db')
                            .doc(namePlaceController.text)
                            .set({
                          'place_name': namePlaceController.text,
                          'place_city': dropdownCity.toString(),
                          'place_location': locationPlaceController.text,
                          'place_state': dropdownState.toString(),
                          'place_category': dropdownCategory.toString(),
                          'place_description': descriptionPlaceController.text
                        });
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListPlacesScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
