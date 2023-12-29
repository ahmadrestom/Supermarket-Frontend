import 'package:flutter/material.dart';

class CustomerPage extends StatelessWidget{
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        centerTitle: true,
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            ElevatedButton(
            onPressed: (){
              Navigator.pushNamed(context, '/getAllCustomers');
              },
            child: const Text('Get All Customers'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/GetCustomer');
              },
              child: const Text('Get a customer'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/CreateCustomer');
              },
              child: const Text('Created customer'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/UpdateCustomer');
              },
              child: const Text('Update customer'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/DeleteCustomer');
              },
              child: const Text('Delete customer'),
            )
          ],
        ),
      ),
    );
  }
}