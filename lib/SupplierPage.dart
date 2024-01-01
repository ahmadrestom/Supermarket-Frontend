import 'package:flutter/material.dart';

class SupplierPage extends StatelessWidget{
  const SupplierPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliers'),
        centerTitle: true,
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/getAllSuppliers');
              },
              child: const Text('Get All Suppliers'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/getSupplier');
              },
              child: const Text('Get a supplier'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/createSupplier');
              },
              child: const Text('Created supplier'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/updateSupplier');
              },
              child: const Text('Update supplier'),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/deleteSupplier');
              },
              child: const Text('Delete supplier'),
            )
          ],
        ),
      ),
    );
  }
}