import 'package:flutter/material.dart';
import 'package:frontend/Models/invoice.dart';
import 'package:frontend/Services/invoice_service.dart';
import 'package:intl/intl.dart';


class GetInvoice extends StatefulWidget {
  const GetInvoice({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _GetInvoiceState createState() => _GetInvoiceState();
}

class _GetInvoiceState extends State<GetInvoice> {

  final TextEditingController _idController = TextEditingController();

  Future<Invoice>? invoiceFuture;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get an Invoice using ID'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                    setState(() {
                      invoiceFuture = InvoiceService().getInvoiceById(invoiceId);
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
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
                child: const Text('Get Invoice'),
              ),
              const SizedBox(height: 20),
              FutureBuilder<Invoice>(
                future: invoiceFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final invoice = snapshot.data!;
        
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.receipt_long,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'ID: ${invoice.invoiceId}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(invoice.invoiceDate)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Amount: \$${invoice.totalAmount}'),
                            Text('Customer ID: ${invoice.customer.id}'),
                            Text('Customer Name: ${invoice.customer.customerName}'),
                            const SizedBox(height: 8.0),
                            const Divider(height: 20, thickness: 2,),
                            const Text(
                              'Invoice Items',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 17
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: invoice.invoiceItems.length,
                              itemBuilder: (context, index) {
                                final item = invoice.invoiceItems[index];
                                return ListTile(
                                  title: Text(
                                    'Item ID: ${item.item.itemId}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  subtitle: Text('Item Name: ${item.item.itemName}\nUnit Price: ${item.item.itemPrice}\nQuantity: ${item.quantity}\nSubtotal: ${item.subtotal}\nCategory: ${item.item.category.categoryLabel}'),
                                );
                                },
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox(); // or any other widget you prefer
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}