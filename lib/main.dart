import 'package:flutter/material.dart';
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
            ],
        ),
      ),
    );
  }
}