import 'package:flutter/material.dart';
import 'package:frontend/Services/category_service.dart';
import '../Models/category.dart';


class CreateCategory extends StatefulWidget{
  const CreateCategory({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateCategory createState() => _CreateCategory();
}

class _CreateCategory extends State<CreateCategory>{

  //Future<Customer>? customerFuture;

  final TextEditingController _categoryLabel = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Category'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: _categoryLabel,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter category label',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: (){
                    String label = _categoryLabel.text;

                    if(label.isNotEmpty) {
                      Category category = Category(
                          categoryId: 0,
                          categoryLabel: label
                      );
                      CategoryService().createCategory(category);
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: const Text('Success'),
                              content: const Text('Category successfully created!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          }
                      );

                    }else{
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please fill in the label field'),
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
                  child: const Text('Create new category')
              )
            ],
          ),
        ),
      ),
    );
  }
}