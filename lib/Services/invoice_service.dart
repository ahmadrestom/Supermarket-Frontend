import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/invoice.dart';

class InvoiceService{
  final String baseUrl = 'http://10.0.2.2:8080/invoice';

  Future<List<Invoice>> getInvoices() async{
    final response = await http.get(Uri.parse(baseUrl));

    if(response.statusCode == 200)
    {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Invoice.fromJson(data)).toList();
    }
    else
    {
      throw Exception('Failed to load invoices');
    }
  }

  Future<Invoice> getInvoiceById(int invoiceId) async{
    final response = await http.get(Uri.parse('$baseUrl/$invoiceId'));
    if(response.statusCode == 200){
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Invoice.fromJson(jsonResponse);
    }else{
      throw Exception('Failed to load invoice');
    }
  }

  Future<void> createInvoice(Invoice invoice) async{
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(invoice.toJson()),
    );

    if(response.statusCode != 200){
      throw Exception('Failed to create invoice');
    }
  }

  Future<void> updateInvoice(Invoice invoice) async{
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body: jsonEncode(invoice.toJson()),
    );
    if(response.statusCode != 200){
      throw Exception('Failed to update invoice');
    }
  }

  Future<void> deleteInvoice(int invoiceId) async{
    final response = await http.delete(Uri.parse('$baseUrl/$invoiceId'));

    if(response.statusCode != 200){
      throw Exception('Failed to delete invoice');
    }
  }
}