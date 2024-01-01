import 'package:flutter/material.dart';
import 'package:frontend/Models/category.dart';

import '../Services/category_service.dart';

class GetCategory extends StatefulWidget {
  const GetCategory({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetCategoryState createState() => _GetCategoryState();
}

class _GetCategoryState extends State<GetCategory> {

  final TextEditingController _idController = TextEditingController();

  Future<Category>? categoryFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get a Category'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Category ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int categoryId = int.tryParse(_idController.text) ?? 0;
                if (categoryId != 0) {
                  setState(() {
                    categoryFuture = CategoryService().getCategoryById(categoryId) as Future<Category>?;
                  });
                } else {
                  // Show an error if ID is empty
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please enter a valid category ID.'),
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
              child: const Text('Get Category'),
            ),
            const SizedBox(height: 20),
            FutureBuilder<Category>(
              future: categoryFuture,
              builder: (context, snapshot)
              {
                if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return const CircularProgressIndicator();
                }
                else if(snapshot.hasError)
                {
                  return Text('Error: ${snapshot.error}');
                }
                else if(snapshot.hasData)
                {
                  final category = snapshot.data!;
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Adds rounded corners
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildText('Category ID:', '${category.categoryId}'),
                          _buildText('Category Label:', category.categoryLabel),
                        ],
                      ),
                    ),
                  );
                }
                else
                {
                  return const SizedBox(height: 20,);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
Widget _buildText(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black87),
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(text: value),
        ],
      ),
    ),
  );
}
