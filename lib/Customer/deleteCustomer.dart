import 'package:flutter/material.dart';

class DeleteCustomer extends StatelessWidget{
  const DeleteCustomer({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Customer'),
      ),
    );
  }
}