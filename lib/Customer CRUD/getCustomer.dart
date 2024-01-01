import 'package:flutter/material.dart';
import 'package:frontend/Models/customer.dart';
import 'package:frontend/Services/customer_service.dart';

class GetCustomer extends StatefulWidget {
  const GetCustomer({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetCustomerState createState() => _GetCustomerState();
}

class _GetCustomerState extends State<GetCustomer> {

  final TextEditingController _idController = TextEditingController();

  Future<Customer>? customerFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get a Customer'),
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
                  setState(() {
                    customerFuture = CustomerService().getCustomerById(customerId);
                  });
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
              child: const Text('Get Customer'),
            ),
            const SizedBox(height: 20),
              FutureBuilder<Customer>(
                future: customerFuture,
                builder: (context, snapshot)
                {
                  if(snapshot.connectionState == ConnectionState.waiting)
                  {
                    return const CircularProgressIndicator();
                  }
                  else if(snapshot.hasError)
                    {
                      return Text('Error: ${snapshot.error}');
                    }
                  else if(snapshot.hasData)
                    {
                      final customer = snapshot.data!;
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Adds rounded corners
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildText('Customer ID:', '${customer.id}'),
                              _buildText('Name:', customer.customerName),
                              _buildText('Phone:', customer.customerPhone),
                              _buildText('Email:', customer.customerEmail),
                              _buildText('Address:', customer.customerAddress),
                            ],
                          ),
                        ),
                      );
                    }
                  else
                    {
                      return const SizedBox(height: 20,);
                    }
                },
              ),
          ],
        ),
      ),
    );
  }
}
Widget _buildText(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black87),
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const TextSpan(text: ' '),
          TextSpan(text: value),
        ],
      ),
    ),
  );
}
