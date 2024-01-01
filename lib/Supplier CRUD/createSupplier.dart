import 'package:flutter/material.dart';
import 'package:frontend/Services/supplier_service.dart';

import '../Models/supplier.dart';


class CreateSupplier extends StatefulWidget{
  const CreateSupplier({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateSupplier createState() => _CreateSupplier();
}

class _CreateSupplier extends State<CreateSupplier>{

  //Future<Customer>? customerFuture;

  final TextEditingController _supplierName = TextEditingController();
  final TextEditingController _supplierPhone = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Supplier'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
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
                    String name = _supplierName.text;
                    String phone = _supplierPhone.text;

                    if(name.isNotEmpty && phone.isNotEmpty) {
                      Supplier supplier = Supplier(supplierId: 0,
                          supplierName: name,
                          supplierPhone: phone,
                      );
                     SupplierService().createSupplier(supplier);
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: const Text('Success'),
                              content: const Text('Supplier successfully created!'),
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
                  child: const Text('Create new supplier')
              )
            ],
          ),
        ),
      ),
    );
  }
}