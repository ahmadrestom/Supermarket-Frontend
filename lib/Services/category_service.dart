import 'dart:convert';
import 'package:frontend/Models/category.dart';
import 'package:http/http.dart' as http;

class CategoryService{
  final String baseUrl = 'http://10.0.2.2:8080/category';

  Future<List<Category>> getCategories() async{
    final response = await http.get(Uri.parse(baseUrl));

    if(response.statusCode == 200)
    {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Category.fromJson(data)).toList();
    }
    else
    {
      throw Exception('Failed to load categories');
    }
  }

  Future<Category> getCategoryById(int categoryId) async{
    final response = await http.get(Uri.parse('$baseUrl/$categoryId'));
    if(response.statusCode == 200){
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Category.fromJson(jsonResponse);
    }else{
      throw Exception('Failed to load category');
    }
  }

  Future<void> createCategory(Category category) async{
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(category.toJson()),

    );

    if(response.statusCode != 200){
      throw Exception('Failed to create category');
    }
  }

  Future<void> updateCategory(Category category) async{
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body: jsonEncode(category.toJson()),
    );
    if(response.statusCode != 200){
      throw Exception('Failed to update category');
    }
  }

  Future<void> deleteCategory(int categoryId) async{
    final response = await http.delete(Uri.parse('$baseUrl/$categoryId'));

    if(response.statusCode != 200){
      throw Exception('Failed to delete category');
    }
  }
}