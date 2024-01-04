import 'package:flutter/material.dart';
import 'package:frontend/Models/category.dart';
import 'package:frontend/Models/supplier.dart';
import 'package:frontend/Services/category_service.dart';
import 'package:frontend/Services/item_service.dart';
import 'package:frontend/Services/supplier_service.dart';
import '../Models/item.dart';


class CreateItem extends StatefulWidget{
  const CreateItem({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateItem createState() => _CreateItem();
}

class _CreateItem extends State<CreateItem>{

  final TextEditingController _itemName = TextEditingController();
  final TextEditingController _itemPrice = TextEditingController();
  final TextEditingController _itemQuantity = TextEditingController();

  late Future<List<Category>> categories;
  Category? _selectedCategory;

  late Future<List<Supplier>> suppliers;
  Supplier? _selectedSupplier;

  @override
  void initState(){
    super.initState();
    categories = CategoryService().getCategories();
    suppliers = SupplierService().getSuppliers();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Item'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                _buildTextField(_itemName, 'Item Name', TextInputType.text),
                const SizedBox(height: 20),
                _buildTextField(_itemPrice, 'Item Price', TextInputType.number),
                const SizedBox(height: 20),
                _buildTextField(_itemQuantity, 'Item Quantity', TextInputType.number),
                const SizedBox(height: 20,),



                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                        child: FutureBuilder<List<Supplier>>(
                          future: suppliers,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text('No suppliers available');
                            } else {
                              List<Supplier> supplierList = snapshot.data!;
                              return DropdownButtonFormField<Supplier>(
                                decoration: const InputDecoration(
                                  labelText: 'Select a supplier',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                                ),
                                value: _selectedSupplier,
                                onChanged: (Supplier? newValue) {
                                  setState(() {
                                    _selectedSupplier = newValue;
                                  });
                                },
                                items: supplierList.map<DropdownMenuItem<Supplier>>(
                                      (Supplier value) {
                                    return DropdownMenuItem<Supplier>(
                                      value: value,
                                      child: Text('${value.supplierId} - ${value.supplierName} - ${value.supplierPhone}'),
                                    );
                                  },
                                ).toList(),
                              );
                            }
                          },
                        ),
                      ),
                      FutureBuilder<List<Category>>(
                        future: categories,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Text('No categories available');
                          } else {
                            List<Category> categoryList = snapshot.data!;
                            return DropdownButtonFormField<Category>(
                              decoration: const InputDecoration(
                                labelText: 'Select a category',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                              ),
                              value: _selectedCategory,
                              onChanged: (Category? newValue) {
                                setState(() {
                                  _selectedCategory = newValue;
                                });
                              },
                              items: categoryList.map<DropdownMenuItem<Category>>(
                                    (Category value) {
                                  return DropdownMenuItem<Category>(
                                    value: value,
                                    child: Text('${value.categoryId} - ${value.categoryLabel}'),
                                  );
                                },
                              ).toList(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: (){
                      String name = _itemName.text;
                      double price = double.tryParse(_itemPrice.text) ?? 0;
                      int quantity = int.tryParse(_itemQuantity.text) ?? 0;
        
                      if(name.isNotEmpty && price !=0 && quantity !=0 && _selectedCategory != null && _selectedSupplier!= null){
                        Item newItem = Item(itemId: 0,
                            itemName: name,
                            itemPrice: price,
                            itemQuantity: quantity,
                            category: _selectedCategory!,
                            supplier: _selectedSupplier!,
                        );
                        ItemService().createItem(newItem);
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: const Text('Success'),
                                content: const Text('Item successfully created!'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            }
                        );
        
                      }else{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text('Please fill in all fields.'),
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
                    child: const Text('Create new item')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField(TextEditingController controller, String labelText, TextInputType inputType) {
  return TextFormField(
    controller: controller,
    keyboardType: inputType,
    style: const TextStyle(fontSize: 16),
    decoration: InputDecoration(
      labelText: labelText,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
    ),
  );
}