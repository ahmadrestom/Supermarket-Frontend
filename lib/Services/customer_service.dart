import 'dart:convert';

import 'package:frontend/Models/customer.dart';
import 'package:http/http.dart' as http;

class CustomerService{
  final String baseUrl = 'http://10.0.2.2:8080/customer';
  
  Future<List<Customer>> getCustomers() async{
    final response = await http.get(Uri.parse(baseUrl));

    if(response.statusCode == 200)
      {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Customer.fromJson(data)).toList();
      }
    else
      {
        throw Exception('Failed to load customers');
      }
  }

  Future<Customer> getCustomerById(int customerId) async{
    final response = await http.get(Uri.parse('$baseUrl/$customerId'));

    if(response.statusCode != 200){
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Customer.fromJson(jsonResponse);
    }else{
      throw Exception('Failed to load customer');
    }
  }

  Future<void> createCustomer(Customer customer) async{
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(customer.toJson()),
    );

    if(response.statusCode != 200){
      throw Exception('Failed to create customer');
    }
  }

  Future<void> updateCustomer(Customer customer) async{
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body: jsonEncode(customer.toJson()),
    );
    if(response.statusCode != 200){
      throw Exception('Failed to update customer');
    }
  }

  Future<void> deleteCustomer(int customerId) async{
    final response = await http.delete(Uri.parse('$baseUrl/$customerId'));

    if(response.statusCode != 200){
      throw Exception('Failed to delete customer');
    }
  }
}