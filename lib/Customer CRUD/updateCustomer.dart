import 'package:flutter/material.dart';

import '../Models/customer.dart';
import '../Services/customer_service.dart';

class UpdateCustomer extends StatelessWidget{
  UpdateCustomer({super.key});

  final TextEditingController _customerId = TextEditingController();
  final TextEditingController _customerName = TextEditingController();
  final TextEditingController _customerPhone = TextEditingController();
  final TextEditingController _customerEmail = TextEditingController();
  final TextEditingController _customerAddress = TextEditingController();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update a customer'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Column(
              children: [
                _buildTextField(_customerId, 'Enter Customer ID', Icons.perm_identity, TextInputType.number),
                const SizedBox(height: 20),
                _buildTextField(_customerName, 'Enter Customer Name', Icons.person_2, TextInputType.text),
                const SizedBox(height: 20),
                _buildTextField(_customerPhone, 'Enter Customer Phone Number', Icons.phone, TextInputType.phone),
                const SizedBox(height: 20),
                _buildTextField(_customerEmail, 'Enter Customer Email', Icons.email, TextInputType.emailAddress),
                const SizedBox(height: 20),
                _buildTextField(_customerAddress, 'Enter Customer Address', Icons.location_on_outlined, TextInputType.streetAddress),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: (){
                      String stringID = _customerId.text;
                      int id = int.tryParse(stringID) ?? 0;
                      String name = _customerName.text;
                      String phone = _customerPhone.text;
                      String email = _customerEmail.text;
                      String address = _customerAddress.text;

                      if(id != 0 && name.isNotEmpty && phone.isNotEmpty && email.isNotEmpty && address.isNotEmpty) {
                        Customer customer = Customer(id: id,
                            customerName: name,
                            customerPhone: phone,
                            customerAddress: address,
                            customerEmail: email);
                        CustomerService().updateCustomer(customer);
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: const Text('Success'),
                                content: const Text('Customer successfully updated!'),
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
                    child: const Text('Update customer')
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

Widget _buildTextField(TextEditingController controller, String labelText, IconData icon, TextInputType inputType) {
  return TextFormField(
    controller: controller,
    keyboardType: inputType,
    style: const TextStyle(fontSize: 16),
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
    ),
  );
}