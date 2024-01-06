import 'customer.dart';
import 'invoice_item.dart';

class Invoice {
  final int invoiceId;
  final DateTime invoiceDate;
  final double totalAmount;
  final Customer customer;
  final List<InvoiceItem> invoiceItems;

  Invoice(
      {required this.invoiceId, required this.invoiceDate, required this.totalAmount,
        required this.customer, required this.invoiceItems});


  Map<String, dynamic> toJson() {
    return {
      'invoices_id': invoiceId,
      'invoices_date': invoiceDate,
      'total_amount': totalAmount,
      'customer': customer.toJson(),
      'invoice_items': invoiceItems.map((item) => item.toJson()).toList(),
    };
  }

  factory Invoice.fromJson(Map<String, dynamic> json){
    List<InvoiceItem> invoiceItems =
    (json['invoice_items'] as List<dynamic>).map((item) =>
        InvoiceItem.fromJson(item as Map<String, dynamic>)).toList();
    DateTime parsedDate = DateTime.parse(json['invoices_date'] as String);
    return Invoice(
      invoiceId: json['invoices_id'] as int,
      invoiceDate: parsedDate,
      totalAmount: json['total_amount'] as double,
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
      invoiceItems: invoiceItems,
    );
  }
}