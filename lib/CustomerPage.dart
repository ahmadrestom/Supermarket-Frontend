import 'package:flutter/material.dart';

class CustomerPage extends StatelessWidget{
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the customers Page',
        ),
      ),
    );
  }
}