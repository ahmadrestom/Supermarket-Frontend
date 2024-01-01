import 'package:flutter/material.dart';
import 'package:frontend/Models/customer.dart';
import 'package:frontend/Services/customer_service.dart';

class GetAllCustomers extends StatelessWidget{
  GetAllCustomers({super.key});

  final Future<List<Customer>> customersFuture = CustomerService().getCustomers();

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
        title: const Text('Get All Customers Here'),
      ),

      body: FutureBuilder<List<Customer>>(
        future: customersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Customer customer = snapshot.data![index];
                return Expanded(
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Customer ID: ${customer.id}'),
                          const SizedBox(height: 8.0),
                          Text('Name: ${customer.customerName}'),
                          Text('Email: ${customer.customerEmail}'),
                          Text('Phone: ${customer.customerPhone}'),
                          Text('Address: ${customer.customerAddress}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No customers available'));
          }
        },
      ),
    );
    }
}