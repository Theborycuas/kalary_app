import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../witgets/text_form.dart';

class CreateCitiesScreen extends StatefulWidget {
  const CreateCitiesScreen({Key? key}) : super(key: key);

  @override
  State<CreateCitiesScreen> createState() => _CreateCitiesScreenState();
}

class _CreateCitiesScreenState extends State<CreateCitiesScreen> {
  final TextEditingController nameCityController = TextEditingController();

  var dropdownProvince, selectProvince;
  String dropdownState = "Activo";
  FirebaseFirestore cityInstance = FirebaseFirestore.instance;
  FirebaseFirestore provinceInstance = FirebaseFirestore.instance;

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
          const SizedBox(
            height: 220,
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              'CREAR CIUDAD',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormGlobalScreen(
              controller: nameCityController,
              text: 'Nombre de la provincia',
              textInputType: TextInputType.name,
              obscure: false,
              icon: Icons.map,
              textCap: TextCapitalization.words),
          const SizedBox(
            height: 15,
          ),
          Container(
            alignment: Alignment.center,
            child: Text('Estado de la Ciudad'),
          ),
          const SizedBox(
            height: 20,
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
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Text('Provincia'),
          ),
          StreamBuilder(
              stream: provinceInstance.collection('provinces_db').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamBuilder) {
                if (streamBuilder.hasData) {
                  List currencyItems = [];

                  for (int i = 0; i < streamBuilder.data!.docs.length; i++) {
                    DocumentSnapshot provSnapshot = streamBuilder.data!.docs[i];
                    currencyItems.add(
                      DropdownMenuItem(
                        child: Text(
                          provSnapshot['province_name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        value: provSnapshot['province_name'],
                      ),
                    );
                  }
                  return Row(
                    children: [
                      DropdownButton(
                        items: currencyItems
                            .map<DropdownMenuItem<String>>((Object? value) {
                          return DropdownMenuItem<String>(
                            child: Text(value.toString()),
                            value: value.toString(),
                          );
                        }).toList(),
                        elevation: 15,
                        onChanged: (currenValue) {
                          setState(() {
                            selectProvince = currenValue;
                          });
                        },
                        value: selectProvince,
                        isExpanded: false,
                        hint: Text('Seleccione una Opción'),
                      ),
                    ],
                  );
                } else {
                  return Text("Cargando info");
                }
              })
        ],
      ),
    ))));
  }
}
