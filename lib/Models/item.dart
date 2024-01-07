import 'package:frontend/Models/supplier.dart';
import 'package:frontend/Models/category.dart';

class Item{
  final int itemId;
  final String itemName;
  final double itemPrice;
  int itemQuantity;
  final Category category;
  final Supplier supplier;

  Item({required this.itemId, required this.itemName,
        required this.itemPrice, required this.itemQuantity,
        required this.category, required this.supplier});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemId: json['item_id'] as int,
      itemName: json['item_name'] as String,
      itemPrice: json['item_price'] as double,
      itemQuantity: json['item_quantity'] as int,
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      supplier: Supplier.fromJson(json['supplier'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'item_name': itemName,
      'item_price': itemPrice,
      'item_quantity': itemQuantity,
      'category': category.toJson(),
      'supplier': supplier.toJson(),
    };
  }

}