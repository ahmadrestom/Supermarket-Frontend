import 'package:flutter/material.dart';


import '../Services/customer_service.dart';

class DeleteCustomer extends StatelessWidget{
  DeleteCustomer({super.key});

  final TextEditingController _idController = TextEditingController();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Customer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Customer ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int customerId = int.tryParse(_idController.text) ?? 0;
                if (customerId != 0) {
                  CustomerService().deleteCustomer(customerId);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Done'),
                        content: const Text('Customer deleted successfully'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Show an error if ID is empty
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please enter a valid customer ID.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Delete Customer'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
