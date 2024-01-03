import 'package:flutter/material.dart';
import 'package:frontend/Models/item.dart';
import 'package:frontend/Services/item_service.dart';

import '../Models/category.dart';
import '../Models/supplier.dart';

class GetItem extends StatefulWidget {
  const GetItem({Key? key}) : super(key: key);

  @override
  _GetItemState createState() => _GetItemState();
}

class _GetItemState extends State<GetItem> {
  final TextEditingController _idController = TextEditingController();
  Future<Item>? itemFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get an Item'),
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
                    labelText: 'Enter Item ID',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  int itemId = int.tryParse(_idController.text) ?? 0;
                  if (itemId != 0) {
                    setState(() {
                      itemFuture = ItemService().getItemById(itemId);
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Please enter a valid item ID.'),
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
                child: const Text('Get Item'),
              ),
              const SizedBox(height: 20),
              FutureBuilder<Item>(
                future: itemFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final item = snapshot.data!;
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildItemDetails(item),
                            const Divider(),
                            _buildCategoryInfo(item.category),
                            const Divider(),
                            _buildSupplierInfo(item.supplier),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemDetails(Item item) {
    return ExpansionTile(
      title: Text(
          'Item ID: ${item.itemId}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.blue,
        ),
      ),
      children: [
        ListTile(
          title: const Text(
            'Name:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            item.itemName,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        ListTile(
          title: const Text(
            'Price:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '\$${item.itemPrice}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.green,
            ),
          ),
        ),
        ListTile(
          title: const Text(
            'Quantity:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${item.itemQuantity}',
            style: TextStyle(
              fontSize: 16, // Font size
              color: item.itemQuantity < 10 ? Colors.red : Colors.black,
            ),
          ),
        ),
      ],

    );
  }

  Widget _buildCategoryInfo(Category category) {
    return ExpansionTile(
      title: Text(
          'Category ID: ${category.categoryId}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.blue,
        ),
      ),
      children: [
        ListTile(
          title: const Text(
            'Label:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            category.categoryLabel,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupplierInfo(Supplier supplier) {
    return ExpansionTile(
      title: Text(
          'Supplier ID: ${supplier.supplierId}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.blue,
        ),
      ),
      children: [
        ListTile(
          title: const Text(
            'Name:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            supplier.supplierName,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        ListTile(
          title: const Text(
            'Phone:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            supplier.supplierPhone,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],

    );
  }
}
