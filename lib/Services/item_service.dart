import 'dart:convert';

import 'package:frontend/Models/item.dart';
import 'package:http/http.dart' as http;

class ItemService{
  final String baseUrl = 'http://10.0.2.2:8080/item';

  Future<List<Item>> getItems() async{
    final response = await http.get(Uri.parse(baseUrl));

    if(response.statusCode == 200)
    {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Item.fromJson(data)).toList();
    }
    else
    {
      throw Exception('Failed to load items');
    }
  }

  Future<Item> getItemById(int itemId) async{
    final response = await http.get(Uri.parse('$baseUrl/$itemId'));
    if(response.statusCode == 200){
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Item.fromJson(jsonResponse);
    }else{
      throw Exception('Failed to load item');
    }
  }

  Future<void> createItem(Item item) async{
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson()),

    );

    if(response.statusCode != 200){
      throw Exception('Failed to create item');
    }
  }

  Future<void> updateItem(Item item) async{
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson()),
    );
    if(response.statusCode != 200){
      throw Exception('Failed to update item');
    }
  }

  Future<void> deleteItem(int itemId) async{
    final response = await http.delete(Uri.parse('$baseUrl/$itemId'));

    if(response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }
}