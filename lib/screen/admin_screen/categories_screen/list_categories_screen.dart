import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalary_app/screen/admin_screen/categories_screen/create_categories_sceen.dart';
import 'package:kalary_app/witgets/text_form.dart';

class ListCategoriesScreen extends StatelessWidget {
  ListCategoriesScreen({Key? key}) : super(key: key);
  FirebaseFirestore categoriesInstace = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Categrías')),
      body: StreamBuilder(
        stream: categoriesInstace.collection('categories_db').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot categoriesSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: EdgeInsets.all(5),
                  child: ListTile(
                    title: Text(
                      categoriesSnapshot['category_name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(categoriesSnapshot['category_state']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              actualizarCategorias(context, categoriesSnapshot);
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteCategorias(categoriesSnapshot);
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
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.plus_one),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateCategoriesScreen(),
              ),
            );
          }),
    );
  }

  //ACTULIZAR CATEGORÍA
  Future<void> actualizarCategorias(
    BuildContext context,
    DocumentSnapshot categorySnapshot,
  ) {
    FirebaseFirestore categoriesInstance = FirebaseFirestore.instance;
    TextEditingController nameCategoryControler =
        TextEditingController(text: categorySnapshot['category_name']);
    String dropdownState = categorySnapshot['category_state'];

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text('Editar Categoría'),
            ),
            content: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: 250,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormGlobalScreen(
                        controller: nameCategoryControler,
                        text: 'Nombre',
                        textInputType: TextInputType.name,
                        obscure: false,
                        icon: Icons.category,
                        textCap: TextCapitalization.words,
                        maxlines: 1,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        alignment: Alignment.center,
                      ),
                      Center(
                        child: DropdownButton(
                          items: <String>['Activo', 'No Activo']
                              .map((String value) {
                            return DropdownMenuItem(
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
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: ElevatedButton(
                          child: Text('Guardar'),
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              onPrimary: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 70,
                                vertical: 12,
                              )),
                          onPressed: () {
                            categoriesInstace
                                .collection('categories_db')
                                .doc(categorySnapshot.id)
                                .set({
                              'category_name': nameCategoryControler.text,
                              'category_state': dropdownState.toString(),
                            });
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  Future<void> deleteCategorias(DocumentSnapshot categorySnapshot) async {
    FirebaseFirestore category = FirebaseFirestore.instance;
    await category
        .collection('categories_db')
        .doc(categorySnapshot.id)
        .delete();
  }
}
