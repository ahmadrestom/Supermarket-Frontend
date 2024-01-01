import 'package:flutter/material.dart';
import 'package:frontend/Models/supplier.dart';
import 'package:frontend/Services/supplier_service.dart';

class GetSupplier extends StatefulWidget {
  const GetSupplier({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetSupplierState createState() => _GetSupplierState();
}

class _GetSupplierState extends State<GetSupplier> {

  final TextEditingController _idController = TextEditingController();

  Future<Supplier>? supplierFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get a Supplier'),
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
                labelText: 'Enter Supplier ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int supplierId = int.tryParse(_idController.text) ?? 0;
                if (supplierId != 0) {
                  setState(() {
                    supplierFuture = SupplierService().getSupplierById(supplierId);
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please enter a valid supplier ID.'),
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
              child: const Text('Get Supplier'),
            ),
            const SizedBox(height: 20),
            FutureBuilder<Supplier>(
              future: supplierFuture,
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
                  final supplier = snapshot.data!;
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
                          _buildText('Supplier ID:', '${supplier.supplierId}'),
                          _buildText('Supplier Name:', supplier.supplierName),
                          _buildText('Supplier Phone:', supplier.supplierPhone),
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
