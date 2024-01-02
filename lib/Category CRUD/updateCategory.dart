import 'package:flutter/material.dart';
import '../Models/category.dart';
import '../Services/category_service.dart';

class UpdateCategory extends StatelessWidget{
  UpdateCategory({super.key});

  final TextEditingController _categoryId = TextEditingController();
  final TextEditingController _categoryLabel = TextEditingController();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update category'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Column(
                children: [
                  _buildTextField(_categoryId, 'Enter category ID', Icons.perm_identity, TextInputType.number),
                  const SizedBox(height: 20),
                  _buildTextField(_categoryLabel, 'Enter category label', Icons.label, TextInputType.text),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String stringID = _categoryId.text;
                      int id = int.tryParse(stringID) ?? 0;
                      String label = _categoryLabel.text;

                      if (id != 0 && label.isNotEmpty) {
                        Category category = Category(
                          categoryId: id,
                          categoryLabel: label,
                        );
                        CategoryService().updateCategory(category);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Success'),
                              content: const Text('Category successfully updated!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text('Please fill in all fields.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Update category'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField(TextEditingController controller, String labelText, IconData icon, TextInputType inputType) {
  return TextFormField(
    controller: controller,
    keyboardType: inputType,
    style: const TextStyle(fontSize: 16),
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
    ),
  );
}