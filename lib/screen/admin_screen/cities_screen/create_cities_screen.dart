import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/admin_screen/cities_screen/list_cities.dart';

import '../../../witgets/text_form.dart';

class CreateCitiesScreen extends StatefulWidget {
  const CreateCitiesScreen({Key? key}) : super(key: key);

  @override
  State<CreateCitiesScreen> createState() => _CreateCitiesScreenState();
}

class _CreateCitiesScreenState extends State<CreateCitiesScreen> {
  final TextEditingController nameCityController = TextEditingController();

  var dropdownProvince;

  String? selectProvince;
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
            textCap: TextCapitalization.words,
            maxlines: 1,
          ),
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
                isExpanded: true,
                items: <String>['Activo', 'No Activo']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    child: Center(child: Text(value)),
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
          Center(
            child: Row(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream:
                        provinceInstance.collection('provinces_db').snapshots(),
                    builder: (context, provSnapshot) {
                      if (provSnapshot.hasData) {
                        return Expanded(
                          flex: 4,
                          child: DropdownButton(
                            items: provSnapshot.data!.docs
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
                                selectProvince = value!;
                              });
                            },
                            value: selectProvince,
                            isExpanded: true,
                            hint: Center(child: Text('Seleccione una Opción')),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ],
            ),
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
                if (nameCityController == 'null') {
                  //VALIDAR
                } else {}
                cityInstance
                    .collection('cities_db')
                    .doc(nameCityController.text)
                    .set({
                  'city_name': nameCityController.text,
                  'city_province': selectProvince.toString(),
                  'city_state': dropdownState.toString()
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListCitiesScreen()),
                );
              },
            ),
          )
        ],
      ),
    ))));
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// import '../../../witgets/text_form.dart';

// class CreateCitiesScreen extends StatefulWidget {
//   const CreateCitiesScreen({Key? key}) : super(key: key);

//   @override
//   State<CreateCitiesScreen> createState() => _CreateCitiesScreenState();
// }

// class _CreateCitiesScreenState extends State<CreateCitiesScreen> {
//   final TextEditingController nameCityController = TextEditingController();

//   var dropdownProvince;

//   String? selectProvince;
//   String dropdownState = "Activo";

//   FirebaseFirestore cityInstance = FirebaseFirestore.instance;
//   FirebaseFirestore provinceInstance = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//             child: SafeArea(
//                 child: Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 220,
//           ),
//           Container(
//             alignment: Alignment.center,
//             child: const Text(
//               'CREAR CIUDAD',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           TextFormGlobalScreen(
//               controller: nameCityController,
//               text: 'Nombre de la provincia',
//               textInputType: TextInputType.name,
//               obscure: false,
//               icon: Icons.map,
//               textCap: TextCapitalization.words),
//           const SizedBox(
//             height: 15,
//           ),
//           Container(
//             alignment: Alignment.center,
//             child: Text('Estado de la Ciudad'),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Center(
//             child: DropdownButton(
//                 isExpanded: true,
//                 items: <String>['Activo', 'No Activo']
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     child: Center(child: Text(value)),
//                     value: value,
//                   );
//                 }).toList(),
//                 elevation: 15,
//                 value: dropdownState,
//                 onChanged: (String? valueState) {
//                   setState(() {
//                     dropdownState = valueState!;
//                   });
//                 }),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Container(
//             alignment: Alignment.center,
//             child: Text('Provincia'),
//           ),
//           StreamBuilder(
//               stream: provinceInstance.collection('provinces_db').snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> streamBuilder) {
//                 if (streamBuilder.hasData) {
//                   List currencyItems = [];

//                   for (int i = 0; i < streamBuilder.data!.docs.length; i++) {
//                     DocumentSnapshot provSnapshot = streamBuilder.data!.docs[i];
//                     currencyItems.add(
//                       DropdownMenuItem(
//                         child: Text(
//                           provSnapshot['province_name'],
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         value: provSnapshot['province_name'],
//                       ),
//                     );
//                   }
//                   return Center(
//                     child: Row(
//                       children: [
//                         StreamBuilder<QuerySnapshot>(
//                             stream: provinceInstance
//                                 .collection('provinces_db')
//                                 .snapshots(),
//                             builder: (context, provSnapshot) {
//                               if (provSnapshot.hasData) {
//                                 return Expanded(
//                                   flex: 4,
//                                   child: DropdownButton(
//                                     items: provSnapshot.data!.docs
//                                         .map((DocumentSnapshot documents) {
//                                       return DropdownMenuItem<String>(
//                                         value: documents.id.toString(),
//                                         child: Center(
//                                             child:
//                                                 Text(documents.id.toString())),
//                                       );
//                                     }).toList(),
//                                     elevation: 15,
//                                     onChanged: (String? value) {
//                                       setState(() {
//                                         selectProvince = value!;
//                                       });
//                                     },
//                                     value: selectProvince,
//                                     isExpanded: true,
//                                     hint: Center(
//                                         child: Text('Seleccione una Opción')),
//                                   ),
//                                 );
//                               } else {
//                                 return Center(
//                                     child: CircularProgressIndicator());
//                               }
//                             }),
//                       ],
//                     ),
//                   );
//                 } else {
//                   return Text("Cargando info");
//                 }
//               })
//         ],
//       ),
//     ))));
//   }
// }
