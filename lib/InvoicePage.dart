import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget{
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the invoices Page',
        ),
      ),
    );
  }
}