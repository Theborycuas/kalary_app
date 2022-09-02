import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/admin_screen/admin_page_screen.dart';
import 'package:kalary_app/screen/admin_screen/provinces_screen.dart/list_provinces_screen.dart';
import 'package:kalary_app/witgets/text_form.dart';

class CreateProvincesScreen extends StatefulWidget {
  CreateProvincesScreen({Key? key}) : super(key: key);

  @override
  State<CreateProvincesScreen> createState() => _CreateProvincesScreenState();
}

class _CreateProvincesScreenState extends State<CreateProvincesScreen> {
  final TextEditingController nameProvinceControler = TextEditingController();

  final TextEditingController stateProvinceControler = TextEditingController();

  String dropdownState = 'Activo';
  String dropdownRegion = 'Costa';
  FirebaseFirestore provincesInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 220,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'CREAR PROVINCES',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormGlobalScreen(
                controller: nameProvinceControler,
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
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: Text('Region de la Provincia'),
            ),
            Center(
              child: DropdownButton(
                  items: <String>['Costa', 'Sierra', 'Amazonía', 'Insular']
                      .map<DropdownMenuItem<String>>((String value) {
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
              height: 30,
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
                    //VALIDAR
                  } else {
                    provincesInstance
                        .collection('provinces_db')
                        .doc(nameProvinceControler.text)
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
      )),
    ));
  }
}
