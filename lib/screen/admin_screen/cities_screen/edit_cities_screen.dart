// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import '../../../witgets/text_form.dart';

// class EditCitiesScreen extends StatelessWidget {
//   EditCitiesScreen({Key? key, required this.citySnapshot}) : super(key: key);

//   DocumentSnapshot citySnapshot;
  
//   TextEditingController nameCitiesControler =
//       TextEditingController(text: citySnapshot.id.);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Editar '),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 10,
//           ),

//           ///NAME
//           TextFormGlobalScreen(
//             controller: nameCitiesControler,
//             text: 'Nombres',
//             textInputType: TextInputType.name,
//             obscure: false,
//             icon: Icons.map,
//             textCap: TextCapitalization.words,
//           ),
//           const SizedBox(
//             height: 25,
//           ),
//           Container(
//             alignment: Alignment.center,
//             child: Text('Provincia'),
//           ),
//         ],
//       ),
//     );
//   }
// }
