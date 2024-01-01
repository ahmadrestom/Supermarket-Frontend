import 'package:flutter/material.dart';
import 'package:frontend/Services/supplier_service.dart';
import '../Models/supplier.dart';

class UpdateSupplier extends StatelessWidget{
  UpdateSupplier({super.key});

  final TextEditingController _supplierId = TextEditingController();
  final TextEditingController _supplierName = TextEditingController();
  final TextEditingController _supplierPhone = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update a supplier'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
              children: [
                Column(
                  children: [
                    TextField(
                      controller: _supplierId,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Enter supplier ID',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _supplierName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Enter supplier name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _supplierPhone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Enter supplier phone number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: (){
                          String stringID = _supplierId.text;
                          int id = int.tryParse(stringID) ?? 0;
                          String name = _supplierName.text;
                          String phone = _supplierPhone.text;

                          if(id != 0 && name.isNotEmpty && phone.isNotEmpty) {
                            Supplier supplier = Supplier(supplierId: id,
                                supplierName: name,
                                supplierPhone: phone,
                               );
                            SupplierService().updateSupplier(supplier);
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: const Text('Success'),
                                    content: const Text('Supplier successfully updated!'),
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
                        child: const Text('Update supplier')
                    )
                  ],
                ),
              ]
          ),
        ),
      ),
    );
  }
}