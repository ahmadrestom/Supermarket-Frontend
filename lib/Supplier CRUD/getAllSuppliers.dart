import 'package:flutter/material.dart';
import 'package:frontend/Services/supplier_service.dart';

import '../Models/supplier.dart';

class GetAllSuppliers extends StatelessWidget{
  GetAllSuppliers({super.key});

  final Future<List<Supplier>> suppliersFuture = SupplierService().getSuppliers();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get All Suppliers'),
      ),

      body: FutureBuilder<List<Supplier>>(
        future: suppliersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Supplier supplier = snapshot.data![index];
                return Expanded(
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Supplier ID: ${supplier.supplierId}'),
                          const SizedBox(height: 8.0),
                          Text('Supplier Name: ${supplier.supplierName}'),
                          Text('Supplier Phone: ${supplier.supplierPhone}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No suppliers available'));
          }
        },
      ),
    );
  }
}