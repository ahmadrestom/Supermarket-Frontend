import 'package:flutter/material.dart';

class ItemPage extends StatelessWidget{
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the items Page',
        ),
      ),
    );
  }
}