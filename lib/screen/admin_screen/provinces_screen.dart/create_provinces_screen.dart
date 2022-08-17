import 'package:flutter/material.dart';
import 'package:kalary_app/witgets/text_form.dart';

class CreateProvincesScreen extends StatefulWidget {
  CreateProvincesScreen({Key? key}) : super(key: key);

  @override
  State<CreateProvincesScreen> createState() => _CreateProvincesScreenState();
}

class _CreateProvincesScreenState extends State<CreateProvincesScreen> {
  final TextEditingController nameProvinceControler = TextEditingController();

  final TextEditingController stateProvinceControler = TextEditingController();

  String dropdownValue = 'Activo';

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
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text('CREAR CIUDAD'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormGlobalScreen(
                controller: nameProvinceControler,
                text: 'Nombre de la ciudad',
                textInputType: TextInputType.name,
                obscure: false,
                icon: Icons.assured_workload_rounded,
                textCap: TextCapitalization.none),
            SizedBox(
              height: 10,
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
                  value: dropdownValue,
                  onChanged: (String? valueIn) {
                    setState(() {
                      dropdownValue = valueIn!;
                    });
                  }),
            )
          ],
        ),
      )),
    ));
  }
}
