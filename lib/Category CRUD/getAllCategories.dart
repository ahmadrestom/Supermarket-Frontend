import 'package:flutter/material.dart';
import 'package:frontend/Models/category.dart';
import 'package:frontend/Services/category_service.dart';


class GetAllCategories extends StatelessWidget{
  GetAllCategories({super.key});

  final Future<List<Category>> categoryFuture = CategoryService().getCategories();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get All Categories Here'),
      ),

      body: FutureBuilder<List<Category>>(
        future: categoryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Category category = snapshot.data![index];
                return Expanded(
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Category ID: ${category.categoryId}'),
                          const SizedBox(height: 8.0),
                          Text('Label: ${category.categoryLabel}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No categories available'));
          }
        },
      ),
    );
  }
}