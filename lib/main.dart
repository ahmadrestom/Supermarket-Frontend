import 'package:flutter/material.dart';
import 'package:frontend/Category%20CRUD/createCategory.dart';
import 'package:frontend/Category%20CRUD/getAllCategories.dart';
import 'package:frontend/Category%20CRUD/getCategory.dart';
import 'package:frontend/CategoryPage.dart';
import 'package:frontend/Customer CRUD/createCustomer.dart';
import 'package:frontend/Customer CRUD/deleteCustomer.dart';
import 'package:frontend/Customer CRUD/getAllCustomers.dart';
import 'package:frontend/Customer CRUD/getCustomer.dart';
import 'package:frontend/Customer CRUD/updateCustomer.dart';
import 'package:frontend/CustomerPage.dart';
import 'package:frontend/InvoicePage.dart';
import 'package:frontend/ItemPage.dart';

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
      },
    );
  }
}

class _MyHomePageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Supermarket"),
          centerTitle: true,
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/customer');
                  },
                   child: const Text('Customers'),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/item');
                },
                child: const Text('Items'),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/invoice');
                },
                child: const Text('Invoices'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/category');
                },
                child: const Text('Categories'),
              ),
              const SizedBox(height: 20),
            ],
        ),
      ),
    );
  }
}