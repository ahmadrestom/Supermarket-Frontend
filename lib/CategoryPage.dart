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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(6, 20, 6, 10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildCard(
                    context,
                    'Get All Categories',
                    '/getAllCategories',
                    Icons.list,
                    Colors.blue,
                  ),
                  const SizedBox(height: 10),
                  _buildCard(
                    context,
                    'Get a Category',
                    '/getCategory',
                    Icons.search,
                    Colors.green,
                  ),
                  const SizedBox(height: 10),
                  _buildCard(
                    context,
                    'Create Category',
                    '/createCategory',
                    Icons.add,
                    Colors.orange,
                  ),
                  const SizedBox(height: 10),
                  _buildCard(
                    context,
                    'Update Category',
                    '/updateCategory',
                    Icons.edit,
                    Colors.purple,
                  ),
                  const SizedBox(height: 10),
                  _buildCard(
                    context,
                    'Delete Category',
                    '/deleteCategory',
                    Icons.delete,
                    Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCard(BuildContext context, String title, String route, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(6, 20, 6, 0),
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        borderRadius: BorderRadius.circular(15.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          tileColor: color,
          contentPadding: const EdgeInsets.all(16.0),
        ),
      ),
    ),
  );
}