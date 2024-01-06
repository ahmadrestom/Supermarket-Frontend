import 'package:frontend/Models/item.dart';

class InvoiceItem{
  int invoiceItemId;
  int quantity;
  double subtotal;
  Item item;

  InvoiceItem({required this.invoiceItemId, required this.quantity, required this.subtotal, required this.item});

  Map<String, dynamic> toJson() {
    return {
      'invoice_item_id': invoiceItemId,
      'quantity': quantity,
      'subtotal': subtotal,
      'item': item.toJson(),
    };
  }


  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      invoiceItemId: json['invoice_item_id'] as int,
      quantity: json['quantity'] as int,
      subtotal: (json['subtotal'] as num).toDouble(),
      item: Item.fromJson(json['item'] as Map<String, dynamic>),
    );
  }





}