import 'dart:convert';
import 'package:frontend/Models/supplier.dart';
import 'package:http/http.dart' as http;

class SupplierService{
  final String baseUrl = 'http://10.0.2.2:8080/supplier';

  Future<List<Supplier>> getSuppliers() async{
    final response = await http.get(Uri.parse(baseUrl));

    if(response.statusCode == 200)
    {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Supplier.fromJson(data)).toList();
    }
    else
    {
      throw Exception('Failed to load suppliers');
    }
  }

  Future<Supplier> getSupplierById(int supplierId) async{
    final response = await http.get(Uri.parse('$baseUrl/$supplierId'));
    if(response.statusCode == 200){
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Supplier.fromJson(jsonResponse);
    }else{
      throw Exception('Failed to load supplier');
    }
  }

  Future<void> createSupplier(Supplier supplier) async{
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(supplier.toJson()),

    );

    if(response.statusCode != 200){
      throw Exception('Failed to create supplier');
    }
  }

  Future<void> updateSupplier(Supplier supplier) async{
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body: jsonEncode(supplier.toJson()),
    );
    if(response.statusCode != 200){
      throw Exception('Failed to update supplier');
    }
  }

  Future<void> deleteSupplier(int supplierId) async{
    final response = await http.delete(Uri.parse('$baseUrl/$supplierId'));

    if(response.statusCode != 200){
      throw Exception('Failed to delete supplier');
    }
  }
}