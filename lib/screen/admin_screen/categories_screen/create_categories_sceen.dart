import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/admin_screen/categories_screen/list_categories_screen.dart';
import 'package:kalary_app/witgets/text_form.dart';

class CreateCategoriesScreen extends StatefulWidget {
  CreateCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CreateCategoriesScreen> createState() => _CreateCategoriesScreenState();
}

class _CreateCategoriesScreenState extends State<CreateCategoriesScreen> {
  TextEditingController nameCategoryControlles = TextEditingController();
  String dropdownState = "Activo";
  FirebaseFirestore categoriesInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            const SizedBox(
              height: 220,
            ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Crear Categoría',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormGlobalScreen(
              controller: nameCategoryControlles,
              text: 'Nombre de la Categoría',
              textInputType: TextInputType.name,
              obscure: false,
              icon: Icons.category,
              textCap: TextCapitalization.words,
              maxlines: 1,
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
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text('Guardar'),
                style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 12)),
                onPressed: () {
                  categoriesInstance
                      .collection('categories_db')
                      .doc(nameCategoryControlles.text)
                      .set({
                    'category_name': nameCategoryControlles.text,
                    'category_state': dropdownState.toString()
                  });
                  //VALIDAR
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListCategoriesScreen()),
                  );
                },
              ),
            )
          ],
        ),
      )),
    ));
  }
}
