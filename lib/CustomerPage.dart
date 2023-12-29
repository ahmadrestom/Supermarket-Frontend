import 'package:flutter/material.dart';

class CustomerPage extends StatelessWidget{
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      body:Center(
        child: Column(
          children:[
            ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, '/getAllCustomers');
              },
            child: const Text('Items'),
      )
          ],
        ),
      ),
    );
  }
}