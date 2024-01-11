import 'package:flutter/material.dart';
import 'package:frontend/Services/invoice_service.dart';
import '../Models/invoice.dart';
import 'package:intl/intl.dart';

class GetInvoicesForCustomer extends StatefulWidget {

  const GetInvoicesForCustomer({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _GetInvoicesForCustomerState createState() => _GetInvoicesForCustomerState();
}

class _GetInvoicesForCustomerState extends State<GetInvoicesForCustomer>{
  Future<List<Invoice>>? invoiceFuture;
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Invoices for a Customer'),
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
                controller: _nameController,
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 16.0),
                decoration: const InputDecoration(
                  labelText: 'Enter Customer Name',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String customerName = _nameController.text;
                setState(() {
                  invoiceFuture = InvoiceService().getInvoicesForCustomer(customerName);
                });
                            },
              child: const Text('Get Invoices'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Invoice>>(
                future: invoiceFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Invoice invoice = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
              
                              },
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
                                      'Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(invoice.invoiceDate!)}',
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
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}