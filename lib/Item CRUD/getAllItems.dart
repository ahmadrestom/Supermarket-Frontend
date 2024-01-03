import 'package:flutter/material.dart';
import 'package:frontend/Models/item.dart';
import 'package:frontend/Services/item_service.dart';

class GetAllItems extends StatelessWidget {


  final Future<List<Item>> itemsFuture = ItemService().getItems();

  GetAllItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get All Items Here'),
      ),
      body: FutureBuilder<List<Item>>(
        future: itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Item item = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    _showItemDetailsDialog(context, item);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Card(
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
                                    Icons.shopping_bag,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'ID: ${item.itemId}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Name: ${item.itemName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text('Price: \$${item.itemPrice}'),
                            Text('Quantity: ${item.itemQuantity}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No items available'));
          }
        },
      ),
    );
  }

  void _showItemDetailsDialog(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Item Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Category ID: ${item.category.categoryId}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Category Name: ${item.category.categoryLabel}',
                style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 15,
              ),
        ),
              const SizedBox(height: 10.0),
              Text(
                  'Supplier ID: ${item.supplier.supplierId}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                  'Supplier Name: ${item.supplier.supplierName}',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
