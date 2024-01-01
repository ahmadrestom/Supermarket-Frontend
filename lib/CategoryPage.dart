import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/getAllCategories');
              },
              child: const Text('Get All Categories'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/getCategory');
              },
              child: const Text('Get a category'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/createCategory');
              },
              child: const Text('Created category'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/updateCategory');
              },
              child: const Text('Update category'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/deleteCategory');
              },
              child: const Text('Delete category'),
            )
          ],
        ),
      ),
    );
  }
}