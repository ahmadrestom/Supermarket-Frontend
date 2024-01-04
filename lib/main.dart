import 'package:flutter/material.dart';
import 'package:frontend/Category%20CRUD/createCategory.dart';
import 'package:frontend/Category%20CRUD/deleteCategory.dart';
import 'package:frontend/Category%20CRUD/getAllCategories.dart';
import 'package:frontend/Category%20CRUD/getCategory.dart';
import 'package:frontend/Category%20CRUD/updateCategory.dart';
import 'package:frontend/CategoryPage.dart';
import 'package:frontend/Customer CRUD/createCustomer.dart';
import 'package:frontend/Customer CRUD/deleteCustomer.dart';
import 'package:frontend/Customer CRUD/getAllCustomers.dart';
import 'package:frontend/Customer CRUD/getCustomer.dart';
import 'package:frontend/Customer CRUD/updateCustomer.dart';
import 'package:frontend/CustomerPage.dart';
import 'package:frontend/InvoicePage.dart';
import 'package:frontend/Item%20CRUD/createItem.dart';
import 'package:frontend/Item%20CRUD/deleteItem.dart';
import 'package:frontend/Item%20CRUD/getAllItems.dart';
import 'package:frontend/Item%20CRUD/getItem.dart';
import 'package:frontend/Item%20CRUD/updateItem.dart';
import 'package:frontend/ItemPage.dart';
import 'package:frontend/Supplier%20CRUD/createSupplier.dart';
import 'package:frontend/Supplier%20CRUD/deleteSupplier.dart';
import 'package:frontend/Supplier%20CRUD/getAllSuppliers.dart';
import 'package:frontend/Supplier%20CRUD/getSupplier.dart';
import 'package:frontend/Supplier%20CRUD/updateSupplier.dart';
import 'package:frontend/SupplierPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supermarket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade300,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => _MyHomePageState(),
        '/customer':(context) => const CustomerPage(),
        '/item': (context)=> const ItemPage(),
        '/invoice':(context)=>const InvoicePage(),
        '/getAllCustomers': (context)=>GetAllCustomers(),
        '/GetCustomer': (context)=> const GetCustomer(),
        '/CreateCustomer': (context)=>  const CreateCustomer(),
        '/UpdateCustomer': (context)=>  UpdateCustomer(),
        '/DeleteCustomer': (context)=>  DeleteCustomer(),
        '/category': (context)=> const CategoryPage(),
        '/getAllCategories': (context)=> GetAllCategories(),
        '/getCategory': (context)=> const GetCategory(),
        '/createCategory': (context)=> const CreateCategory(),
        '/deleteCategory': (context)=> DeleteCategory(),
        '/updateCategory': (context)=> UpdateCategory(),
        '/supplier': (context)=> const SupplierPage(),
        '/getAllSuppliers': (context)=> GetAllSuppliers(),
        '/getSupplier': (context)=> const GetSupplier(),
        '/createSupplier': (context) => const CreateSupplier(),
        '/deleteSupplier': (context) => DeleteSupplier(),
        '/updateSupplier': (context) => UpdateSupplier(),
        '/getAllItems': (context)=> GetAllItems(),
        '/getItem': (context)=> const GetItem(),
        '/deleteItem': (context)=> DeleteItem(),
        '/createItem': (context)=> const CreateItem(),
        '/updateItem': (context)=> const UpdateItem(),
      },
    );
  }
}

class _MyHomePageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Supermarket"),
          centerTitle: true,
    ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10.0),
        mainAxisSpacing: 60.0,
        crossAxisSpacing: 30.0,
        children: [
          _buildCard(context, 'Customers', '/customer', Icons.people, Colors.blue),
          _buildCard(context, 'Items', '/item', Icons.inventory, Colors.green),
          _buildCard(context, 'Invoices', '/invoice', Icons.receipt, Colors.orange),
          _buildCard(context, 'Categories', '/category', Icons.category, Colors.purple),
          _buildCard(context, 'Suppliers', '/supplier', Icons.people_alt, Colors.red),
        ],
      ),
    );
  }
}

Widget _buildCard(BuildContext context, String title, String route, IconData icon, Color color) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, route);
    },
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(0),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 10.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.black.withOpacity(0.3),
                  onTap: () {
                    Navigator.pushNamed(context, route);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
