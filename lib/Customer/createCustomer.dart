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
        child: Column(
          children: [
            TextField(
              controller: _customerName,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Enter customer name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _customerPhone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Enter customer phone number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _customerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Enter customer email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _customerAddress,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Enter customer address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: (){
                  String name = _customerName.text;
                  String phone = _customerPhone.text;
                  String email = _customerEmail.text;
                  String address = _customerAddress.text;

                  Customer newCustomer = Customer(id: 0,
                      customerName: name,
                      customerPhone: phone,
                      customerAddress: address,
                      customerEmail: email);

                  CustomerService().createCustomer(newCustomer);
                },
                child: const Text('Create new customer')
            )
          ],
        ),
      ),
    );
  }
}