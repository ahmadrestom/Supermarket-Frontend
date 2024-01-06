import 'package:flutter/material.dart';
import '../Models/invoice.dart';
import '../Models/invoice_item.dart';
import '../Services/invoice_service.dart';
import 'package:intl/intl.dart';

class GetAllInvoices extends StatelessWidget {

  GetAllInvoices({super.key});

  final Future<List<Invoice>> invoicesFuture = InvoiceService().getInvoices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get All Invoices'),
      ),
      body: FutureBuilder<List<Invoice>>(
        future: invoicesFuture,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GetAllInvoiceItems(invoice: invoice),
                          ),
                        );
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
                              'Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(invoice.invoiceDate)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text('Amount: \$${invoice.totalAmount}'),
                            Text('Customer: ${invoice.customer.customerName} (ID: ${invoice.customer.id})'),
                          ],
                        ),
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

class GetAllInvoiceItems extends StatelessWidget {
  final Invoice invoice;

  const GetAllInvoiceItems({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice ID: ${invoice.invoiceId}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Invoice Information'),
            _buildInfoRow('Invoice ID', '${invoice.invoiceId}'),
            _buildInfoRow('Invoice Date', '${invoice.invoiceDate}'),
            _buildInfoRow('Total Amount', '\$${invoice.totalAmount}'),
            const SizedBox(height: 24.0),
            _buildSectionTitle('Customer Details'),
            _buildInfoRow('Customer ID', '${invoice.customer.id}'),
            _buildInfoRow('Name', invoice.customer.customerName),
            _buildInfoRow('Phone', invoice.customer.customerPhone),
            _buildInfoRow('Address', invoice.customer.customerAddress),
            _buildInfoRow('Email', invoice.customer.customerEmail),
            const SizedBox(height: 24.0),
            _buildSectionTitle('Invoice Items'),
            Column(
              children: invoice.invoiceItems
                  .map((item) => _buildInvoiceItemCard(item))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    ),
  );
}

Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value),
      ],
    ),
  );
}

Widget _buildInvoiceItemCard(InvoiceItem item) {
  return Card(
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: ListTile(
      subtitle: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Item Details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4.0),
          Text('Item ID: ${item.item.itemId}'),
          Text('Item Name: ${item.item.itemName}'),
          Text('Unit Price: ${item.item.itemPrice}'),
          Text('Quantity: ${item.quantity}'),
          Text('Subtotal: ${item.subtotal}'),
          Text('Category: ${item.item.category.categoryLabel}'),
          const SizedBox(height: 8.0),
        ],
      ),
    ),
  );
}
