import 'package:flutter/material.dart';
import 'package:frontend/Services/invoice_service.dart';

class DeleteInvoice extends StatelessWidget{

  DeleteInvoice({super.key});

  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Invoice'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: _idController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 16.0),
                decoration: const InputDecoration(
                  labelText: 'Enter Invoice ID',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int invoiceId = int.tryParse(_idController.text) ?? 0;
                if (invoiceId != 0) {
                  InvoiceService().deleteInvoice(invoiceId);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Success'),
                        content: const Text('Invoice deleted successfully'),
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please enter a valid invoice ID.'),
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
              child: const Text('Delete Invoice'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
