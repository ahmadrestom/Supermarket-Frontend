import 'package:flutter/material.dart';
import 'package:frontend/Models/customer.dart';
import 'package:frontend/Services/customer_service.dart';


class CreateCustomer extends StatefulWidget{
  const CreateCustomer({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateCustomer createState() => _CreateCustomer();
}

class _CreateCustomer extends State<CreateCustomer>{

  //Future<Customer>? customerFuture;

  final TextEditingController _customerName = TextEditingController();
  final TextEditingController _customerPhone = TextEditingController();
  final TextEditingController _customerEmail = TextEditingController();
  final TextEditingController _customerAddress = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Customer'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: _customerName,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter customer name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _customerPhone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Enter customer phone number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _customerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Enter customer email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _customerAddress,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter customer address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: (){
                    String name = _customerName.text;
                    String phone = _customerPhone.text;
                    String email = _customerEmail.text;
                    String address = _customerAddress.text;

                    if(name.isNotEmpty && phone.isNotEmpty && email.isNotEmpty && address.isNotEmpty) {
                      Customer newCustomer = Customer(id: 0,
                          customerName: name,
                          customerPhone: phone,
                          customerAddress: address,
                          customerEmail: email);
                      CustomerService().createCustomer(newCustomer);
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: const Text('Success'),
                              content: const Text('Customer successfully created!'),
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
                  child: const Text('Create new customer')
              )
            ],
          ),
        ),
      ),
    );
  }
}